package com.im.home.admin;

import java.security.Principal;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.im.home.members.MembersVO;
import com.im.home.util.AdminPager;


@Mapper
public interface AdminMembersMapper {
	
	//메인페이지 총 회원 수
	public Integer getTotalMembers(MembersVO membersVO)throws Exception;
	//메인 관리자페이지 1대1 5개 리스트
	public List<AdminMembersVO> getAdminPageInquiryList(AdminMembersVO adminMembersVO)throws Exception;
	//총 1대1문의 글 
	public Integer getTotalInquiry(AdminMembersVO adminMembersVO)throws Exception;
	//1대1 문의
	public int setInquiryRequest(AdminMembersVO adminMembersVO)throws Exception;
	//1대1문의 응답
	public int setInquiryResponse(InquiryResponseVO inquiryResponseVO)throws Exception; 
	//1대1 리스트
	public List<AdminMembersVO> getInquiryList(AdminPager adminPager)throws Exception;
	//1대1문의 detailPage
	public AdminMembersVO getInquiryDetail(AdminMembersVO adminMembersVO)throws Exception;
	//1대1 리스트 pager에 필요한 count
	public Long getInquiryRequestCount(AdminPager adminPager)throws Exception;
	//응답하지 않은 1대1문의 페이징 카운트
	public Long getNoInquiryResponseCount(AdminPager adminPager)throws Exception;
	//신고요청 페이징 카운트
	public Long getReportCount(AdminPager adminPager)throws Exception;
	//블랙 리스트 페이징 카운트
	public Long getBlackMembersCount(AdminPager adminPager)throws Exception;
	//응답하지 않은 1대1문의 리스트
	public List<AdminMembersVO> getInquiryNoResponseList(AdminPager adminPager)throws Exception;
	//응답하지 않은 1대1문의
	public Integer getTotalInquiryNo(AdminMembersVO adminMembersVO)throws Exception;
	//응답완료한 1대1 문의
	public Integer getTotalInquiryYes(AdminMembersVO adminMembersVO)throws Exception;
	//회원 리스트
	public List<MembersVO> getAdminMembersList(AdminPager adminPager) throws Exception;	
	//회원 리스트 pager에 필요한 count
	public Long getAdminMembersCount(AdminPager adminPager)throws Exception;
	//회원 detail
	public AdminMembersVO getAdminMembersDetail(AdminMembersVO adminMembersVO)throws Exception;
	//신고 요청
	public int setRepoertRequest(MembersReportVO membersReportVO)throws Exception;
	//신고 파일
	public int setReportFileAdd(ReportFileVO reportFileVO)throws Exception;
	//신고 요청 대기
	public int setBlackWaiting(MembersReportVO membersReportVO)throws Exception;
	//신고 요청 건 수
	public Integer getTotalReport(MembersReportVO membersReportVO)throws Exception;
	//신고 요청 리스트
	public List<MembersReportVO> getReportList(AdminPager adminPager)throws Exception;
	//신고 요청 디테일
	public MembersReportVO getReportDetail(MembersReportVO membersReportVO)throws Exception;
	//신고 요청 거절
	public int setResponseReportNo(MembersReportVO membersReportVO)throws Exception;
	//신고 요청 승인
	public int setResponseReportOk(MembersReportVO membersReportVO)throws Exception;
	//블랙 리스트
	public List<MembersReportVO> getBlackList(AdminPager adminPager)throws Exception;
	//블랙 회원 수
	public Integer getTotalBlack(MembersVO membersVO)throws Exception;
	//블랙 회원 디테일
	public List<MembersReportVO> getBlackDetail(MembersReportVO membersReportVO)throws Exception;
	//블랙 해제
	public int setBlackCancel(MembersReportVO membersReportVO)throws Exception;
	//회원detail에서 블랙
	public int setBlack(MembersVO membersVO)throws Exception;
	//회원detail에서 블랙해제
	public int setBlackC(MembersVO membersVO)throws Exception;
	//블랙회원 입구 컷	
	public MembersVO getMemberBlack(MembersVO membersVO)throws Exception;
	//공지사항 등록
	public int setCompanyNotice(CompanyNoticeVO companyNoticeVO)throws Exception;
	//공지사항 리스트
	public List<CompanyNoticeVO> getCompanyNoticeList(AdminPager adminPager)throws Exception;
	//공지사항 리스트 카운트
	public Long getNoticeCount(AdminPager adminPager)throws Exception;
	//공지사항 detail
	public CompanyNoticeVO getNoticeDetail(CompanyNoticeVO companyNoticeVO)throws Exception;
	//공지사항 수정
	public int setNoticeUpdate(CompanyNoticeVO companyNoticeVO)throws Exception;
	//공지사항 삭제
	public int setNoticeDelete(CompanyNoticeVO companyNoticeVO)throws Exception;
	//공지사항 조회수
	public int setHit(CompanyNoticeVO companyNoticeVO)throws Exception;
	//상품 등록
	public int setProductAdd(ProductVO productVO)throws Exception;
	//상품 이미지
	public int setProductFileAdd(ProductFileVO productFileVO)throws Exception;
	//상품 리스트
	public List<ProductVO> getProductList(AdminPager adminPager) throws Exception;
	//상품 수, 페이징
	public Long getProductCount(AdminPager adminPager)throws Exception;
	//상품 detail
	public ProductVO getProductDetail(ProductVO productVO)throws Exception;
	//상품 보류, 판매, 매진
	public int setProductHold(ProductVO productVO)throws Exception;
	//상품 등급 수정
	public int setProductGrade(ProductVO productVO)throws Exception;
	//경매 시작
	public int setAuctionAdd(AuctionVO auctionVO)throws Exception;
	//배송 상태
	public int setDeliveryStateUpdate(ProductVO productVO)throws Exception;
	public int setDeliverySuccess(ProductVO productVO)throws Exception;
	//판매 내역
	public List<ProductVO> getSaleList(AdminPager adminPager)throws Exception;
	//판매 내역 수
	public Long getSaleCount(AdminPager adminPager)throws Exception;
	//판매내역 detail
	public ProductVO getSaleDetail(ProductVO productVO)throws Exception;
	//배송 현황
	public ProductVO getDeliverySelect(ProductVO productVO)throws Exception;
}
