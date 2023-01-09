//ddsdsf
package com.im.home.members;

import java.security.Principal;
import java.security.SecureRandom;
import java.util.Date;
import java.util.List;

import javax.servlet.Servlet;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.im.home.admin.AdminMembersService;
import com.im.home.admin.AdminMembersVO;
import com.im.home.mail.MailService;
import com.im.home.mail.OtherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value = "/members/*")
@Slf4j
public class MembersController {

	
	@Autowired
	private MembersService membersService;
	@Autowired
	private PasswordEncoder passwordEncoder;
//	@Autowired
//	private MailSenderRunner mailSenderRunner;
	@Autowired
	private AdminMembersService adminMembersService;
	@Autowired
	private MembersSocialService membersSocialService;
//	@Autowired
//	private MailService mailService;
	@Autowired
	private OtherService otherService;
	@Autowired
	private MailService mailService;
	
	
	
	
	@GetMapping(value = "login")
	public String getMembersLogin() throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		log.info("로그인창 입장~");
		
		return "members/login";
	}
	
//	@PostMapping(value = "login")
//	public ModelAndView getMembersLogin() throws Exception{
//		ModelAndView mv = new ModelAndView();
//		
//		log.info("==================로그인 실행================");
//		
//		mv.setViewName("redirect:../");
//		
//		return mv;
//	}
	
	//약관동의로 보내기
	@GetMapping(value = "agree")
	public String setMembersAgree() throws Exception{
		
		return "members/agree";
	}
	
	//약관동의가 끝나고 다음버튼을 누르면 회원가입 주소로감
	@GetMapping(value = "signUpHead")
	public String setMembersSignUpHead(String roleNum) throws Exception{
		
		return "members/signUpHead";
	}
	
	
	//약관동의가 끝나고 다음버튼을 누르면 회원가입 주소로감
	@GetMapping(value = "signUp")
	public String setMembersSignUp(String roleNum) throws Exception{
		
		return "members/signUp";
	}
	
	//약관동의가 끝나고 다음버튼을 누르면 회원가입 주소로감
	@GetMapping(value = "signUpC")
	public String setMembersSignUpC(String roleNum) throws Exception{
		log.info("roleNum : {} " ,roleNum);
		return "members/signUpC";
	}
	
	//약관동의가 끝나고 다음버튼을 누르면 회원가입 주소로감
	@GetMapping(value = "signUpD")
	public String setMembersSignUpD(String roleNum) throws Exception{
		
		return "members/signUpD";
	}
	
	//도매업자 회원가입 (주소포함)
	@PostMapping(value = "signUpD")
	public ModelAndView setDomaeSignUp(MembersVO membersVO, MultipartFile files) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		log.info("주소 :: {} " ,membersVO.getAddress());
		log.info("==============도매업자 회원가입============");
		membersVO.setPassWord((passwordEncoder.encode(membersVO.getPassword())));;
		int result = membersService.setDomaeSignUp(membersVO, files);
		membersService.setMembersRole(membersVO);
		log.info("도매업자 주소 :: {} " , membersVO.getAddress());
		
		mv.addObject("membersVO", membersVO);
		mv.setViewName("members/login");
		
		
		return mv;
	}
	
	//약관동의가 끝나고 다음버튼을 누르면 회원가입 주소로감
	@GetMapping(value = "signUpG")
	public String setMembersSignUpG(String roleNum) throws Exception{
		
		return "members/signUpG";
	}
	
	//약관동의가 끝나고 다음버튼을 누르면 회원가입 주소로감
	@GetMapping(value = "signUpS")
	public String setMembersSignUpS(String roleNum) throws Exception{
		
		return "members/signUpS";
	}
	
	
	
	@PostMapping(value = "signUp")
	public ModelAndView setMembersSignUp(MembersVO membersVO, MultipartFile files) throws Exception{
		ModelAndView mv = new ModelAndView();	
		
//		if(bindingResult.hasErrors()) {
//			log.info("검증 에러 발생");
//			mv.setViewName("members/signUp");
//			return mv;
//		}
		
		log.info("============================회원가입 완료==========================");
		
		membersVO.setPassWord((passwordEncoder.encode(membersVO.getPassword())));;
		int result = membersService.setMembersSignUp(membersVO, files);
		membersService.setMembersRole(membersVO);
		
		mv.addObject("membersVO", membersVO);
		mv.setViewName("members/login");
		
		
		return mv;
	}
	
	@GetMapping(value = "logout")
	public String getLogOut(HttpSession session) throws Exception{
		log.info("로그아웃 실행 준비");
		
		session.invalidate();					//세션삭제			
		
		return "redirect:../";
	}
	
	//소셜 로그아웃
	@GetMapping(value = "logoutResult")
	public String socialLogout() throws Exception{
		
		return "redirect:../";
	}
	
	@GetMapping(value = "myPage")
	@ResponseBody
	public ModelAndView getMyPage(MembersVO membersVO, String id, String checkPassWord, Principal principal , Model model, HttpSession session, Authentication authentication) throws Exception{
		ModelAndView mv = new ModelAndView();
		AdminMembersVO adminMembersVO = new AdminMembersVO();
		
		
		log.info("ddddd => {}" ,principal.getName()); 
		log.info("마이페이지 프린시펄 :: {} " , principal);
		
		membersVO.setId(principal.getName());	//시큐리티로 로그인한 아이디값을 가져오는 코드
		
		membersVO = membersService.getMyPage(membersVO);
		
		log.info("카카오오오오 ::: {} " , authentication.getPrincipal());
		
//		if(request2.getRequestURI() == "inquiryList") {
//			adminMembersVO = membersService.getInquiryList(adminMembersVO);
//			mv.setViewName("kdy/inquiryList");
//		}
		
//		String url = request2.getRequestURI();
//		if(url == "inquiryList") {
//			adminMembersVO = membersService.getInquiryList(adminMembersVO);
//			mv.setViewName("kdy/inquiryList");
//		}
		
//		model.addAttribute("membersVO", principal);
		log.info("Principal => {} ", principal);
//		log.info("file ::::: {} " ,membersVO.getMembersFileVO().getFileName());
		mv.addObject("membersVO", membersVO);
		mv.addObject("kakao", authentication.getPrincipal());	//소셜로그인 했을때 
//		mv.addObject("membersVO", membersVO2);
		mv.setViewName("members/myPage");
		
//		if(get) {
//			adminMembersVO = membersService.getInquiryList(adminMembersVO);
//			mv.setViewName("kdy/inquiryList");
//		}
		
		
		
		return mv;
	}
	
	
	//아이디 중복검사
	@GetMapping(value = "idCheck")
	@ResponseBody	//응답을 거치지 않고 바로 View (JSP)로 보냄
	public Integer getIdCheck(MembersVO membersVO) throws Exception{
		
		int result = membersService.getIdCheck(membersVO);
		
		return result;
	}
	
	
	//닉네임 중복검사
	@GetMapping(value = "nickNameCheck")
	@ResponseBody
	public Integer getNickNameCheck(MembersVO membersVO) throws Exception{
		
		int result = membersService.getNickNameCheck(membersVO);
		
		return result;
	}
	
	//전화번호 중복검사
	@GetMapping(value = "phoneCheck")
	@ResponseBody
	public Integer getPhoneCheck(MembersVO membersVO) throws Exception{
		
		int result = membersService.getPhoneCheck(membersVO);
		
		return result;
	}
	
	
	//마이페이지에서 보이는 나의 1:1문의 내역
	@GetMapping(value = "inquiryList")
	public ModelAndView getInquiryList(String id, AdminMembersVO adminMembersVO, Principal principal, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		MembersVO membersVO = (MembersVO)session.getAttribute(principal.getName());
		adminMembersVO.setId(principal.getName());
		log.info("===================================폼폼폼폼폼폼포뫂ㅁ");
		log.info("내 로그인한 아이디 : {} ", principal.getName());
		
		List<AdminMembersVO> ar = membersService.getInquiryList(adminMembersVO);
		
		mv.addObject("AdminMembersVO", adminMembersVO);
	
		mv.addObject("inquiryList", ar);
		mv.setViewName("members/inquiryList");
		
		return mv;
	}
	
	//회원정보 수정										//@RequestParam ==> Ajax에서 컨트롤러로 넘길때 String으로 받는 경우
	@GetMapping(value = "modify")
	public MembersVO setMembersModify(MembersVO membersVO, Model model, Principal principal) throws Exception{
		
		model.addAttribute("membersVO", membersVO);
		
//		log.info("id :::: {} " , membersVO.getId());
//		log.info("fileName ::: {} " , membersVO.getMembersFileVOs().get(0).getFileName());
//		log.info("fileNNNNNAAAAMMMMEEE::::: {} ", membersVO.getFiles());
		
		String membersId = membersVO.getId();
		log.info("memberID : {} " ,membersId);
		
//		boolean check = false;
		
//		check = membersService.checkPassWord(membersId, checkPassWord);
//		log.info("마이페이지 회원정보 수정 check :: {} " , check);
		
//		if(check) {	//현재 입력한 비밀번호와 db에있는 비밀번호가 일치(true)한다면
			
			membersVO = membersService.getMyPage(membersVO);
		
			
//		}
	
		return membersVO;
	
	}
	
	
	// 회원정보 수정을 들어갈때 비밀번호 일치시키는 ajax 용 GET 주소
	//회원정보 수정										//@RequestParam ==> Ajax에서 컨트롤러로 넘길때 String으로 받는 경우
	@GetMapping(value = "modify1")
	@ResponseBody
	public boolean setMembersModify1(@AuthenticationPrincipal MembersVO membersVO, @RequestParam String checkPassWord, @RequestParam String id, Model model, Principal principal) throws Exception{
		
		model.addAttribute("membersVO", membersVO);
		
//		log.info("id :::: {} " , membersVO.getId());
//		log.info("fileName ::: {} " , membersVO.getMembersFileVOs().get(0).getFileName());
//		log.info("fileNNNNNAAAAMMMMEEE::::: {} ", membersVO.getFiles());
		
		String membersId = membersVO.getId();
		log.info("memberID : {} " ,membersId);
		
		boolean check = false;
		
		check = membersService.checkPassWord(membersId, checkPassWord);
		log.info("마이페이지 회원정보 수정 check :: {} " , check);
		
		if(check) {	//현재 입력한 비밀번호와 db에있는 비밀번호가 일치(true)한다면
			
			membersVO = membersService.getMyPage(membersVO);
		
			
		}
	
		return check;
	
	}
	
	@PostMapping(value = "modify")
	public ModelAndView setMembersModify(String id, MembersVO membersVO, Principal principal, MultipartFile files) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		membersVO.setId(principal.getName());	//시큐리티로 로그인한 아이디값을 가져오는 코드
		
		log.info("============================회원가입 수정==========================");
		//수정할때 수정 비밀번호도 패스워드 해싱해줌
		membersVO.setPassWord((passwordEncoder.encode(membersVO.getPassword())));
		int result = membersService.setMembersModify(membersVO, files);
		
		log.info("내 수정정보 ===>> {}" ,principal);
		log.info("수정된 닉네임 :::: {} " , membersVO.getNickName());
		log.info("수정된 전화번호 ::: {} " , membersVO.getPhone());
