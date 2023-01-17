package com.im.home.auction;


import java.security.Principal;
import java.util.List;

import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.im.home.admin.AuctionVO;
import com.im.home.admin.ProductVO;
import com.im.home.util.ProductPager;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/auction/*")
@Slf4j
public class AuctionController {
	
	@Autowired
	private AuctionService auctionService;
	
	
	@GetMapping("live")
	public String getLive(Model model,Principal principal) {
		
		if(principal == null) {
			return "redirect:/";
		}
		
		model.addAttribute("id", principal.getName());
		
		return "auction/live";
	}
	
	
	
	
	@GetMapping("chat")
	public ModelAndView chatTest(Principal principal, AuctionVO auctionVO) {						
		ModelAndView mv = new ModelAndView();
		//로그인 안했으면 로그인페이지로 이동
		if(principal == null) {
			mv.setViewName("redirect:/members/login");
			return mv;
		}
		
		log.info(" 프린시플 : {}", principal);
		
		log.info(" 진행중인 경매 번호 : {}", auctionVO);
		
		ProductVO productVO = auctionService.getAuctionDetail(auctionVO);
		
		
		
		mv.addObject("member", principal.getName());
		mv.addObject("vo", productVO);
		mv.setViewName("auction/chat");
		return mv;
		
	}
	
	
	// 현재 진행중인 방송 있는 지 확인
	@GetMapping("ing")
	@ResponseBody
	public Long getIngBroadcasting() {
		
		AuctionVO auctionVO = auctionService.getIngBroadcasting();
		if(auctionVO == null) {
			return null;
		}else {
			return auctionVO.getAuction_num();
		}
		
		
	}
	
	// 경매 시작 버튼 update
	@PostMapping("change")
	@ResponseBody
	public int setUpdateIng(AuctionVO auctionVO) {
		
		//int result = auctionService.setUpdateIng(auctionVO);
		
		return 1;
		
	}
	
	
	//경매 종료 버튼
	@PostMapping("terminate")
	@ResponseBody
	public String setTerminateAuction(ProductVO productVO, AuctionVO auctionVO) {
		
		log.info("프로덕트 vo : {}", productVO.getId());
		log.info("옥션 vo 최종 낙찰가 : {}", auctionVO.getAward());
		log.info("옥션 vo 아이디 : {}", auctionVO.getId());
		
//		// Product 테이블 id update
//		auctionService.setUpdateWinner(productVO);
//		
//		// Auction 테이블 award 업데이트
//		auctionService.setUpdateAward(auctionVO);
//		
//		// Members 테이블 포인트 - 업데이트
//		auctionService.setUpdatePointMinus(auctionVO);
		
		return productVO.getId();
		
	}
	
	@GetMapping("getmyproduct")
	public ModelAndView getMyProduct(ProductPager productPager, Principal principal) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		if(principal == null) {
			mv.setViewName("redirect:/");
			return mv;
		}
		
		
		productPager.setId(principal.getName());
		
		List<ProductVO> productVOs = auctionService.getMyProduct(productPager);
		
		mv.addObject("list", productVOs);
		mv.addObject("pager", productPager);		
		mv.setViewName("auction/myproduct");
		
		return mv;
	}
	
	
	
	
	
}
