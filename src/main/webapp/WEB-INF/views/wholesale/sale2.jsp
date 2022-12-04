<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script defer src="/js/wholesale/sale2.js"></script>
</head>
<body>
    <!-- ===========header=============== -->
<c:import url="../common/header.jsp"></c:import>
<c:import url="../temp/boot.jsp"></c:import>
<!-- ================================ -->
<script>
    $(document).ready(function(){
        getJSON(1);
    })    
</script>

<div class="paging"></div>

<!--총데이터 수-->

    <table class="table table-striped" id="api">
        <thead>
            <tr>
                <td>whsalCd : 
                    <select name="whsalCd" id="whsalCd">
                        <option value="110001">가락시장</option>
                        <option value="330201">다른시장</option>
                    </select> 
                </td>
                <td>saleDate : 
                    <select name="saleDate" id="saleDate">
                        <option value="20221122">22일</option>
                        <option value="20221129">29일</option>
                    </select> 
                </td>
                <td>대분류 : 
                    <select name="largeCd" id="largeCd">
                        <option value="05">05</option>
                        <option value="06">06</option>
                    </select> 
                </td>
                <td>
                    <button type="button" onclick="getJSON(1);">검색</button>
                </td>
            </tr>
            <tr>
                <th>saleDate</th>
                <th>도매시장</th>
                <th>법인</th>
                <th>소분류</th>
            </tr>
        </thead>
        <div class="json_table">
            <tbody class="table_body">

            </tbody>

        </div>
        
       </table>
        
<!-- ===========footer=============== -->
<c:import url="../common/footer.jsp"></c:import>
<!-- ================================ -->
</body>
</html>