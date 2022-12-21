<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<c:import url="../common/header.jsp"></c:import>
</head>
<body>
	<section id="services" class="services sections-bg">
	<div class="container" data-aos="fade-up">
	<div class="section-header">
          <h2 style="color: #008374;">상품 등록</h2>
        </div>
	<div class="container row" style="float: none; margin:0 auto; margin-top: 0px; margin-bottom: 100px;">
		<form class="row g-3" method="post" action="./add">
			

		  
		  <div class="col-md-12">
		  	<label for="inputCity" class="form-label">산지 검색</label>
		  	<input type="button" class="form-control" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
		  </div>
		  
		  <div class="col-md-4">
		    <label for="inputCity" class="form-label">도로명 주소</label>
		    <input type="text" class="form-control" id="sample6_address" name="pickup_address">
		  </div>
		  <div class="col-md-4">
		    <label for="inputCity" class="form-label">지번 주소</label>
		    <input type="text" class="form-control" id="sample6_extraAddress" name="ext_address">
		  </div>
		  <div class="col-md-2">
		    <label for="inputState" class="form-label">상세주소</label>
		    <input type="text" class="form-control" id="sample6_detailAddress" name="detail_address">
		  </div>
		  <div class="col-md-2">
		    <label for="inputZip" class="form-label">우편번호</label>
		    <input type="text" class="form-control" id="sample6_postcode" name="postcode">
		  </div>
		 
		  
		  <div class="mb-3">
			  <label for="formFile" class="form-label"></label>
			  <input class="form-control" type="file" id="formFile">
		  </div>
		  
		  <div class="col-12">
		    <button type="submit" class="btn btn-primary">상품 등록 신청</button>
		  </div>
	</form>
	
	</div>
	</div>
	</section>
	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<c:import url="../common/footer.jsp"></c:import>
</body>
</html>