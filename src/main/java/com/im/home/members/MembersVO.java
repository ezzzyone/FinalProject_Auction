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
	
	//@Email
	//@NotBlank
	private String email;
	private String birth;
	private Integer gender;
	private String phone;
	private Date joinDate;
	
	private int roleNum;
	
	private List<RoleVO> roleVOs;
	
	private List<MembersFileVO> membersFileVOs;
	
	private MultipartFile files;
	
	private List<MailVO> mailVOs;
	
	
	//OauthUser , Tocken 정보저장
	private Map<String, Object> attributes;
	private RoleVO roleVO;
	private List<MembersVO> membersVOs;


	
	
	
	// UserDetails 인가정보 
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		List<GrantedAuthority> autoAuthorities = new ArrayList<>();
		for(RoleVO roleVO : roleVOs) {
			//roleVo를 GrantedAuthority 타입으로 담아준다
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
		
		return null;
	}
	
	

}
