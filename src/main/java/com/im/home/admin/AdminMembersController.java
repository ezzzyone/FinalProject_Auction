package com.im.home.admin;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JacksonAnnotation;
import com.im.home.members.MembersVO;
import com.im.home.util.AdminPager;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/kdy/*")
@Slf4j
public class AdminMembersController {
	
	@Autowired AdminMembersService adminMembersService;

	//main관리자 page
	@GetMapping("adminPage")
	public ModelAndView adminPage(MembersVO membersVO, AdminMembersVO adminMembersVO, MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.getTotalMembers(membersVO);
		List<AdminMembersVO> ar = adminMembersService.getAdminPageInquiryList(adminMembersVO);
		int totalInquiry = adminMembersService.getTotalInquiry(adminMembersVO);
		int totalMembersBlack = adminMembersService.getTotalBlack(membersVO);
		int inquiryNoResponse = adminMembersService.getTotalInquiryNo(adminMembersVO);
		int reportNoResponse = adminMembersService.getTotalReport(membersReportVO);
		mv.addObject("inquiryNoResponse", inquiryNoResponse);
		mv.addObject("totalInquiry", totalInquiry);
		mv.addObject("totalMembersBlack", totalMembersBlack);
		mv.addObject("reportNoResponse", reportNoResponse);
		mv.addObject("adminInquiryList", ar);
		mv.addObject("result", result);
		return mv;
	}
	//회원 조회
	@GetMapping("memberList")
	public ModelAndView getAdminMembersList(AdminPager adminPager, MembersVO membersVO, Authentication authentication)throws Exception{
		ModelAndView mv = new ModelAndView();
		log.info("===========dsafdsafdasfdsa===========");
		log.info("ddddddd :: {} ", authentication.getPrincipal());
		log.info("eeeeeeeeeee :: {} ", membersVO.getId());
		membersVO.setId(authentication.getPrincipal().toString());
		int result = adminMembersService.getTotalMembers(membersVO);
		List<MembersVO> membersVOs =  adminMembersService.getAdminMembersList(adminPager);
		mv.addObject("membersVO", membersVOs);
		mv.addObject("pager", adminPager);
		mv.addObject("result", result);
		mv.setViewName("/kdy/memberList");
		return mv;
	};
	//memberList balck
	@GetMapping("black")
	public ModelAndView setBlack(MembersVO membersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int black = adminMembersService.setBlack(membersVO);
		mv.addObject("black", black);
		mv.setViewName("redirect:./memberList");
		return mv;
	}
	//memberList blackC
	@GetMapping("blackC")
	public ModelAndView setBlackC(MembersVO membersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int blackCancel = adminMembersService.setBlackC(membersVO);
		mv.addObject("blackCancel", blackCancel);
		mv.setViewName("redirect:./memberList");
		return mv;
	}
	//1대1문의
	@GetMapping("inquiryList")
	public ModelAndView getInquiryList(AdminPager adminPager, AdminMembersVO adminMembersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<AdminMembersVO> ar = adminMembersService.getInquiryList(adminPager);
		int totalInquiry = adminMembersService.getTotalInquiry(adminMembersVO);
		int totalInquiryNo = adminMembersService.getTotalInquiryNo(adminMembersVO);
		int totalInquiryYes = adminMembersService.getTotalInquiryYes(adminMembersVO);
		mv.addObject("totalInquiry", totalInquiry);
		mv.addObject("totalInquiryNo", totalInquiryNo);
		mv.addObject("totalInquiryYes", totalInquiryYes);
		mv.addObject("inquiryList", ar);
		mv.addObject("pager", adminPager);
		mv.setViewName("kdy/inquiryList");
		return mv;
	}
	//응답하지 않은 1대1문의 리스트
	@GetMapping("inquiryNoResponseList")
	public ModelAndView getInquiryNoResponseList(AdminPager adminPager, AdminMembersVO adminMembersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<AdminMembersVO> ar = adminMembersService.getInquiryNoResponseList(adminPager);
		int totalInquiryNo = adminMembersService.getTotalInquiryNo(adminMembersVO);
		mv.addObject("totalInquiryNo", totalInquiryNo);
		mv.addObject("inquiryNoResponseList", ar);
		mv.addObject("pager", adminPager);
		return mv;
	}
	//응답 완효한 1대1
//	1대1 detail
	@GetMapping("inquiryDetail")
	public ModelAndView getInquiryDetail(AdminMembersVO adminMembersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		adminMembersVO = adminMembersService.getInquiryDetail(adminMembersVO);
		mv.addObject("inquiryDetail", adminMembersVO);
		mv.setViewName("kdy/inquiryDetail");
		return mv;
	}
	//회원 디테일
	@GetMapping("membersDetail")
	public ModelAndView getAdminMembersDetail(AdminMembersVO adminMembersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		adminMembersVO = adminMembersService.getAdminMembersDetail(adminMembersVO);
		mv.addObject("membersDetail", adminMembersVO);
		mv.setViewName("kdy/membersDetail");
		return mv;
	}
//	//1대1문의
	@GetMapping("inquiryRequest")
	public String setInquiryRequest(AdminMembersVO adminMembersVO, Principal principal)throws Exception{
		adminMembersVO.setId(principal.getName());	
		return "kdy/inquiryRequest";
	}
	//1대1문의
	@PostMapping("inquiryRequest")
	public ModelAndView setInquiryRequest(AdminMembersVO adminMembersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setInquiryRequest(adminMembersVO);
//	log.info("아이디 -->> {}", principal.getName());
		mv.addObject("inquiryRequestResult", result);
		mv.setViewName("redirect:../");
		return mv;
	}
	//1대1문의 응답
	@GetMapping("inquiryResponse")
	public String setInquiryResponse(AdminMembersVO adminMembersVO, InquiryResponseVO inquiryResponseVO)throws Exception{
		 inquiryResponseVO.setInquiry_num(adminMembersVO.getInquiry_num());
		return "kdy/inquiryList";
	}
	//1대1문의 응답
	@PostMapping("inquiryResponse")
	public ModelAndView setInquiryResponse(InquiryResponseVO InquiryResponseVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setInquiryResponse(InquiryResponseVO);
		mv.addObject("inquiryResponseResult", result);
		mv.setViewName("redirect:../kdy/inquiryList");
		return mv;
	}
	//신고 요청
	@GetMapping("reportRequest")
	public String setReportRequest(MembersReportVO membersReportVO, Principal principal)throws Exception{
		membersReportVO.setId(principal.getName());
		log.info("memberReportId =======>>>>>>> {}", principal.getName());
		return "kdy/reportRequest";
	}
	//신고요청
	@PostMapping("reportRequest")
	public ModelAndView setReportRequest(MembersReportVO membersReportVO, MultipartFile files)throws Exception{
		ModelAndView mv = new ModelAndView();
		log.info("report_num ---->>>>> {}", membersReportVO.getReport_num());
		
		int result = adminMembersService.setRepoertRequest(membersReportVO, files);
		int blackResult = adminMembersService.setBlackWaiting(membersReportVO);
		mv.addObject("reportRequest", result);
		mv.addObject("memberResult", blackResult);
		mv.setViewName("redirect:../");
		return mv;
	}
	//신고 리스트
	@GetMapping("report")
	public ModelAndView getReportList(AdminPager adminPager, MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<MembersReportVO> ar = adminMembersService.getReportList(adminPager);
		int result = adminMembersService.getTotalReport(membersReportVO);
		mv.addObject("reportList", ar);
		mv.addObject("totalReport", result);
		mv.addObject("pager", adminPager);
		mv.setViewName("/kdy/report");
		return mv;
	}
	//신고 detail
	@GetMapping("reportDetail")
	public ModelAndView getReportDetail(MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		membersReportVO= adminMembersService.getReportDetail(membersReportVO);
		log.info("idid-->>{}", membersReportVO.getId());
		mv.addObject("reportDetail", membersReportVO);
		mv.setViewName("kdy/reportDetail");
		return mv;
	}
	//신고 요청 거절
	@GetMapping("responseReportNo")
	public ModelAndView setResponseResportNo(MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int memberResult = adminMembersService.setBlackCancel(membersReportVO); 
		int result = adminMembersService.setResponseReportNo(membersReportVO);
		mv.setViewName("redirect:./report");
		return mv;
	}
	@GetMapping("responseReportOk")
	public ModelAndView setResponseReportOk(MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setResponseReportOk(membersReportVO);
		mv.setViewName("redirect:./report");
		return mv;
	}
	//블랙리스트
	@GetMapping("memberBlackList")
	public ModelAndView memberBlackList(AdminPager adminPager, MembersVO membersVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<MembersReportVO> ar = adminMembersService.getBlackList(adminPager);
		int totalMembersBlack = adminMembersService.getTotalBlack(membersVO);
		int BlackC = adminMembersService.setBlackC(membersVO);
		mv.addObject("blackc", BlackC);
		mv.addObject("totalMembersBlack", totalMembersBlack);
		mv.addObject("blackList", ar);
		mv.addObject("pager", adminPager);
		return mv;
	}
	//블랙 회원 디테일
	@GetMapping("blackDetail")
	public ModelAndView getBalckDetail(MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		 List<MembersReportVO> ar = adminMembersService.getBalckDetail(membersReportVO);
		 log.info("arararararararararar ==>> {}", ar);
		 log.info("ar(1)==>> {}", ar.get(0).getReport_id());
		mv.addObject("blackDetail", ar);
		return mv;
	}
	//블랙 해제
	@GetMapping("balckCancel")
	public ModelAndView setBlackCancel(MembersReportVO membersReportVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setBlackCancel(membersReportVO);
		int haha = adminMembersService.setResponseReportNo(membersReportVO);
		mv.setViewName("redirect:./memberBlackList");
		return mv;
	}
	//공지사항 등록
	@GetMapping("cNotice")
	public String setCompanyNotice(CompanyNoticeVO companyNoticeVO, Principal principal)throws Exception{
		companyNoticeVO.setId(principal.getName());
		return "kdy/cNotice";
	}
	//공지사항 등록
	@PostMapping("cNotice")
	public ModelAndView setCompanyNotice(CompanyNoticeVO companyNoticeVO, ModelAndView mv)throws Exception{
		int result = adminMembersService.setCompanyNotice(companyNoticeVO);
		mv.addObject("result", result);
		mv.setViewName("redirect:../kdy/cNoticeList");
		return mv;
	}
	//공지사항 리스트
	@GetMapping("cNoticeList")
	public ModelAndView getCompanyNoticeList(AdminPager adminPager)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<CompanyNoticeVO> ar = adminMembersService.getCompanyNoticeList(adminPager);
		mv.addObject("pager", adminPager);
		mv.addObject("noticeList", ar);
		return mv;
	}
	//공지사항detail
	@GetMapping("noticeDetail")
	public ModelAndView getNoticeDetail(CompanyNoticeVO companyNoticeVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		companyNoticeVO = adminMembersService.getNoticeDetail(companyNoticeVO);
		adminMembersService.setHit(companyNoticeVO);
		mv.addObject("noticeDetail", companyNoticeVO);
		return mv;
	}
	//공지사항 수정
	@GetMapping("noticeUpdate")
	public ModelAndView setNoticeUpdate(CompanyNoticeVO companyNoticeVO, ModelAndView mv)throws Exception{
		companyNoticeVO = adminMembersService.getNoticeDetail(companyNoticeVO);
		mv.addObject("noticeUpdate", companyNoticeVO);
		return mv;
	}
	//공지사항 수정
	@PostMapping("noticeUpdate")
	public ModelAndView setNoticeUpdate(CompanyNoticeVO companyNoticeVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result =  adminMembersService.setNoticeUpdate(companyNoticeVO);
		mv.setViewName("redirect:./noticeDetail?notice_num="+companyNoticeVO.getNotice_num());
		return mv;
	}
	//공지사항 삭제
	@GetMapping("noticeDelete")
	public ModelAndView setNoticeDelete(CompanyNoticeVO companyNoticeVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setNoticeDelete(companyNoticeVO);
		mv.setViewName("redirect:./cNoticeList");
		return mv;
	}
	//판매 품목
	@GetMapping("saleTypeList")
	public ModelAndView getProductList(AdminPager adminPager)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<ProductVO> ar = adminMembersService.getProductList(adminPager);
		log.info("리스트 111111111111 :: {} ", ar);
		Long result = adminMembersService.getProductCount(adminPager);
		mv.addObject("result", result);
		mv.addObject("proList", ar);
		mv.addObject("pager", adminPager);
		return mv;
	}
	//상품 등록
	@GetMapping("productAdd")
	public String setProductAdd(ProductVO productVO)throws Exception{
		return "kdy/productAdd";
	}
	//상품 등록
	@PostMapping("productAdd")
	public ModelAndView setProductAdd(ProductVO productVO, ModelAndView mv, MultipartFile files)throws Exception{
		int result = adminMembersService.setProductAdd(productVO, files);
			
		mv.addObject("result", result);
		mv.setViewName("redirect:../kdy/saleTypeList");

		return mv;
	}
	//상품 detail
	@GetMapping("productDetail")
	public ModelAndView getProductDetail(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		productVO = adminMembersService.getProductDetail(productVO);
		mv.addObject("productVO", productVO);
		return mv;
	}
	// 상품 판매 가능 여부
	@GetMapping("productHold")
	public ModelAndView setProductHold(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setProductHold(productVO);
		mv.setViewName("redirect:./productDetail?product_num="+productVO.getProduct_num());
		return mv;
	}
	//배송 상태
	@GetMapping("deliveryUpdate")
	public ModelAndView setDeliveryStateUpdate(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setDeliveryStateUpdate(productVO);
		mv.setViewName("redirect:./productDetail?product_num="+productVO.getProduct_num());
		return mv;
	}
	@GetMapping("deliverySuccess")
	public ModelAndView setDeliverySuccess(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setDeliverySuccess(productVO);
		mv.setViewName("redirect:./deliverySelect?product_num="+productVO.getProduct_num());
		return mv;
	}
	//상품 등급 수정
	@GetMapping("productGrade")
	public ModelAndView setProductGrade(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setProductGrade(productVO);
		mv.setViewName("redirect:./productDetail?product_num="+productVO.getProduct_num());
		return mv;
	}
	//경매 시작
	@GetMapping("auctionAdd")
	public String setAuctionAdd(AuctionVO auctionVO, Principal principal)throws Exception{
		auctionVO.setId(principal.getName());
		return "kdy/auctionAdd";
	}
	//경매 시작
	@PostMapping("auctionAdd")
	public ModelAndView setAuctionAdd(AuctionVO auctionVO, ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = adminMembersService.setAuctionAdd(auctionVO);
		mv.addObject("auctionAdd", result);
		mv.setViewName("redirect:./productDetail?product_num="+productVO.getProduct_num());
		return mv;
	}
	//판매내역
	@GetMapping("saleList")
	public ModelAndView getSaleList(AdminPager adminPager)throws Exception{
		ModelAndView mv = new ModelAndView();
		List<ProductVO> ar = adminMembersService.getSaleList(adminPager);
		mv.addObject("list", ar);
		mv.addObject("pager", adminPager);
		return mv;
	}
	//판매내역 detail
	@GetMapping("saleDetail")
	public ModelAndView getSaleDetail(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		productVO = adminMembersService.getSaleDetail(productVO);
		mv.addObject("saleDetail", productVO);
		return mv;
	}
	//배송 현황
	@GetMapping("deliverySelect")
	public ModelAndView getDelivery(ProductVO productVO)throws Exception{
		ModelAndView mv = new ModelAndView();
		productVO = adminMembersService.getDeliverySelect(productVO);
		mv.addObject("delivery", productVO);
		return mv;
	}
}
