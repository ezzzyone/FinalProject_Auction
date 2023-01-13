package com.im.home.members;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MembersSocialService extends DefaultOAuth2UserService{
	
	@Autowired
	private MembersMapper membersMapper;
	
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		
		log.info("===========소셜 로그인을 시도중입니다===========");
		log.info("UserRequest : {} ", userRequest);
		log.info("AccessTocken : {} ", userRequest.getAccessToken());
		log.info("ClientRegistration : {} ", userRequest.getClientRegistration());
		log.info("client어쩌구 :: {} " , userRequest.getClientRegistration().getRegistrationId());
		
		String social = userRequest.getClientRegistration().getRegistrationId();
		log.info("Social : {} ", social);

		OAuth2User oAuth2User = super.loadUser(userRequest);	
		
		//소셜이 네이버냐 카카오냐를 판별
		if(social.equals("kakao")) {
			oAuth2User = this.socailKakaoJoinCheck(userRequest);
		}else if(social.equals("naver")) {
			oAuth2User = this.socialNaverJoinCheck(userRequest);
		}
		
		return oAuth2User;
	}
	
	//카카오 소셜로그인
	private OAuth2User socailKakaoJoinCheck(OAuth2UserRequest userRequest) {
		OAuth2User oAuth2User = super.loadUser(userRequest);
		
		log.info("************** 사용자 정보 *************");
		log.info("Name : {} ", oAuth2User.getName());
		log.info("Attributes : {} " , oAuth2User.getAttributes());
		log.info("auth :: {} " , oAuth2User.getAuthorities());
		
		Map<String, Object> map = oAuth2User.getAttributes();
		
		//key들 꺼내기
		Iterator<String> keys = map.keySet().iterator();
		
		while(keys.hasNext()) {	//열거한 후 다음게 있냐고 물어봄
			String key = keys.next();
			
			log.info("KEY ==>> {} " , key);
			
		}
		
		
		log.info("ClassName : {} " , oAuth2User.getAttribute("properties").getClass());
		
		Map<String, String> lm = oAuth2User.getAttribute("properties");
		Map<String, Object> ks = oAuth2User.getAttribute("kakao_account");
		
		
		
		
		MembersVO membersVO = new MembersVO();
		
		membersVO.setId(oAuth2User.getName());
		
		//회원가입 유무
		int count = 0;
		
		try {
			count = membersMapper.getIdCheck(membersVO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		log.info("소셜서비스에서 카카오 count :: {} " , count);
		//count 가 0이면 회원가입 안된거 가짜로그인 진행
		if(count == 0) {
			

			
			//pw가 없으므로 비워두거나, 랜덤한 값으로 일단 채워넣는다
			//membersVO.setPw(null);
			
			//가짜 로그인
			membersVO.setNickName(lm.get("nickname"));
			membersVO.setEmail(ks.get("email").toString());
			membersVO.setSocial(userRequest.getClientRegistration().getRegistrationId());
			
			membersVO.setAttributes(oAuth2User.getAttributes());
			
			//Role을 임의로 작성
			List<RoleVO> lr = new ArrayList<>();
			RoleVO roleVO = new RoleVO();
			
			roleVO.setRoleName("ROLE_MEMBER");
			
			lr.add(roleVO);
			
			membersVO.setRoleVOs(lr);
				
		
		}else {
			membersVO = membersMapper.getMembersLogin(oAuth2User.getName());
			
		}
		
		return membersVO;
		
		
	}
	
	
	//네이버 소셜로그인
	private OAuth2User socialNaverJoinCheck(OAuth2UserRequest userRequest) {
		OAuth2User oAuth2User = super.loadUser(userRequest);
		log.info("-------------------사용자 정보-----------------");
		LinkedHashMap<String, String> properties = (LinkedHashMap)oAuth2User.getAttributes().get("response");
		
		String userName = properties.get("id");
		
		log.info("네이버 정보 ::: {} " , userName);
		log.info("소셜 소셜 :: {} " , userRequest.getClientRegistration().getRegistrationId());
		
		
		
		log.info("************** 사용자 정보 *************");
		log.info("Name : {} ", oAuth2User.getName());
		log.info("Attributes : {} " , oAuth2User.getAttributes());
		log.info("auth :: {} " , oAuth2User.getAuthorities());
		
		Map<String, Object> map = oAuth2User.getAttributes();
		
		//key들 꺼내기
		Iterator<String> keys = map.keySet().iterator();
		
		while(keys.hasNext()) {	//열거한 후 다음게 있냐고 물어봄
			String key = keys.next();
			
			log.info("KEY ==>> {} " , key);
			
		}
		
		
//		log.info("ClassName : {} " , oAuth2User.getAttribute("properties").getClass());
		
//		Map<String, String> lm = oAuth2User.getAttribute("properties");
//		Map<String, Object> ks = oAuth2User.getAttribute("kakao_account");
		
		
		
		
		MembersVO membersVO = new MembersVO();
		
		membersVO.setId(userName);
		

		
		//회원가입 유무
		int count = 0;
		
		try {
			log.info("=========소셜 서비스 네이버 try문 들어옴?? ================");
			count = membersMapper.getIdCheck(membersVO);
			log.info("==========소셜 서비스 네이버 try문 잘 실행됨?? ==============");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		log.info("소셜서비스에서 네이버 count :: {} " , count);
		
		//count 가 0이면 회원가입 안된거 가짜로그인 진행
		if(count == 0) {
			
			
			//pw가 없으므로 비워두거나, 랜덤한 값으로 일단 채워넣는다
			//membersVO.setPw(null);
			
			//가짜 로그인
			membersVO.setId(userName);
			membersVO.setNickName(properties.get("nickname"));
			membersVO.setEmail(properties.get("email").toString());
			membersVO.setSocial(userRequest.getClientRegistration().getRegistrationId());
			
			membersVO.setAttributes(oAuth2User.getAttributes());
			
			//Role을 임의로 작성
			List<RoleVO> lr = new ArrayList<>();
			RoleVO roleVO = new RoleVO();
			
			roleVO.setRoleName("ROLE_MEMBER");
			
			lr.add(roleVO);
			
			membersVO.setRoleVOs(lr);
				
			log.info("membersVO :: {} " , membersVO);
		
		}else {
			log.info("카운트가 1이라 로그인 실행");
			membersVO = membersMapper.getMembersLogin(userName);
			
		}
		
		return membersVO;
		
		
	}

	
	

}
