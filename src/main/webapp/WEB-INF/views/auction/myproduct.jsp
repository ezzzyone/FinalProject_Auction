<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <!-- Jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
<c:import url="../common/header.jsp"></c:import>

<!-- 내 낙찰 목록 Main Contents-->
<div class="container">

    <!-- Page Heading -->
    <div class="card-header py-3" style="margin-top: 30px;">
        <div class="section-header">
            <h2>구매 목록</h2>
        </div>
    </div>

    <input type="hidden" value="${fn:length(list)}" id="lengthoflist">
    <div class="row" id="list-main" style="height: 490px; width: 1320px;"> 
        <c:choose>
            <c:when test="${fn:length(list) != 0}">
                <c:forEach items="${list}" var="vo" varStatus="status">
                    <div class="col-6 list-group" onclick="location.href='../kdy/deliverySelect?product_num=${vo.product_num}';">
                        <a href="#" class="list-group-item list-group-item-action" aria-current="true">
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1">${vo.name}</h5>
                            <c:choose>
                                <c:when test="${vo.stateNum == 1}">
                                    <small>발송 준비중</small>
                                </c:when>
                                <c:when test="${vo.stateNum == 2}">
                                    <small>출고</small>
                                </c:when>
                                <c:when test="${vo.stateNum == 3}">
                                    <small>배송출발</small>
                                </c:when>
                                <c:when test="${vo.stateNum == 4}">
                                    <small>배송완료</small>
                                </c:when>
                                <c:when test="${vo.stateNum == 5}">
                                    <small>판매중</small>
                                </c:when>
                                <c:otherwise>
                                    <small>정보없음</small>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="mb-1">원산지 : ${vo.product_address}</p>
                        <p class="mb-1">구매일자 : ${vo.auctionVO.sign_date}</p>
                        <p class="mb-1" id="award${status.count}">${vo.auctionVO.award}</p>
                        <c:choose>
                            <c:when test="${vo.grade_num == 1}">
                                <small>등급 : 특</small>
                            </c:when>
                            <c:when test="${vo.grade_num == 2}">
                                <small>등급 : 상</small>
                            </c:when>
                            <c:when test="${vo.grade_num == 3}">
                                <small>등급 : 특</small>
                            </c:when>
                            <c:when test="${vo.grade_num == 4}">
                                <small>등급 : 하</small>
                            </c:when>
                            <c:otherwise>
                                <small>등급 : 미처리</small>
                            </c:otherwise>                            
                        </c:choose>
                        </a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="margin: 0 auto; display : flex;
                justify-content: center;
                align-items : center;">
                    <h3 class="opacity-50">낙찰 정보가 없습니다.</h3>
                </div>
            </c:otherwise>
        </c:choose>
       
    </div>
    
    <div class="row" style="margin-top: 30px;">
    	<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<li class="page-item ${pager.pre?'':'disabled'}">
					<a class="page-link" href="./getmyproduct?page=${pager.startNum-1}">《</a>
				</li>
			<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
				<li class="page-item">
					<a class="page-link" href="./getmyproduct?page=${i}">${i}</a>
				</li>	
			</c:forEach>
				<li>
					<a class="page-link ${pager.next?'':'disabled'}" href="./getmyproduct?page=${pager.lastNum+1}">》</a>
				</li>
			</ul>
		</nav>
    </div>    
</div>
<!-- End of Main Content -->



<script src="/static/js/auction/mylist.js"></script>
<c:import url="../common/footer.jsp"></c:import>

</body>
</html>