//		log.info("수정된 파일 :: {} " , membersVO.getMembersFileVO().getFileName());
//		log.info("수정된 파일 오리네임 ::: {} ", membersVO.getMembersFileVO().getOriName());
//		mv.setViewName("members/login");
		mv.addObject("membersVO", membersVO);
		mv.setViewName("redirect:/members/myPage");
		
		return mv;
	}
	
	
	//회원 탈퇴
//	@GetMapping(value = "drop")
//	@ResponseBody
//	public ModelAndView setMembersDrop(MembersVO membersVO, HttpSession session, RedirectAttributes redirectAttributes, Principal principal
//			) throws Exception{
//		
//		ModelAndView mv = new ModelAndView();
//		
//		log.info("id :{}" , principal.getName());
//		log.info("현재 비밀번호 :: {}" ,membersVO.getPassword());
//		
//		MembersVO membersVO2 = (MembersVO)session.getAttribute("member");
//		
//		
//		log.info("session비밀번호 :{} ", membersVO2.getPassword());
//		
//		//현재 세션에 들어있는 비밀번호
////		String sessionPassWord = membersVO2.getPassword();
//		
//		//MemberVO로 들어오는 파라미터 비밀번호
//		String paramPassWord = membersVO.getPassword();
//		
//		int resultDrop = membersService.setMembersDrop(membersVO);
//		
//		if(resultDrop == 1) {
//			mv.setViewName("../");
//			session.invalidate();
//		}else {
//			mv.setViewName("members/myPage");
//		}
//		
////		if(!(sessionPassWord.equals(paramPassWord))) {	//현재 세션에 들어있는 비밀번호와 파라미터로 넘어온 비밀번호가 일치하지않다면
////			redirectAttributes.addFlashAttribute("msg", false);	//jsp에 있는 메세지를 호출
////			mv.setViewName("redirect:./myPage");
////			
////		}else {		//세션에 들어있는 비밀번호와 파라미터로 넘어온 비밀번호가 일치한다면 세션을 죽이고 탈퇴를 성공적으로 마침
////			int resultDrop = membersService.setMembersDrop(membersVO);
////			session.invalidate();
////			mv.setViewName("redirect:../");
////		}
//		
//		return mv;
//	}
	
	//회원 탈퇴
