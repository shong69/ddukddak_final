package com.ddukddak.myPage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Order {

	private int orderNo; //주문 번호 
	private String orderDate; //주문 날짜
	private String orderStatus; //주문 상태 ('결제대기', '결제완료','구매확정'
	private String MemberNo; //주문 회원 번호
	private int deliveryId; //배송 번호
	private int orderItemNo; //주문 상품 번호
	private int orderQuantity; //주문 상품 개수(같은 상품인 경우)
	private int orderPrice; //주문 상품 가격
	private int productNo; //상품 번호
}
