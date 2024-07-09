<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">맴버십관리</p>
	</div>
		<form action="adminSearch" id="admin_search">
			<ul>
				<li>
					<input type="search" name="search" placeholder="회원명을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
	<table class="adminMember-table">
		<tr>
			<th>회원번호</th>
			<th>이름</th>
			<th>아이디</th>
			<th>등급</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th></th>
		</tr>
		<tr>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="button2"><input type ="button" value = "구독취소"/></td>
		</tr>
		
	</table>
</div>