//	@GetMapping(value = "drop")
//	@ResponseBody
//	public ModelAndView setMembersDrop(MembersVO membersVO, HttpSession session, String passWord, RedirectAttributes redirectAttributes) throws Exception{
//		
//		ModelAndView mv = new ModelAndView();
//		SecurityContextImpl context = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");	//스프링에 있는 세션이름(주소)
//		Authentication authentication = context.getAuthentication();
//		MembersVO membersVO2 = (MembersVO)authentication.getPrincipal();	//로그인한 사용자의 모든 정보
//		log.info("현재 세션에 저장된 비밀번호 ==>> {} " ,membersVO2.getPassword());
//		
//		
//		//현재 들어있는 비밀번호 정보
//		String sessionPassWord = membersVO2.getPassword();
//		
//		String voPassWord = membersVO.getPassword();
//		
//		mv.addObject("membersVO", membersVO2);
//		
////		if(resultDrop == 1) {
////			mv.setViewName("redirect:../");
////			session.invalidate();
////		}else {
////			mv.setViewName("members/myPage");
////		}
//		
////		boolean check = membersService.isMatches(sessionPassWord, voPassWord);
//		
//		if(!sessionPassWord.equals(voPassWord)) {	//현재 확인용 비밀번호와 세션에 있는 비밀번호와 일치하지 않을때
//			redirectAttributes.addFlashAttribute("message", false);	// jsp에 있는 메세지 호출
//		}else {
//			int resultDrop = membersService.setMembersDrop(membersVO2);
//			session.invalidate();
//			mv.setViewName("redirect:../");
//		}
//		
//		return mv;
//	}
	
	
	//회원 탈퇴
		@GetMapping(value = "drop")
		@ResponseBody
		public int setMembersDrop(@AuthenticationPrincipal MembersVO membersVO, @RequestParam String checkPassWord, Model model, HttpSession session, RedirectAttributes redirectAttributes) throws Exception{
			
			ModelAndView mv = new ModelAndView();
//			SecurityContextImpl context = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
//			log.info("context :{} " , context);
//			Authentication authentication = context.getAuthentication();
//			MembersVO membersVO2 = (MembersVO)authentication.getPrincipal();
			
			String membersId = membersVO.getId();
			
			boolean check = false;
			int resultDrop = 0;
			
			check = membersService.checkPassWord(membersId, checkPassWord);
			
//			redirectAttributes.addFlashAttribute("message", false);	// jsp에 있는 메세지 호출
			mv.setViewName("members/myPage");
			
			if(check) {
				
				 resultDrop = membersService.setMembersDrop(membersVO);
				
				if(resultDrop == 1) {
				
					session.invalidate();
				}
			}
			
			
			return resultDrop;
		}
		
		
		//파일 삭제
		@PostMapping(value = "fileDelete")
		@ResponseBody
		public int setMembersFileDelete (MembersFileVO membersFileVO) throws Exception{
			
			int result = membersService.setMembersFileDelete(membersFileVO);
			
			log.info("파일 삭제 성공");
			
			return result;
		}
	
		@PostMapping("black")
		@ResponseBody
		public int getBlack(MembersVO membersVO) throws Exception{
			
			membersVO = adminMembersService.getMemberBlack(membersVO);
			int result = membersVO.getBlack();	
			log.info("아아아아아아ㅏ앙 ===> {}", result);
			return result;
			
		}
		
		//소셜로그인을 누른 회원을 우리 회원으로 insert시키기 위해 추가정보 입력페이지를 GET
		@GetMapping(value = "socialAdd")
		public ModelAndView getSocailAdd (MembersVO membersVO, HttpSession session, Authentication authentication) throws Exception{
			
			ModelAndView mv = new ModelAndView();
			
			log.info("=========소셜로그인 하러 들어옴========");
			
			log.info("다다다다다다닫 ::{} " , authentication.getPrincipal());
			
			mv.addObject("social", authentication.getPrincipal());	//social 키에 현재 소셜로그인 정보를 담아줌;
			
			mv.setViewName("members/socialAdd");
			
			return mv;
		}
		
		
		//소셜로그인을 누르고 추가입력을 하는 post매핑
		@PostMapping(value = "socialAdd")
		public ModelAndView setSocialSignUp (MembersVO membersVO, HttpSession session, Authentication authentication, MultipartFile files) throws Exception{
			
			ModelAndView mv = new ModelAndView();
			
			log.info("================ 추가정보입력 POST =============");
			
//			membersVO.setPassWord((passwordEncoder.encode(membersVO.getPassword())));;
			
//			membersVO.setId(authentication.getPrincipal().toString());
//			membersVO.setNickName(authentication.getPrincipal().toString());
//			membersVO.setEmail(authentication.getPrincipal().toString());
			
			
			int result = membersService.setSocialSignUp(membersVO, files);
			
			
			
			if(result == 1) {
				log.info("소셜 추가 정보 입력 성공 (컨트롤러) !!");
				mv.setViewName("redirect:../");
			}else {
				log.info("소셜 추가 정보 입력 실패!!!! ( 컨트롤러)");
				mv.setViewName("/members/socialAdd");
			}
			
			
			return mv;
		}
		
		///////////////////////////////////////////////////////////////////결제
		@GetMapping(value = "pay")
		public ModelAndView getPay(Principal principal) throws Exception{
			MembersVO membersVO = new MembersVO();
			membersVO.setId(principal.getName());
			membersVO = membersService.getMemberInfo(membersVO);
			ModelAndView mv = new ModelAndView();
			mv.addObject("membersVO", membersVO);
			mv.setViewName("members/pay");
			return mv;
		}
		
		@ResponseBody
		@PostMapping(value = "payments")
		public String setPoint(Principal principal,@RequestParam String amount) throws Exception {
			int money = Integer.parseInt(amount);
			MembersVO membersVO = new MembersVO();
			membersVO.setId(principal.getName());
			membersVO.setPoint(money);
			int result = membersService.setPoint(membersVO);
			if(result>0) {
				String paymentResult = "paid";
				return paymentResult;
			}
			else {
				String paymentResult = "";
				return paymentResult;
			}
		}
		
		//임시비밀번호 전송
