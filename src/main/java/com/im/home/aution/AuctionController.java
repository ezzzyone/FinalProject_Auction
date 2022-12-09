package com.im.home.aution;

import java.io.EOFException;
import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.im.home.members.MembersVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/auction/*")
@Slf4j
public class AuctionController {
	
	
	
	
	@GetMapping("vidu")
	public void viduTest() {
		
	}
	
	
	@GetMapping("chat")
	public void chatTest() {
		log.info("@chatController, chat Get()");
		
	}
	
	
	
	@GetMapping("detail")
	public String getDetail() throws Exception{
		return "auction/detail";
	}
	
	@GetMapping("add")
	public void setAdd() throws Exception{
	
	}
	
	@PostMapping("add")
	public void setAdd(AuctionVO auctionVO) throws Exception{
		
	}
	
	
	@PostMapping("asking")
	@ResponseBody
	public void setAddAskingPrice(AskingPriceVO askingPriceVO) throws Exception{
		
	}
	
	@GetMapping("list")
	public void getList() throws Exception{
		
	}
	
	@GetMapping("nick")
	   @ResponseBody
	   public MembersVO getNick() throws Exception{
		
	      MembersVO membersVO = new MembersVO();
	      
	      
	      
	      
	      return membersVO;
	   }
	
	
	public String getId(Principal principal) throws Exception{
		String a =  principal.getName();
		return a;
	}
	
	
	
	
	
	
}
