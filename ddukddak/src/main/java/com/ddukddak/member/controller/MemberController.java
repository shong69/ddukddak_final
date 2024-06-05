package com.ddukddak.member.controller;

import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ddukddak.member.model.dto.Member;
import com.ddukddak.member.model.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("member")
@RequiredArgsConstructor
@Controller
@Slf4j
public class MemberController {

	private final MemberService service;
	
	@GetMapping("login")
	public String memberLogin() {
		

		
		return "member/login";
	}
	

	/** [회원가입] 페이지 이동
	 * @return
	 */
	@GetMapping("signup")
	public String memberSignup() {
		
		return "member/signup";
	}
	
	
	/** [아이디 찾기] 페이지 이동
	 * @return
	 */
	@GetMapping("findId")
	public String memberFindId() {
		return "member/findId";
		
	}
	
	/** [아이디 찾기] 이름, 이메일 일치 여부 확인
	 * @return
	 */
	@PostMapping("memberNMCheck")
	@ResponseBody
	public int memberNMCheck(@RequestBody Member member) {
		
		return service.memberNMCheck(member);
	}
	
	
//	@PostMapping("memberTelCheck")
//	@ResponseBody
//	public int memberTelCheck(@RequestBody String memberTel) {
//		
//		return service.memberTelCheck(memberTel);
//	}
	
	
	/** [아이디 찾기] 결과
	 * @param authType
	 * @return
	 */
	@PostMapping("resultId")
	public String memberResultId(
					@RequestParam Map<String, String> map,
					Model model
										) {
		/* 이메일 찾기 시 파라미터 (매핑, 액션 post -> get 임시 확인)
			http://localhost/member/resultId
			?userType=member
			&authType=email
			&emailNm=%EC%8B%A0%EC%88%98%EB%AF%BC < 신수민
			&memberEmail=soowagger%40gmail.com < @
			&authKey=n6zeyw
			&telNm=
			&memberTel=
			&smsAuthKey=
		*/
		
		/* 휴대폰 찾기 시 파라미터 (매핑, 액션 post -> get 임시 확인)
		 	http://localhost/member/resultId
		 	?userType=member
		 	&authType=tel
		 	&telNm=%EC%8B%A0%EC%88%98%EB%AF%BC
		 	&memberTel=01031235555
		 	&smsAuthKey=123456 
		 */
		
		
        // 파라미터 맵에서 authType과 userType 값을 추출
        String authType = map.get("authType");
        String userType = map.get("userType");
        String emailNm = map.get("emailNm");
        String telNm = map.get("telNm");
		String memberEmail = map.get("memberEmail");
        String memberTel = map.get("memberTel");
		
        // 이메일 찾기 멤버 객체
        Member emailFindMember = new Member();
        emailFindMember.setMemberName(emailNm);
        emailFindMember.setMemberEmail(memberEmail);
        
        // 휴대폰 찾기용 멤버 객체
        Member telFindMember = new Member();
        telFindMember.setMemberName(telNm);
        telFindMember.setMemberTel(memberTel);
        
        // 조회 결과 값 저장할 member 객체
        Member member = new Member();
        
        // 인증 타입이 이메일이면
		if(authType.equals("email")) {
			
			member = service.findIdByEmail(emailFindMember);
			 
		}
		
		// 인증 타입이 휴대폰이면
		if(authType.equals("tel")) {
			member = service.findIdByTel(telFindMember);
		}
		
		
		model.addAttribute("authType", authType);
		model.addAttribute("userType", userType);
		model.addAttribute("memberId", member.getMemberId());
		model.addAttribute("enrollDate", member.getEnrollDate());
		
		return "/common/resultId";
	}
	
	// * 비밀번호 찾기는 common.controller 에서 공통 처리
}
