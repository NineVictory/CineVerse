<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<div class="page-container">

<div class="admin_member">
	<div class="firstTitle">
		<p id="title">통합게시판</p>
	</div>
	<form action="adminSearch" id="admin_search">
		<ul>
			<li><input type="search" name="search" placeholder="제목을 입력하세요">
				<input type="submit" value="" class="search-button"
				style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
			</li>
		</ul>
	</form>
	<p id="sub_title2">통합게시판 관리</p>
	<table class="adminMember-table">
		<thead>
			<tr>
				<th>글 번호</th>
				<th>게시판 종류</th>
				<th>회원번호</th>
				<th>제목</th>
				<th>분류</th>
				<th>신고수</th>
				<th>조회수</th>
				<th>작성일</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${adminList}">
			<c:choose>
	        <c:when test="${item.getClass().simpleName eq 'BoardVO'}">
			<c:if test = "${!empty item.cb_num}">
				<tr>
					<td class="mem-data">${item.cb_num}</td>
					<td class="mem0date">커뮤니티</td>
					<td class="mem-data">${item.mem_num}</td>
					<td class="mem-data">${item.cb_title}</td>
					<c:if test="${item.cb_type == 'dailyTalk'}">
						<td class="mem-data">일상톡톡</td>
					</c:if>
					<c:if test="${item.cb_type == 'movieTalk'}">
						<td class="mem-data">영화톡톡</td>
					</c:if>
					<td class="mem-data">${item.cb_report}</td>
					<td class="mem-data">${item.cb_hit}</td>
					<td class="mem-data">${item.cb_reg_date}</td>
					<td class="button2"><input type="button" value="삭제" /></td>
				</tr>
			</c:if>
			</c:when>
			
			<c:when test="${item.getClass().simpleName eq 'AssignVO'}">
			<c:if test = "${!empty item.ab_num}">
				<tr>
					<td class="mem-data">${item.ab_num}</td>
					<td class="mem0date">양도/교환</td>
					<td class="mem-data">${item.mem_num}</td>
					<td class="mem-data">${item.ab_title}</td>
					<c:if test="${item.ab_type == 1}">
						<td class="mem-data">판매중</td>
					</c:if>
					<c:if test="${item.ab_type == 2}">
						<td class="mem-data">예약중</td>
					</c:if>
					<c:if test="${item.ab_type == 2}">
						<td class="mem-data">판매완료</td>
					</c:if>
					<td class="mem-data">${item.ab_report}</td>
					<c:if test = "${item.ab_hit != 0}">
					<td class="mem-data">${item.ab_hit}</td>
					</c:if>
					<c:if test = "${item.ab_hit == 0}">
					<td class="mem-data">조회수없음</td>
					</c:if>
					<td class="mem-data">${item.ab_reg_date}</td>
					<td class="button2"><input type="button" value="삭제" /></td>
				</tr>
			</c:if>
			</c:when>
			</c:choose>
			</c:forEach>
		</tbody>
	</table>

</div>
</div>
