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
    #inquirySt{
      margin-top: 50px;
      margin-bottom: 50px;
    }
    #inquiryss{
      margin-left: 350px;
    }
    #inquiryAddBottonST{
      margin-top: 50px;
    }
    #information{
            font-size: 17px;
            font-weight: bold;
        }
  </style>
  <script defer>
    function noClick() {
      alert("이미 판매한 상품입니다 수정할 수 없습니다.");
    }
    function noAuction(){
      alert("이미 판매한 상품입니다 경매할 수 없습니다.");
    }
  </script>
<script  defer src="/kdy/js/admin.js"></script>
</head>
<body>
    <c:import url="../common/header.jsp"></c:import>

    <div class="container-fluid">
      <div id="contact" class="contact">
        <div class="container" data-aos="fade-up" id="inquirySt">
            <div class="section-header">
            <h2>상품번호 ${productVO.product_num}번<br> 품목 : ${productVO.name}</h2>
            </div>
            <div class="row gx-lg-0 gy-4">
              <div style="height: 50px;">
                <div class="d-flex">
                  <div class="info-item d-flex" >
                    <i class="bi bi-envelope flex-shrink-0"></i>
                    <div>
                      <h4>상품 판매 여부</h4>
                        <div class="d-flex" style="color: black; cursor: pointer;">
                          <c:choose>
                            <c:when test="${productVO.stateNum == 5}">
                              <c:choose>
                                 <c:when test="${productVO.sales == 3}">
                                  <div onclick="location.href='/kdy/productHold?sales=1&product_num=${productVO.product_num}';">판매</div>&emsp;
                                  <div onclick="location.href='/kdy/productHold?sales=3&product_num=${productVO.product_num}';" style="color: aliceblue;">보류</div>&emsp;
                                  <div onclick="location.href='/kdy/productHold?sales=2&product_num=${productVO.product_num}';">SOLDOUT</div>
                                 </c:when>
                                 <c:when test="${productVO.sales == 2}">
                                  <div onclick="location.href='/kdy/productHold?sales=1&product_num=${productVO.product_num}';">판매</div>&emsp;
                                  <div onclick="location.href='/kdy/productHold?sales=3&product_num=${productVO.product_num}';">보류</div>&emsp;
                                  <div onclick="location.href='/kdy/productHold?sales=2&product_num=${productVO.product_num}';" style="color: aliceblue;">SOLDOUT</div>
                                 </c:when>
                                 <c:otherwise>
                                  <div onclick="location.href='/kdy/productHold?sales=1&product_num=${productVO.product_num}';" style="color: aliceblue;">판매</div>&emsp;
                                  <div onclick="location.href='/kdy/productHold?sales=3&product_num=${productVO.product_num}';">보류</div>&emsp;
                                  <div onclick="location.href='/kdy/productHold?sales=2&product_num=${productVO.product_num}';">SOLDOUT</div>
                                 </c:otherwise>
                              </c:choose>
                            </c:when>
                            <c:otherwise>
                                 <div onclick="noClick()">판매</div>&emsp;
                                 <div onclick="noClick()">보류</div>&emsp;
                                 <div onclick="noClick()" style="color: aliceblue;">SOLDOUT</div>
                            </c:otherwise>
                          </c:choose>
                        </div>
                    </div>
                </div><!-- End Info Item -->

                  <!-- <div class="info-item d-flex">
                    <i class="bi bi-envelope flex-shrink-0"></i>
                    <div>
                      <h4>상품 등급</h4>
                        ${productVO.productGradeVO.grade_name}
                    </div>
                  </div> -->

                  <div class="info-item d-flex">
                    <i class="bi bi-envelope flex-shrink-0"></i>
                    <div>
                      <h4>상품 등급</h4>
                        <div class="d-flex" style="color: black; cursor: pointer;">
                          <c:choose>
                            <c:when test="${productVO.stateNum == 5}">
                              <c:choose>
                                <c:when test="${productVO.grade_num == 5}">
                                  <div onclick="location.href='/kdy/productGrade?grade_num=1&product_num=${productVO.product_num}';">특</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=2&product_num=${productVO.product_num}';">상</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=3&product_num=${productVO.product_num}';">중</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=4&product_num=${productVO.product_num}';">하</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=5&product_num=${productVO.product_num}';" style="color: aliceblue;">미처리</div>
                                </c:when>
                                <c:when test="${productVO.grade_num == 4}">
                                  <div onclick="location.href='/kdy/productGrade?grade_num=1&product_num=${productVO.product_num}';">특</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=2&product_num=${productVO.product_num}';">상</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=3&product_num=${productVO.product_num}';">중</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=4&product_num=${productVO.product_num}';" style="color: aliceblue;">하</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=5&product_num=${productVO.product_num}';">미처리</div>
                                </c:when>
                                <c:when test="${productVO.grade_num == 3}">
                                  <div onclick="location.href='/kdy/productGrade?grade_num=1&product_num=${productVO.product_num}';">특</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=2&product_num=${productVO.product_num}';">상</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=3&product_num=${productVO.product_num}';" style="color: aliceblue;">중</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=4&product_num=${productVO.product_num}';">하</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=5&product_num=${productVO.product_num}';">미처리</div>
                                </c:when>
                                <c:when test="${productVO.grade_num == 2}">
                                  <div onclick="location.href='/kdy/productGrade?grade_num=1&product_num=${productVO.product_num}';">특</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=2&product_num=${productVO.product_num}';" style="color: aliceblue;">상</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=3&product_num=${productVO.product_num}';">중</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=4&product_num=${productVO.product_num}';">하</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=5&product_num=${productVO.product_num}';">미처리</div>
                                </c:when>
                                <c:otherwise>
                                  <div onclick="location.href='/kdy/productGrade?grade_num=1&product_num=${productVO.product_num}';" style="color: aliceblue;">특</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=2&product_num=${productVO.product_num}';">상</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=3&product_num=${productVO.product_num}';">중</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=4&product_num=${productVO.product_num}';">하</div>&emsp;
                                  <div onclick="location.href='/kdy/productGrade?grade_num=5&product_num=${productVO.product_num}';">미처리</div>
                                </c:otherwise>
                              </c:choose>
                        </c:when>
                        <c:otherwise>
                          <c:choose>
                            <c:when test="${productVO.grade_num == 5}">
                              <div onclick="noClick()">특</div>&emsp;
                              <div onclick="noClick()">상</div>&emsp;
                              <div onclick="noClick()">중</div>&emsp;
                              <div onclick="noClick()">하</div>&emsp;
                              <div onclick="noClick()" style="color: aliceblue;">미처리</div>
                            </c:when>
                            <c:when test="${productVO.grade_num == 4}">
                              <div onclick="noClick()">특</div>&emsp;
                              <div onclick="noClick()">상</div>&emsp;
                              <div onclick="noClick()">중</div>&emsp;
                              <div onclick="noClick()" style="color: aliceblue;">하</div>&emsp;
                              <div onclick="noClick()">미처리</div>
                            </c:when>
                            <c:when test="${productVO.grade_num == 3}">
                              <div onclick="noClick()">특</div>&emsp;
                              <div onclick="noClick()">상</div>&emsp;
                              <div onclick="noClick()" style="color: aliceblue;">중</div>&emsp;
                              <div onclick="noClick()">하</div>&emsp;
                              <div onclick="noClick()">미처리</div>
                            </c:when>
                            <c:when test="${productVO.grade_num == 2}">
                              <div onclick="noClick()">특</div>&emsp;
                              <div onclick="noClick()" style="color: aliceblue;">상</div>&emsp;
                              <div onclick="noClick()">중</div>&emsp;
                              <div onclick="noClick()">하</div>&emsp;
                              <div onclick="noClick()">미처리</div>
                            </c:when>
                            <c:otherwise>
                              <div onclick="noClick()" style="color: aliceblue;">특</div>&emsp;
                              <div onclick="noClick()">상</div>&emsp;
                              <div onclick="noClick()">중</div>&emsp;
                              <div onclick="noClick()">하</div>&emsp;
                              <div onclick="noClick()">미처리</div>
                            </c:otherwise>
                          </c:choose>
                        </c:otherwise>
                      </c:choose>
                        </div>   
                    </div>
                  </div><!-- End Info Item -->
                    <div class="info-item d-flex" style="height: 95px;">
                    <i class="bi bi-envelope flex-shrink-0"></i>
                    <c:choose>
                      <c:when test="${productVO.stateNum == 5}">
                        <!-- <div style="margin-top: 5px; cursor: pointer;" onclick="location.href='/kdy/auctionAdd?product_num=${productVO.product_num}';"> -->
                          <div style="margin-top: 5px; cursor: pointer;" onclick="getIngAuction('${productVO.product_num}')">
                          <h4>경매 하기</h4>
                        </div>
                        </c:when>
                      <c:otherwise>
                        <div style="margin-top: 5px; cursor: pointer;" onclick="noAuction()">
                          <h4>경매 하기</h4>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </div>
                  </div><!-- End Info Item -->
                </div>
            </div>
            <div class="col-lg-8 php-email-form" style="margin-bottom: 90px; margin-top: 50px;">
              <div class="row">
                <div class="col-md-6 form-group">
                  <input type="text" name="name" class="form-control" id="information" style="border: 0;"   readonly value="상품 수량 : ${productVO.quantity}">
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                  <input type="text" class="form-control" name="email" id="information" style="border: 0;"  readonly value="상품 중량 : ${productVO.weight}">
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                  <input type="text" class="form-control" name="email" id="information" style="border: 0;"  readonly value="상품 위치 : ${productVO.product_address}">
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                  <input type="text" class="form-control" name="email" id="information" style="border: 0;"  readonly value="상품 상태 : ${productVO.deliveryStateVO.stateName}">
                </div>
                    <!-- ======= Frequently Asked Questions Section ======= -->
                    <c:choose>
                      <c:when test="${empty productVO.productFileVOs[0].fileName}">                        
                      </c:when>
                      <c:otherwise>
                        <section id="faq" class="faq">
                          <div class="container" data-aos="fade-up" style="margin-left: 150px; margin-top: -45px;">
                            <div class="row gy-4">
                              <div class="col-lg-8">
                                <div class="accordion accordion-flush" id="faqlist" data-aos="fade-up" data-aos-delay="100">
                                  <div class="accordion-item">
                                    <h3 class="accordion-header">
                                      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-1">
                                        <span class="num">-</span>
                                        상품번호 ${productVO.product_num}번의 품질을 확인해보세요
                                      </button>
                                    </h3>
                                    <div id="faq-content-1" class="accordion-collapse collapse" data-bs-parent="#faqlist">
                                      <div class="accordion-body">
                                        <c:forEach items="${productVO.productFileVOs}" var="proFile">
                                          <img alt="" src="/file/membersFile/${proFile.fileName}">
                                        </c:forEach>  
                                      </div>
                                    </div>
                                  </div><!-- # Faq item-->
                                </div>
                              </div>
                            </div>
                          </div>
                        </section><!-- End Frequently Asked Questions Section -->
                      
                      </c:otherwise>
                    </c:choose>
              </div>
                
              <div class="d-flex" style="margin-left: 400px;">
                <c:choose>
                  <c:when test="${productVO.stateNum == 1}">
                    <div class="text-center"   onclick="location.href='/kdy/deliveryUpdate?stateNum=2&product_num=${productVO.product_num}';">
                      <button type="submit" id="inquiryAddBtn">출 고</button>
                    </div>
                    <div class="text-center"   onclick="location.href='/kdy/saleTypeList';">
                      <button type="submit" id="inquiryAddBtn">뒤로가기</button>
                    </div>
                  </c:when>
                  <c:when test="${productVO.stateNum == 2}">
                    <div class="text-center"   onclick="location.href='/kdy/deliveryUpdate?stateNum=3&product_num=${productVO.product_num}';">
                      <button type="submit" id="inquiryAddBtn">출 발</button>
                    </div>
                    <div class="text-center"   onclick="location.href='/kdy/saleTypeList';">
                      <button type="submit" id="inquiryAddBtn">뒤로가기</button>
                    </div>
                  </c:when>
                  <c:when test="${productVO.stateNum == 3}">
                    <div class="text-center">
                      <button type="submit" id="inquiryAddBtn" style=" opacity: 0.5;">출 발</button>
                    </div>
                    <div class="text-center"   onclick="location.href='/kdy/saleTypeList';">
                      <button type="submit" id="inquiryAddBtn">뒤로가기</button>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="text-center"   onclick="location.href='/kdy/saleTypeList';">
                      <button type="submit" id="inquiryAddBtn">뒤로가기</button>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
          </div>
            </div>
        </div>
      </div>
    </div>
        <c:import url="../common/footer.jsp"></c:import>
        
    <!--  현재 진행 중인 방송이 있는지 판별 -->    
    <script type="text/javascript" src="/static/js/auction/getIng.js"></script>
</body>
</html>