//		@PostMapping(value = "sendEmail")
//		public String findPassWord (MembersVO membersVO) throws Exception{
//			
//			log.info("======== findPw => {}", membersVO);
//			char[] charSet = new char[] {
//		                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
//		                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
//		                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
//		                '!', '@', '#', '$', '%', '^', '&' };
//
//	        StringBuffer sb = new StringBuffer();
//	        SecureRandom sr = new SecureRandom();
//	        sr.setSeed(new Date().getTime());
//	        
//	        int idx = 0;
//	        
//	        int len = charSet.length;
//	        for (int i=0; i<10; i++) {
//	            // idx = (int) (len * Math.random());
//	            idx = sr.nextInt(len);    // 강력한 난수를 발생시키기 위해 SecureRandom을 사용.
//	            sb.append(charSet[idx]);
//	        }
//
//	        membersVO.setPassWord(sb.toString());
//	        mailService.sendPw(membersVO);
//	        
//	        membersVO.setPassWord(passwordEncoder.encode(sb.toString()));
//	        membersService.setChangePw(membersVO);
//	        return "redirect:/members/login";
//		}
//		
//		
//		@RequestMapping("mail")
//		public String sendMail(MailVO mailVO) {
//			mailService.sendSimpleMessage(mailVO);
//			return "redirect:../";
//		}
//
//			
//		}
		
		
//		@ResponseBody
//		@PostMapping(value="mail")
//		public void emailConfirm(String userId) throws Exception{
//			
//			log.info("이메이이이이이일");
//			log.info("전달 받은 이메일 :: {} " , userId);
//			
//			otherService.sendSimpleMessage(userId);
//		}
//		
//		@PostMapping(value = "verifyCode")
//		@ResponseBody
//		public int verifyCode(String code) {
//			
//			log.info("========랜덤코드 POST 실행============");
//			
//			int result = 0;
//			
//			log.info("code :: {} " ,code);
//			log.info("code Match :: {} ", mailService.cPw.equals(code));
//			
//			if(mailService.cPw.equals(code)) {
//				result = 1;
//			}
//			
//			return result;
//		}
		
