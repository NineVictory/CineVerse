<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 자주 묻는 질문 -->
<div id="support_main" class="">
	<h3>📢 공지/뉴스</h3>
	<div class="news-sub-info">
		CINEVERSE의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.
	</div>
	<div class="news-search-container">
		<div class="search flexbox-h">
			<form action="notice" id="news_search_form" class="flexbox-h" method="get" style="margin-left: auto;">
		
				<select name="keyfield" id="keyfield">
					<option value="1">제목</option>
	           		<option value="2">내용</option>
				</select>
		
				<input type="search" class="search-input" name="keyword" placeholder="검색어를 입력해 주세요" value="${param.keyword}">
				<button type="submit" class="search-button" aria-label="검색하기">검색</button>
			<%--<input type="image" src="${pageContext.request.contextPath}/images/kbm/search.png" width="20" alt="검색"> --%>
            </form>
        </div>
	</div>
	<table class="news-table">
		<tr><%--faq,news 클래스명 합치기 --%>
			<td class="news-table-num">번호</td>
			<td class="news-table-title">제목</td>
			<td class="news-table-rdate">등록일</td>
			<td class="news-table-hit">조회수</td>
		</tr>
		<c:if test="${count == 0}">
		<tr>
			<td colspan="5">
				<div style=" height:250px; display:flex; align-items:center; justify-content: center;">공지/뉴스가 존재하지 않습니다.</div>
			</td>
		</tr>
		</c:if>
		
		<c:if test="${count > 0}">
			<c:forEach var="notice" items="${list}">
			<tr>
				<td class="news-table-num">${notice.nb_num}</td>
				<td class="news-table-title">
				 <c:choose>
                    <c:when test="${fn:length(notice.nb_title) > 40}">
                        <a href="noticeDetail?nb_num=${notice.nb_num}">${fn:substring(notice.nb_title, 0, 40)}...</a>
                    </c:when>
                    <c:otherwise>
                        <a href="noticeDetail?nb_num=${notice.nb_num}">${notice.nb_title}</a>
                    </c:otherwise>
                </c:choose>
				</td>
				<td class="news-table-rdate">${notice.nb_reg_date}</td>
				<td class="news-table-hit">${notice.nb_hit}</td>
			</tr>
			</c:forEach>
		</c:if>	
	</table>
	<div class="align-center page-div">
			${page}
	</div>
</div>