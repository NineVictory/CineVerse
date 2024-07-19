<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="page-container">
	<div class="admin_member">
		<div class="firstTitle">
			<p id="title">게시판 댓글 관리</p>
		</div>
		<form action="adminReply" id="admin_search">
			<ul>
				<li><input type="hidden" name="keyfield"
					value="${param.keyfield != null ? param.keyfield : 'mem_num'}">
					<!-- 기본값 설정 --> <input type="search" name="keyword" id="keyword"
					value="${param.keyword}" placeholder="회원명을 입력하세요"> <input
					type="submit" value="" class="search-button"
					style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<table class="adminMember-table">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성일</th>
					<th>신고수</th>
					<th></th>
				</tr>
			</thead>
			<c:if test="${empty list}">
				<tr>
					<td colspan="7" class="mem-data">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<tbody>
				<c:forEach var="re" items="${list}">
					<tr>
						<c:if test="${!empty re.cb_num}">
						<td class="mem-data">${re.cb_num}</td>
						<td class="mem-data">${re.mem_num}</td>
						<td class="mem-data">${re.cc_title}</td>						
						<td class="mem-data">${re.cc_content}</td>
						<td class="mem-data">${re.cc_reg_date}</td>
						
						<c:if test="${!empty re.cc_report}">
							<td class="mem-data">${re.cc_report}</td>
						</c:if>
						<c:if test="${empty re.cc_report}">
							<td class="mem-data">0</td>
						</c:if>
						<c:if test="${!empty re.cc_report}">
							<td class="mem-data">${re.re_hit}</td>
						</c:if>
						<c:if test="${empty re.cc_report}">
							<td class="mem-data">0</td>
						</c:if>

						</c:if>
						<td class="button2"><input type="button" value="삭제"
							onclick="deleteReply(${re.mem_num})" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="page-div">${page}</div>
	</div>