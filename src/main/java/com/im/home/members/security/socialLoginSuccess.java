package com.im.home.members.security;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizationSuccessHandler;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.im.home.members.MembersMapper;
import com.im.home.members.MembersVO;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class socialLoginSuccess extends SimpleUrlAuthenticationSuccessHandler{
	
	@Autowired
	private MembersMapper membersMapper;
	
	
	//소셜로그인이 성공되면 들어오는 곳
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
			
			log.info("=============소셜 핸들러==========");
			log.info("ididididi :: {} " , authentication.getName());
			log.info("소셜 현재 정보 :: {} " , authentication.getPrincipal());
			
			ModelAndView mv = new ModelAndView();
			MembersVO membersVO = new MembersVO();
			
			authentication.getName();
			
			membersVO.setId(authentication.getName());
			
			int count = 0;
			
			try {
				count = membersMapper.getIdCheck(membersVO);
				membersVO = membersMapper.getMyPage(membersVO);
				log.info("갯 마이페이지 :: {} " , membersVO);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
			
		
			// 추가정보를 입력하지 않았다면 추가정보 입력폼으로 보냄
			if(count == 0) {
				response.sendRedirect("/members/socialAdd");
			}else {	// 추가정보를 입력한 사람이라면 루트로 보냄	
				response.sendRedirect("/");
			}
				
		}
	
	
}
