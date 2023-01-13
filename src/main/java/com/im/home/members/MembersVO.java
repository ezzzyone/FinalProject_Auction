package com.im.home.members;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.multipart.MultipartFile;

import com.im.home.admin.AdminMembersVO;
import com.im.home.admin.InquiryResponseVO;

import lombok.Data;

@Data
public class MembersVO implements UserDetails, OAuth2User{
	
//	@NotBlank(message = "아이디 입력은 필수입니다.")
	private String id;
	//@NotBlank
	private String passWord;

	private String passWordCheck;

	private String realName;
	private String nickName;
	private String address;
	
	//@Email
	//@NotBlank
	private String email;
	private String birth;
	private Integer gender;
	private String phone;
	private Date joinDate;
	private int black;

	private int distinguish;

	private int point;
	private int forget;
	private String exPassWord;
	
	private int roleNum;
	
	private List<RoleVO> roleVOs;
	
	private MembersFileVO membersFileVO;
	
	private MultipartFile files;
	
	private List<AdminMembersVO> adminMembersVOs;
	private InquiryResponseVO inquiryResponseVO;
	
	
	private boolean enAbled;

	
	
	//OauthUser , Tocken 정보저장
	private Map<String, Object> attributes;
	private RoleVO roleVO;
	private List<MembersVO> membersVOs;
	
	private String picture;
	
	
	//=========소셜로그인===========
	//ex ===>  social : Kakao
	private String social;

	
	
	
	// UserDetails 인가정보 
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		List<GrantedAuthority> autoAuthorities = new ArrayList<>();
		for(RoleVO roleVO : roleVOs) {
			//roleVo를 GrantedAuthority 타입으로 담아준다
			// ?는 any 를 뜻함, extends GrantedAuthority 를 상속받는 아무타입이면 된다.
		    // (+) <? super T> T나 T의 부모타입을 허용하겠다 라는 뜻
			autoAuthorities.add(new SimpleGrantedAuthority(roleVO.getRoleName()));
		}
		
		return autoAuthorities;
	}

	@Override
	public String getPassword() {
		
		return this.passWord;
	}

	@Override
	public String getUsername() {
	
		return this.id;
	}

	@Override
	public boolean isAccountNonExpired() {

		return true;
	}

	@Override
	public boolean isAccountNonLocked() {	//계정 잠김 여부 
		
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		
		return true;
	}

	@Override
	public boolean isEnabled() {
		
		return true;
	}

	@Override
	public Map<String, Object> getAttributes() {

		return this.attributes;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return null;
	}



	
	

}
