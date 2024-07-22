<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/consult.list.js"></script>
<!-- 1:1 문의 -->
<div id="support_main" class="">
	<h3>1:1 문의</h3>

	<div class="flexbox-h side qna-top">
		<div><input type="checkbox" id="myCheckbox" data-num="${member.mem_num}"><span>나의 문의글</span></div>
		<input type="button" value="글쓰기" onclick="location.href='consultForm'" class="c-write-btn">
	</div>
	<table class="qna-table">
		<tr>
			<th class="qna-table-num">번호</th>
			<th class="qna-table-title">제목</th>
			<th class="qna-table-writer">작성자</th>
			<th class="qna-table-rdate">작성일</th>
			<th class="qna-table-status">처리상태</th>
		</tr>
		<c:if test="${count == 0}">
		<tr>
			<td colspan="5">
				<div style=" height:250px; display:flex; align-items:center; justify-content: center;">문의글이 존재하지 않습니다.</div>
			</td>
		</tr>
		</c:if>
		
		<c:if test="${count > 0}">
			<c:forEach var="consult" items="${list}">
			<tr>
				<td class="qna-table-num">${consult.consult_num}</td>
				<td class="qna-table-title">
				 <c:choose>
	                    <c:when test="${fn:length(consult.consult_title) > 30}">
	                        <a href="consultDetail?consult_num=${consult.consult_num}">${fn:substring(consult.consult_title, 0, 30)}...</a>
	                    </c:when>
	                    <c:otherwise>
	                        <a href="consultDetail?consult_num=${consult.consult_num}">${consult.consult_title}</a>
	                    </c:otherwise>
	                </c:choose>
				</td>
				<td class="qna-table-writer">${consult.mem_id}</td>
				<td class="qna-table-rdate">${consult.consult_reg_date}</td>
				<td class="qna-table-status">
					<c:if test="${consult.consult_status == 1}">미답변</c:if>
					<c:if test="${consult.consult_status == 2}">답변완료</c:if>
				</td>
			</tr>
			</c:forEach>
		</c:if>	
	</table>
	<div class="align-center page-div">
			${page}
	</div>
</div>