//		@GetMapping(value = "mailConfirm")
//		@ResponseBody
//		public String mailConfirm1(String email, MembersVO membersVO) throws Exception {
//			log.info("컨트롤러로 옴?");
////			email = "jong120926@naver.com";
//
////			email = membersVO.getEmail();
////		   String code = mailService.sendSimpleMessage(email);
////		   log.info("인증코드 ::  {} " , code);
//		   return code;
//		}
		
		
		// 이메일 인증
		@PostMapping(value = "mailConfirm")
		@ResponseBody
		public String mailConfirm(String userEmail, MembersVO membersVO) throws Exception {
			log.info("컨트롤러로 옴?");
			log.info("email :::: {} " , userEmail);
//			email = "jong120926@naver.com";
			
		   String code = mailService.sendSimpleMessage(userEmail);
		   
		   membersVO.setPassWord(code);
		   membersVO.setExPassWord(code);	//임시비밀번호를 DB의 비밀번호 컬럼으로 업데이트 시켜줌
		   membersVO.setPassWord(passwordEncoder.encode(code));
		   membersVO.setExPassWord(passwordEncoder.encode(code));	//업데이트 시킨 임시 비밀번호를 인코딩해서 디비에 업데이트
		   membersVO.setEmail(userEmail);	//파라미터로 인증받을때 사용한 이메일주소를 사용함
		   int result = membersService.setCodePw(membersVO);
		   log.info("인증코드 ::  {} " , code);
		   return code;
		}
		
		
