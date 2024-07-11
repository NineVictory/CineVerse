<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="admin_member">
	<div class="firstTitle">
		<p id="title">공지사항</p>
	</div>
	<form action="adminSearch" id="admin_search">
		<ul>
			<li><input type="search" name="search" placeholder="회원명을 입력하세요">
				<input type="submit" value="" class="search-button"
				style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
			</li>
		</ul>
	</form>
	<p id = "sub_title2">공지사항 관리</p>
	<input type = "button" value = "공지사항 등록" class = "insert_button" onclick = "location.href ='${pageContext.request.contextPath}/admin/adminNoticeForm'"/>
	<table class="adminMember-table">
		<thead>
			<tr>
				<th>글 번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>등록일</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="notice" items="${adminList}">
				<tr>
					<td class="mem-data">${notice.nb_num}</td>
					<td class="mem-data">${notice.nb_title}</td>
					<td class="mem-data">${notice.nb_hit}</td>
					<td class="mem-data">${notice.nb_reg_date}</td>
					<td class="button2"><input type="button" value="삭제" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>