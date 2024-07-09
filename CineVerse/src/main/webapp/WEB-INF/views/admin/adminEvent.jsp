<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">이벤트</p>
	</div>
		<form action="adminSearch" id="admin_search">
			<ul>
				<li>
					<input type="search" name="search" placeholder="제목을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<p id = "sub_title2">이벤트 관리</p>
		<input type = "button" value = "이벤트 등록" class = "insert_button"/>
	<table class="adminMember-table">
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>조회수</th>
			<th>등록일</th>
			<th></th>
		</tr>
		<tr>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="mem-data">데이터</td>
			<td class="button2"><input type ="button" value = "삭제"/></td>
		</tr>
		
	</table>

</div>