//		@PostMapping(value = "mailConfirm")
//		@ResponseBody
//		public String mailConfirm(String email) throws Exception {
////			email = "jong120926@naver.com";
//		   String code = mailService.sendSimpleMessage(email);
//		   log.info("인증코드 ::  {} " , code);
//		   return code;
//		}
		
		
		//발급받은 임시 비밀번호로 비밀번호 재설정을 할때 임시 비밀번호가 DB에 있는지 확인.
		@GetMapping(value = "setUpdatePassWord1")
		@ResponseBody
		public boolean setUpdatePassWord(@AuthenticationPrincipal MembersVO membersVO, @RequestParam String checkPassWord, @RequestParam String id, Model model, Principal principal) throws Exception{
			
			model.addAttribute("membersVO", membersVO);
			
			
			String membersId = membersVO.getId();
			log.info("memberID : {} " ,membersId);
			
			boolean check = false;
			
			check = membersService.checkPassWord(membersId, checkPassWord);
			log.info("비밀번호 재설정 수정 check :: {} " , check);
			
		
			return check;
		
		}
		
		
		@PostMapping(value = "updatePassWord")
		public ModelAndView setUpdatePassWord(MembersVO membersVO) throws Exception{
			
			ModelAndView mv = new ModelAndView();
			
			//발급받은 임시비밀번호를 가져와서 로그인 할 수있는 비밀번호로 인코딩해서 만들어준다.
			membersVO.setPassWord((passwordEncoder.encode(membersVO.getPassword())));;
			int result = membersService.setUpdatePassWord(membersVO);
			
			if(result == 1) {
				mv.setViewName("redirect:/members/login");				
			}else {
				log.info("!!비밀번호 재설정 실패!!");
				mv.setViewName("/members/myPage");
			}
			
			return mv;
		}
		
}
