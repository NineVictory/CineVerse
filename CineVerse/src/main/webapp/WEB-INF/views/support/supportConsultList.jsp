<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 1:1 문의 -->
<div id="support_main" class="">
	<h3>공지/뉴스</h3>
<%-- 	<div class="qna-search-container">
		<div class="search flexbox-h">
			<form action="news" id="qna_search_form" class="flexbox-h" method="get" style="margin-left: auto;">
		
				<select>
					<option value="title">제목</option>
	           		<option value="content">내용</option>
	           		<option value="content">내용</option>
				</select>
		
				<input type="hidden" name="" value="">
				<input type="search" class="search-input" name="keyword" placeholder="검색어를 입력해 주세요">
				<button type="submit" class="search-button" aria-label="검색하기">검색</button>
            </form>
        </div>
	</div> --%>
	<div class="flexbox-h side qna-top">
		<div><input type="checkbox"><span>나의 문의글</span></div>
		<input type="button" value="글쓰기" onclick="location.href='consultForm'" class="c-write-btn">
	</div>
	<table class="qna-table">
		<tr>
			<td class="qna-table-num">번호</td>
			<td class="qna-table-title">제목</td>
			<td class="qna-table-writer">작성자</td>
			<td class="qna-table-rdate">작성일</td>
			<td class="qna-table-status">처리상태</td>
		</tr>
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
	</table>
	<div class="align-center page-div">
			${page}
		</div>
</div>