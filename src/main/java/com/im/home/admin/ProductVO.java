package com.im.home.admin;

import java.util.List;

import com.im.home.members.MembersVO;

import lombok.Data;

@Data
public class ProductVO {
	
	private Long product_num; // 상품 번호
	private Long auction_num; // 경매 번호
	private Long grade_num; // 등급 번호
	private String name; // 상품 명
	private String product_address; // 상품 주소
	private Long quantity; // 수량
	private Long weight; // 중량
	private int sales; // 판매 가능 여부
	private String id; // 낙찰자
	private int stateNum; //배송 상태
	
	private AuctionVO auctionVO;
	
	private MembersVO membersVO;
	private DeliveryStateVO deliveryStateVO;
	private ProductGradeVO productGradeVO;
	private List<ProductFileVO> productFileVOs; // 상품 이미지
}
