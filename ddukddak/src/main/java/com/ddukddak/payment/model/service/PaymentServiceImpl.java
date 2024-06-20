package com.ddukddak.payment.model.service;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.ddukddak.ecommerce.model.dto.Orders;
import com.ddukddak.ecommerce.model.mapper.eCommerceMapper;
import com.ddukddak.payment.model.dto.PaymentDTO;
import com.ddukddak.payment.model.mapper.PaymentMapper;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class PaymentServiceImpl implements PaymentService {
	
	//private final PaymentConfig paymentConfig;
	private final RestTemplate restTemplate;
	private final PaymentMapper mapper;
	private final eCommerceMapper eCommerceMapper;
	
	/**
	 * 토큰 얻기
	 * @throws Exception 
	 */
	@Override
	public String getAccessToken(String impKey, String impSecret, String merchantUid) throws Exception {
		
		String tokenUrl = "https://api.iamport.kr/users/getToken";
		
		// 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
	        
		// 바디 
		Map<String, String> body = new HashMap<>();
        body.put("imp_key", impKey);
        body.put("imp_secret", impSecret);
		
        log.info("토큰 서비스 body : " + body);
	
        try {        	
            // JSON 바디 생성하여 전송해보기
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonBody = objectMapper.writeValueAsString(body);
            
            // HttpEntity 객체 생성
            HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);
        	
            ResponseEntity<String> response = restTemplate.exchange(tokenUrl, HttpMethod.POST, entity, String.class);
            
            log.info("토큰 응답 상태 : {}", response.getStatusCode());
            log.info("토큰 응답 바디 : {}", response.getBody());

            if (response.getStatusCode() == HttpStatus.OK) {
                // 응답 바디를 JSON으로 파싱
                JsonNode root = objectMapper.readTree(response.getBody());

                // access_token 추출
                String accessToken = root.path("response").path("access_token").asText();
                log.info("토큰 서비스 AccessToken 추출 : {}", accessToken);

                return accessToken;
            } else {
                log.error("Failed to get token: {}", response.getStatusCode());
                log.error("Response Body: {}", response.getBody());
                throw new Exception("Failed to get token: " + response.getStatusCode() + " - " + response.getBody());
            }
            
        } catch (HttpClientErrorException e) {
            log.error("HttpClientErrorException: {}", e.getMessage());
            log.error("Response body: {}", e.getResponseBodyAsString());

            // 오더 테이블 STATUS 업데이트
            Map<String, String> map = new HashMap<>();
            map.put("merchantUid", merchantUid);
            map.put("message", "토큰 획득 실패");

            eCommerceMapper.reasonUpdate(map);

            throw new Exception("HttpClientErrorException: " + e.getMessage(), e);
        }
	}

	/**
	 * 사전 검증
	 */
	@Override
	public Map<String, Object> preparePayment(Map<String, Object> params, String accessToken) throws Exception {
		
		log.info("사전 검증 서비스단 토큰 확인 : " + accessToken);
		
	    String prepareUrl = "https://api.iamport.kr/payments/prepare";
	     
	    // 헤더 설정
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    headers.setBearerAuth(accessToken);  // Authorization 헤더에 토큰 추가
	     
	    String merchantUid = (String) params.get("merchant_uid");
	    Object amountObj = params.get("amount");

	    // amount를 무조건 숫자형(Integer)으로 변환해야함(오류 방지)
	    Integer amount = null;
	    if (amountObj instanceof Number) {
	        amount = ((Number) amountObj).intValue();
	    } else {
	        try {
	            amount = Integer.parseInt(amountObj.toString());
	        } catch (NumberFormatException e) {
	            log.error("Invalid amount format: {}", amountObj);
	            throw new IllegalArgumentException("Amount must be a valid number", e);
	        }
	    }

	    // 요청 바디 설정
	    Map<String, Object> body = new HashMap<>();
	    body.put("merchant_uid", merchantUid);
	    body.put("amount", amount);
	    
	    // 타입만 한 번 더 확인 해보기(오류 많이 난 부분)
	    log.info("사전 검증 요청 바디 확인 : amountType={}", amount.getClass().getName());
	    
	    try {
	        ObjectMapper objectMapper = new ObjectMapper();
	        String jsonBody = objectMapper.writeValueAsString(body);
	        
	        // HttpEntity 생성
	        HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);
	        
	        // 요청 보내기
	        ResponseEntity<String> response = restTemplate.postForEntity(prepareUrl, entity, String.class);
	        
	        if (response.getStatusCode() != HttpStatus.OK) {
	            log.error("Failed to prepare payment: {}", response.getStatusCode());
	            log.error("Response Body: {}", response.getBody());
	            throw new Exception("Failed to prepare payment: " + response.getStatusCode());
	        }
	        
	        // 응답 바디를 JSON으로 파싱
	        JsonNode root = objectMapper.readTree(response.getBody());
	        
	        // 에러 코드 확인
	        int code = root.path("code").asInt();
	        if (code != 0) {
	            String message = root.path("message").asText();
	            log.error("Error code: {}, message: {}", code, message);
	            
	            Map<String, String> map = new HashMap<>();
	            map.put("merchantUid", merchantUid);
	            map.put("message", "사전 검증 " + message);
	            
	            eCommerceMapper.reasonUpdate(map);
	            
	            throw new Exception("사전 검증 실패: " + message);
	        }
	        
	        // merchantUid, amount 추출
	        String merchantUidResp = root.path("response").path("merchant_uid").asText();
	        Integer amountResp = root.path("response").path("amount").asInt();
	        
	        Map<String, Object> prepareInfo = new HashMap<>();
	        
	        prepareInfo.put("merchant_uid", merchantUidResp);
	        prepareInfo.put("amount", amountResp);
	        
	        return prepareInfo;
	        
	    } catch (Exception e) {
	        log.error("JSON 직렬화 오류: ", e);
	        throw new RuntimeException("JSON 직렬화 오류: " + e.getMessage(), e);
	    }
		
	}

	// 사후 검증
	@Override	
	public int verifyPayment(Map<String, Object> params, String accessToken) throws Exception {
		log.info("사후 검증 서비스단 params : " + params);
		log.info("사후 검증 서비스단 accessToken : " + accessToken);
		
		String impUidReq = (String) params.get("imp_uid");
		String verifyUrl = "https://api.iamport.kr/payments/" + impUidReq;
		String merchantUid = (String) params.get("merchant_uid");
		
		// 헤더 
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(accessToken);
		
		// 바디
		Map<String, String> body = new HashMap<>();
		body.put("imp_uid", impUidReq);
		
		log.info("사후 검증 요청 바디 확인 : " + body);
		
        // 객체 생성
		HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
		
		ResponseEntity<String> response = restTemplate.postForEntity(verifyUrl, entity, String.class);
		
		log.info("사후 검증 응답 확인 : " + response);
		
        // 응답 바디를 JSON으로 파싱
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode root = objectMapper.readTree(response.getBody());

        // 에러 코드 확인
        int code = root.path("code").asInt();
        if (code != 0) {
            log.error("Error code: " + code + ", message: " + root.path("message").asText());
            
            Map<String, String> map = new HashMap<>();
            map.put("merchantUid", merchantUid);
            map.put("message", "사후 검증 " + root.path("message").asText());
            
            eCommerceMapper.reasonUpdate(map);
            
            return 0;
        }
        
        // 필요한 데이터 추출
        JsonNode responseNode = root.path("response");
        if (responseNode.isMissingNode()) {
            throw new Exception("Invalid response from API");
        }
        
        // DTO 객체 생성 후 응답값 추가
        PaymentDTO paymentDTO = new PaymentDTO();
		
        paymentDTO.setAmount(responseNode.path("amount").asInt()); // 결제 금액
        paymentDTO.setStatus(responseNode.path("status").asText()); // 결제 상태
        paymentDTO.setMerchantUid(responseNode.path("merchant_uid").asText()); // 주문 번호
        paymentDTO.setImpUid(responseNode.path("imp_uid").asText()); // 고유 거래 번호
        paymentDTO.setPayMethod(responseNode.path("pay_method").asText()); // 결제 수단
        paymentDTO.setApplyNum(responseNode.path("apply_num").asText()); // 카드 승인번호
        
        paymentDTO.setBuyerAddr(responseNode.path("buyer_addr").asText()); // 구매자 주소
        paymentDTO.setBuyerEmail(responseNode.path("buyer_email").asText()); // 구매자 이메일
        paymentDTO.setBuyerName(responseNode.path("buyer_name").asText()); // 구매자 이름
        paymentDTO.setBuyerTel(responseNode.path("buyer_tel").asText()); // 구매자 전화번호
        paymentDTO.setBuyerPostcode(responseNode.path("buyer_postcode").asText()); // 구매자 우편번호
        
        paymentDTO.setCancelAmount(responseNode.path("cancel_amount").asInt()); // 취소 금액
        paymentDTO.setCancelReason(responseNode.path("cancel_reason").asText()); // 취소 사유
        
        paymentDTO.setCardCode(responseNode.path("card_code").asText()); // 카드 코드
        paymentDTO.setCardName(responseNode.path("card_name").asText()); // 카드 이름
        paymentDTO.setCardNumber(responseNode.path("card_number").asText()); // 카드 번호
        paymentDTO.setCardQuota(responseNode.path("card_quota").asInt()); // 할부 개월수
        paymentDTO.setCardType(responseNode.path("card_type").asInt()); // 카드 유형
        
        paymentDTO.setCurrency(responseNode.path("currency").asText()); // 통화 코드
        paymentDTO.setCustomData(responseNode.path("custom_data").asText()); // 커스텀 데이터
        paymentDTO.setCustomerUid(responseNode.path("customer_uid").asText()); // 구매자 식별 코드
        paymentDTO.setCustomerUidUsage(responseNode.path("customer_uid_usage").asText()); // 구매자 식별 코드 사용 구분
        paymentDTO.setEscrow(responseNode.path("escrow").asText()); // 에스크로 결제 여부
        
        paymentDTO.setFailedAt(LocalDateTime.ofEpochSecond(responseNode.path("failed_at").asLong(), 0, ZoneOffset.UTC)); // 결제 실패 시간
        
        //paymentDTO.setPaidAt(responseNode.path("paid_at").asText());
        paymentDTO.setPaidAt(LocalDateTime.ofEpochSecond(responseNode.path("paid_at").asLong(), 0, ZoneOffset.UTC)); // 결제 시간
        paymentDTO.setStartedAt(LocalDateTime.ofEpochSecond(responseNode.path("started_at").asLong(), 0, ZoneOffset.UTC)); // 결제 시작 시간
        
        paymentDTO.setName(responseNode.path("name").asText()); // 상품 이름
        
        paymentDTO.setPgId(responseNode.path("pg_id").asText()); // PG사 거래 ID
        paymentDTO.setPgProvider(responseNode.path("pg_provider").asText()); // PG사 제공자
        paymentDTO.setPgTid(responseNode.path("pg_tid").asText()); // PG사 거래 번호
        
        log.info( "paymentDTO : " + paymentDTO);
        log.info("사후 검증 Merchant_UID : " + paymentDTO.getMerchantUid()); 
        
        if (!paymentDTO.getMerchantUid().equals(merchantUid)) {
            throw new Exception("Merchant UID mismatch");
        }
        
        Orders orderInfo = mapper.selectOrder(merchantUid);
        
        if(orderInfo == null) { 
        	
        	return 0;
        }
       
        // 주문 번호, 멤버 번호 세팅 
        paymentDTO.setOrderNo(orderInfo.getOrderNo());
        
        paymentDTO.setMemberNo(orderInfo.getMemberNo());
         
       
        // DTO 넣
        int result = mapper.addPayment(paymentDTO);
        
        return result;
        
        /* 카카오 페이
         paymentDTO : 
         PaymentDTO(
         paymentNo=null, 
         orderNo=null, 
         memberNo=null, 
         impUid=imp_756727441127, 
         merchantUid=ORD-20240620163207140, 
         customerUid=null, 
         customerUidUsage=null, 
         startedAt=2024-06-20T07:32:07, 
         status=paid, 
         failReason=null, 
         failedAt=1970-01-01T00:00, 
         paidAt=2024-06-20T07:32:40, 
         cancelReason=null, 
         cancelAmount=0, 
         cancelledAt=null, 
         amount=219910, 
         currency=KRW, 
         payMethod=point, 
         name=test2, 
         buyerName=신수민, 
         buyerTel=01032920409, 
         buyerEmail=soowagger@gmail.com, 
         buyerPostcode=null, 
         buyerAddr=04540 서울 중구 남대문로 120 3층, 
         pgId=TC0ONETIME, 
         pgTid=T673daf7257c75a5b258, 
         pgProvider=kakaopay, 
         cardCode=null, 
         cardName=null, 
         cardType=0, 
         cardNumber=null, 
         cardQuota=0, 
         applyNum=, 
         customData=null, 
         escrow=false) 
         */
		
		
	}


	/**
	 * 구매 완료 페이지 값 얻어오기
	 */
	@Override
	public PaymentDTO selectPaid(String merchantUid) {
		// TODO Auto-generated method stub
		return mapper.selectPaid(merchantUid);
	}
	
  

}