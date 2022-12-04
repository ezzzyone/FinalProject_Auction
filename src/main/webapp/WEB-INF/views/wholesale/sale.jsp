<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- ===========header=============== -->
<c:import url="../common/header.jsp"></c:import>
<!-- ================================ -->
<h1> Real Time List</h1>

<table class="table table-striped">
<thead>
<tr><th>saleDate</th><th>도매시장</th><th>법인</th><th>소분류</th></tr>
</thead>
<tbody>
<c:forEach items="${vo}" var="vos">
<tr>
<td>${vos.saleDate}</td>
<td>${vos.whsalName}</td>
<td>${vos.cmpName}</td>
<td>${vos.smallName}</td>
</tr>
</c:forEach>
</tbody>
</table>

 <!-- pagination start -->
    <div class="chefs section-bg" style="padding-bottom: 10px;">
      <nav aria-label="Page navigation example">
        <ul class="pagination">
        <!-- 이전페이지가 없으면 	버튼 비활성화  -->
          <li class="page-item ${pager.pre?'':'disabled'}">
          <!-- page 파라미터가 조정되면 -- startNum/lastNum이 변경되어 출력 리스트가 변경됨 -->
          <!-- 1. page 파라미터 변경함으로써 다음 페이지 조정  -->
            <a class="page-link" href="./list?page=${pager.startNum-1}&search=${pager.search}" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a> 
          </li> 


          <!-- 조정된 다음 페이지를 기준으로 startNum t0 lastNum까지 반복문돌려 블럭 형성  -->
          <c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
            <li class="page-item"><a class="page-link" href="./list?page=${i}&search=${pager.search}"> ${i}</a> </li>
          </c:forEach> 

          
          <li class="page-item ${pager.next?'':'disabled'}">
            <a class="page-link" href="./list?page=${pager.lastNum+1}&search=${pager.search}" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>
    <!-- pagination end --> 
<!-- ===========footer=============== -->
<c:import url="../common/footer.jsp"></c:import>
<!-- ================================ -->
</body>
</html>