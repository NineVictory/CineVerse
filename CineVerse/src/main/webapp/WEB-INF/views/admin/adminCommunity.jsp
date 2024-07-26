<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="page-container">
	<div class="admin_member">
		<div class="firstTitle">
			<p id="title">자유게시판 관리</p>
		</div>
		<form action="adminCommunity" id="admin_search">
			<ul>
				<li><input type="hidden" name="keyfield"
					value="${param.keyfield != null ? param.keyfield : 'cb_title'}">
					<!-- 기본값 설정 --> <input type="search" name="keyword" id="keyword"
					value="${param.keyword}" placeholder="지점명을 입력하세요"> <input
					type="submit" value="" class="search-button"
					style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<div class="body_table">
		<table class="adminMember-table">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>종류</th>
					<th>신고수</th>
					<th>조회수</th>
					<th>작성일</th>
					<th></th>
				</tr>
			</thead>
			<c:if test="${empty list}">
				<tr>
					<td colspan="7" class="mem-data">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<tbody>
				<c:forEach var="cb" items="${list}">
					<tr>
						<td class="mem-data">${cb.cb_num}</td>
						<td class="mem-data">${cb.mem_num}</td>
						<td class="mem-data">${cb.cb_title}</td>
						<c:if test="${cb.cb_type == 'movieTalk'}">
							<td class="mem-data">영화톡톡</td>
						</c:if>
						<c:if test="${cb.cb_type == 'dailyTalk'}">
							<td class="mem-data">일상톡톡</td>
						</c:if>
						<c:if test="${!empty cb.cb_report}">
							<td class="mem-data">${cb.cb_report}</td>
						</c:if>
						<c:if test="${empty cb.cb_report}">
							<td class="mem-data">0</td>
						</c:if>
						<c:if test="${!empty cb.cb_report}">
							<td class="mem-data">${cb.cb_hit}</td>
						</c:if>
						<c:if test="${empty cb.cb_report}">
							<td class="mem-data">0</td>
						</c:if>
						<td class="mem-data">${cb.cb_reg_date}</td>
						<td class="button2"><input type="button" value="삭제"
							onclick="deleteCommunity(${cb.cb_num})" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
	<div class="page-div">${page}</div>
</div>