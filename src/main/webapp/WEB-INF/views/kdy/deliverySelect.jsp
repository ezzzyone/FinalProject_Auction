<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
#inquirySt {
	margin-top: 50px;
	margin-bottom: 50px;
}
#inquiryss {
	margin-left: 350px;
}
#inquiryAddBottonST {
	margin-top: 50px;
}
#information {
	font-size: 17px;
	font-weight: bold;
}
img {
	width: 130px;
	height: 130px;
}
#mar {
	margin-right: 150px;
}
span {
	font-weight: bold;
}
</style>
<script  defer src="/kdy/js/admin.js"></script>
</head>
<body>
    <c:import url="../common/header.jsp"></c:import>

    <div class="container" style="border:  solid 1px gainsboro; height: 250px; margin-top: 150px; margin-bottom: 250px;">
      <span style="text-align: center; font-size: 25px; margin-left: 550px;" >배송상태</span><hr>
      <div class="d-flex" id="center">
        <c:choose>
          <c:when test="${delivery.stateNum == 1}">
            <div>
                <span style="margin-left: 150px;">상품 준비</span>
                <div id="mar" style="margin-left: 120px;">
                    <img src="./img/free-icon-product-2652218.png">
                </div>
            </div>
            <div>
                <span style="margin-left: 30px;">상품 출고</span>
                <div id="mar">
                    <img src="./img/free-icon-shipping-box-2409131 (1).png" style=" opacity: 0.2;"> 
                </div>
            </div>
            <div>
                <span style="margin-left: 30px;">상품 배송</span>
                <div id="mar">
                    <img src="./img/free-icon-fast-delivery-3607622.png" style=" opacity: 0.2;"> 
                </div>
            </div>
            <div>
                <span style="margin-left: 30px;">배송 완료</span>
                <div>
                    <img src="./img/free-icon-delivery-box-5349743.png" style=" opacity: 0.2;"> 
                </div>
            </div>
          </c:when>
          <c:when test="${delivery.stateNum == 2}">
            <div>
              <span style="margin-left: 150px;">상품 준비</span>
              <div id="mar" style="margin-left: 120px;">
                  <img src="./img/free-icon-product-2652218.png">
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">상품 출고</span>
              <div id="mar">
                  <img src="./img/free-icon-shipping-box-2409131 (1).png" > 
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">상품 배송</span>
              <div id="mar">
                  <img src="./img/free-icon-fast-delivery-3607622.png" style=" opacity: 0.2;"> 
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">배송 완료</span>
              <div>
                  <img src="./img/free-icon-delivery-box-5349743.png" style=" opacity: 0.2;"> 
              </div>
          </div>
          </c:when>
          <c:when test="${delivery.stateNum == 3}">
            <div>
              <span style="margin-left: 150px;">상품 준비</span>
              <div id="mar" style="margin-left: 120px;">
                  <img src="./img/free-icon-product-2652218.png">
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">상품 출고</span>
              <div id="mar">
                  <img src="./img/free-icon-shipping-box-2409131 (1).png"> 
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">상품 배송</span>
              <div id="mar">
                  <img src="./img/free-icon-fast-delivery-3607622.png"> 
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">배송 완료</span>
              <div>
                  <img src="./img/free-icon-delivery-box-5349743.png" style=" opacity: 0.2;"> 
              </div>
          </div>
          </c:when>
        <c:when test="${delivery.stateNum == 4}">
              <div>
                <span style="margin-left: 150px;">상품 준비</span>
                <div id="mar" style="margin-left: 120px;">
                    <img src="./img/free-icon-product-2652218.png">
                </div>
            </div>
            <div>
                <span style="margin-left: 30px;">상품 출고</span>
                <div id="mar">
                    <img src="./img/free-icon-shipping-box-2409131 (1).png"> 
                </div>
            </div>
            <div>
                <span style="margin-left: 30px;">상품 배송</span>
                <div id="mar">
                    <img src="./img/free-icon-fast-delivery-3607622.png"> 
                </div>
            </div>
            <div>
                <span style="margin-left: 30px;">배송 완료</span>
                <div>
                    <img src="./img/free-icon-delivery-box-5349743.png"> 
                </div>
            </div>
        </c:when>
          <c:otherwise>
            <div>
              <span style="margin-left: 150px;">상품 준비</span>
              <div id="mar" style="margin-left: 120px;">
                  <img src="./img/free-icon-product-2652218.png"  style=" opacity: 0.2;">
              </div>
            </div>
          <div>
              <span style="margin-left: 30px;">상품 출고</span>
              <div id="mar">
                  <img src="./img/free-icon-shipping-box-2409131 (1).png" style=" opacity: 0.2;"> 
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">상품 배송</span>
              <div id="mar">
                  <img src="./img/free-icon-fast-delivery-3607622.png" style=" opacity: 0.2;"> 
              </div>
          </div>
          <div>
              <span style="margin-left: 30px;">배송 완료</span>
              <div>
                  <img src="./img/free-icon-delivery-box-5349743.png" style=" opacity: 0.2;"> 
              </div>
          </div>
          </c:otherwise>
      </c:choose>


      </div><hr>
      <div class="row">
        <div class="col-md-6 form-group">
          출발지 : ${delivery.product_address}
        </div>
        <div class="col-md-6 form-group">
          도착지 : ${delivery.membersVO.address}
        </div>
        <div class="col-md-6 form-group">
          상품명 : ${delivery.name}
        </div>
        <div class="col-md-6 form-group">
          배송상태 : ${delivery.deliveryStateVO.stateName}
        </div>
      </div>
      <c:choose>
        <c:when test="${delivery.stateNum == 4}">
          <div style="margin-top: 40px; margin-left: 550px;">
            <button type="submit"  class="btn btn-success" style=" opacity: 0.5;">구매 확정</button>
          </div>
        </c:when>
        <c:otherwise>
          <div style="margin-top: 40px; margin-left: 550px;"  onclick="location.href='/kdy/deliverySuccess?stateNum=4&product_num=${delivery.product_num}';">
            <button type="submit"  class="btn btn-success">구매 확정</button>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
   
        <c:import url="../common/footer.jsp"></c:import>
</body>
</html>