<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<div class="page-container">
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">결제 관리</p>
	</div>
		<form action="adminPayment" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mem_num'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="회원번호를 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
	<table class="adminMember-table">
        <thead>
            <tr>
                <th>결제번호</th>
                <th>충전금액</th>
                <th>충전일</th>
                <th>회원번호</th>
                <th>결제수단</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="point" items="${list}">
                <tr>
                    <td class="mem-data">${point.ph_num}</td>
                    <td class="mem-data">${point.ph_point}</td>
                    <td class="mem-data">${point.ph_date}</td>
                    <td class="mem-data">${point.mem_num}</td>
                    <td class="mem-data">${point.ph_payment}</td>
                    <td class="button2"><input type="button" value="결제취소" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
	<div class="page-div">${page}</div> 
</div>
