<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script defer src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:import url="../temp/boot.jsp"></c:import>

<style>
  #loginSt{
    margin-left: 250px;
  }
  #pwConfirm{
  	cursor: pointer;
  }
  #pb{
  	display: none;
  }
  #loginBtn{
  	background: var(--color-primary);
	border: 0;
	padding: 14px 45px;
	color: #fff;
	transition: 0.4s;
	border-radius: 50px;
  }
</style>
<script defer src="/js/login.js"></script>
<script defer src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		  
</head>
<body>
<c:import url="../common/header.jsp"></c:import>
<!-- <section class="container-fluid col-lg-10 mt-5"> -->
		
		
		<section id="contact" class="contact">
		<div class="section-header">
          <h2 style="color: #008374;">로그인 페이지</h2>
        </div>
	


          <div class="col-lg-8" id="loginSt">
            <form action="login" method="post" id="frm">
              <div class="row" >
              
                <div class="form-group mt-3">
                  <input type="text" name="id" value="${cookie.Id.value}" class="form-control" id="id" placeholder="아이디를 입력하세요.">
                </div>
                
                <div class="form-group mt-3">
                  <input type="passWord" name="passWord" class="form-control" id="passWord" placeholder="패스워드를 입력하세요.">
                </div>
                
              </div>

              
               <!--  <a href="/oauth2/authorization/kakao">카카오 간편가입</a> -->
                	<div style="float: right; margin-top: 10px; cursor: pointer;">
					<!-- <input type="button" id="loginBtn" onclick="location='/oauth2/authorization/kakao'" value="카카오 간편가입"> -->
					<img alt="" src="/assets/img/kakao_login_medium_narrow.png" onclick="location='/oauth2/authorization/kakao'">
					<img alt="" src="/assets/img/btnG_naverlogin.png" width="183px" height="45px" onclick="location='/oauth2/authorization/naver'">
				</div>
				
			<!-- 	<div>
					<button type="button" class="btn btn-primary" onclick="location='/oauth2/authorization/naver'">네이버 로그인</button>
				</div> -->
				
				
				<div class="form-group mb-3">
				    <input type="checkbox" name="rememberId" class="form-check-input" id="exampleCheck2">
				    	<b style="color: #008374;">ID저장하기</b>
				 </div>
				 
				<div class="mb-3">
				    <label for="password" class="form-label"></label>
				    <input type="checkbox" name="rememberMe" class="form-check-input" id="exampleCheck2">
				    	<b style="color: #008374;">자동로그인</b>
			  
			  <!-- 아래 있는 비밀번호 찾기 모달 띄우기 -->
<!--  				  <div style="float: right;" id="pwConfirm" data-bs-toggle="modal" data-bs-target="#myModal">
					  	pw찾기
				  </div> -->
				  
				</div>
				
				 <div id="pb">
				 	 <button  type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
					</button>	
				 </div>
				 


			 
			 
			  	
              <div class="my-3">
<!--                 <div class="loading">Loading</div>
                <div class="error-message"></div>
                <div class="sent-message">Your message has been sent. Thank you!</div> -->
              </div>
              <div class="text-center">
              	<button type="button" id="loginBtn" onclick="blackMem()">로그인</button>
              </div>
            </form>
            
            <!-- 비밀번호 찾기 -->
            <div style="float:right;">
				<button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#findPw">비밀번호를 잊으셨나요?</button>
			</div>
			
			
          </div><!-- End Contact Form -->
          
          
          <!--임시 비번 모달-->
		<div class="container">
		    <!-- Modal -->
		    <div class="modal fade" id="findPw" role="dialog">
		        <div class="modal-dialog">
		
		            <!-- Modal content-->
		            <div class="modal-content">
		                <div class="modal-header" style="padding:35px 50px;">
		                    <h4><span class="glyphicon glyphicon-lock"></span> 비밀번호 찾기</h4>
		                </div>
		                <div class="modal-body" style="padding:40px 50px;">
		                    <div style="color: #ac2925">
		                        <center>입력된 정보로 임시 비밀번호가 전송됩니다.</center>
		                    </div>
		                    <hr>
		                    <form role="form" action="mailConfirm" method="post">
		                        <div class="form-group">
		                            <label for="userEmail"><span class="glyphicon glyphicon-user"></span>email</label>
		                            <input type="text" class="form-control" name="email" id="userEmail" placeholder="가입시 등록한 이메일을 입력하세요.">
		                        </div>
		          <!--               <div class="form-group">
		                            <label for="userName"><span class="glyphicon glyphicon-eye-open"></span> name</label>
		                            <input type="text" class="form-control" name="nickName" id="userName" placeholder="가입시 등록한 닉네임을 입력하세요.">
		                        </div> -->
		                        <button type="button" class="btn btn-success btn-block" id="checkEmail">OK</button>
		                    </form>
		                    <hr>
		                    <div class="text-center small mt-2" id="checkMsg" style="color: red"></div>
		                </div>
		                <div class="modal-footer">
		                    <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span
		                            class="glyphicon glyphicon-remove"></span> Cancel
		                    </button>
		                </div>
		            </div>
		
		        </div>
		    </div>
		</div>
		
			
			
				
          </section>
          
          
<!--           <script>
    $("#checkEmail").click(function () {
        const userEmail = $("#userEmail").val();
    /*     const sendEmail = document.forms["sendEmail"]; */
        $.ajax({
            type: 'post',
            url: 'mailConfirm',
            data: {
                'userEmail': userEmail
            },
            dataType: "text",
            success: function (result) {
                if(result == "no"){
                    // 중복되는 것이 있다면 no == 일치하는 이메일이 있다!
                    alert('임시비밀번호를 전송 했습니다.');
                    sendEmail.submit();
                }else {
                    alert('가입되지 않은 이메일입니다.');
                }

            },error: function () {
                console.log('에러 체크!!')
            }
        })
    });
</script> -->

	
	

<c:import url="../common/footer.jsp"></c:import>
</body>
</html>