<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="../temp/boot.jsp"></c:import>
<script defer src="/js/membersFile.js"></script>
<script defer src="/js/joinVerify.js"></script>
<script defer src="/js/address.js"></script>
<script defer src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbb0240b108c21736f19f74ec427093d&libraries=services"></script>
<style>
  #signUpSt{
    margin-left: 250px;
  }
  .bc, #imgSpan{
    color: #008374;
  }
  	#proDiv{
  	display: none;
  } 
  #profileImg{
  	cursor: pointer;
  }
  #signUpBtn{
  	background: var(--color-primary);
	border: 0;
	padding: 14px 45px;
	color: #fff;
	transition: 0.4s;
	border-radius: 50px;
  }
</style>
</head>
<body>
<c:import url="../common/header.jsp"></c:import>

	<section id="contact" class="contact">
	
	
		<div class="section-header">
          <h2>도매업자 회원가입 페이지</h2>
        </div>
	

          <div class="col-lg-8" id="signUpSt">
			<form action="signUpD" method="post" enctype="multipart/form-data" id="signUpForm">
            <sec:authentication property="Principal" var="member"/>
            
            <div class="d-flex flex-row" style="margin-left: 200px;">
            
              <div class="row" >
              
                <div class="form-group mt-3">
                <input type="hidden" name="roleNum" value="${param.roleNum}">
                  <input type="text" name="id" class="form-control" id="inputId" placeholder="아이디를 입력하세요">
                  <span id="idHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
                  <input type="password" name="passWord" class="form-control" id="inputPassWord" placeholder="패스워드를 입력하세요">
                  <span id="pwHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
                  <input type="password" name="passWordCheck" class="form-control" id="inputPassWordCheck" placeholder="위에 입력한 패스워드를 다시 한번 입력해주세요">
                  <span id="pwCheckHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
                  <input type="text" name="realName" class="form-control" id="inputRealName" placeholder="실명을 입력해주세요">
                  <span id="realNameHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
                  <input type="text" name="nickName" class="form-control" id="inputNickName" placeholder="닉네임을 입력하세요">
                  <span id="nickNameHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
	                <input type="text" id="sample5_address" placeholder="주소">
					<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
					<input type="text" id="betterAddress" placeholder="상세주소">
					<input type="hidden" id="resultsAddress" name="address" value="">
					<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
				</div>
                
                <div class="form-group mt-3">
                  <input type="email" name="email" class="form-control" id="inputEmail" placeholder="email을 입력하세요">
                  <span id="emailHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
                  <input type="text" name="birth" class="form-control" id="inputBirth" placeholder="생년월일을 입력해주세요(숫자만 입력해주세요)" maxlength="10" onkeyup="birth_keyup(this)">
                  <span id="birthHelp" class="bc"></span>
                </div>
                
                <div class="form-group mt-3">
                  <input type="text" name="phone" class="form-control" id="inputPhone" oninput="autoHyphen(this)" maxlength="13" placeholder="전화번호 입력(숫자만 입력해주세요)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                  <span id="phoneHelp" class="bc"></span>
                </div>
                    

				</div>

               <div style="margin-left: 50px; margin-top: 15px;">
                        <div id="profileImg">
                          <img alt="" src="/assets/img/profle.png" id="humanImg" width="100px" height="100px" onclick="onClickUpload();">
                          <button type="button" class="btn btn-secondary" id="imgBtn" onclick="onClickUpload();">첨부파일</button>
                          <p id="imgSpan"></p> 
                		</div>
                <div class="form-group mt-3" id="proDiv">
                  <label for="formFileSm" class="form-label bc">프로필 사진 첨부 (선택)</label>
                  <input class="form-control form-control-sm pro" id="memberFileAdd" name="files" type="file">
                </div>
              </div>
                
              </div>

              <div class="my-3">
<!--                 <div class="loading">Loading</div>
                <div class="error-message"></div>
                <div class="sent-message">Your message has been sent. Thank you!</div> -->
              </div>
              <div class="text-center">
              	<button type="submit" class="btn btn-primary" id="signUpBtn">회원가입</button>
              </div>
         
			</form>
          </div><!-- End Contact Form -->

</section>


<c:import url="../common/footer.jsp"></c:import>

</body>
</html>