<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 영화관 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2>영화관 목록</h2>
	<div>
		<a href="cinemaList2">전체</a> |
		<a href="cinemaList2?c_location=1">서울</a> |
		<a href="cinemaList2?c_location=2">경기</a> |
		<a href="cinemaList2?c_location=3">인천</a> |
		<a href="cinemaList2?c_location=4">강원</a> |
		<a href="cinemaList2?c_location=5">대전/충청</a> |
		<a href="cinemaList2?c_location=6">경상</a> |
		<a href="cinemaList2?c_location=7">광주/전라</a>
		
	</div>
	<form action="list" id="search_form" method="get">
		<input type="hidden" name="c_location"  value="${param.c_location}">
	</form>
	<input type="button" value="영화관 등록"   onclick="location.href='cinemaWrite'">
	<c:if test="${count == 0}">
	<div class="result-display">표시할 영화관이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<c:forEach var="cinema" items="${list}">
		<tr>
			<td class="align-left"><a href="detail?c_num=${cinema.c_num}">${cinema.c_branch}</a></td>
		</tr>
		</c:forEach>
	</table>
	</c:if>	
</div>
<!-- 영화관 목록 끝 -->





