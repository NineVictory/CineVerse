<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<div class="page-container page-main">
	
	<div class="board-main">
		<h2>양도/교환</h2>
		
		<div class="write-btn-container">
		<c:if test="${!empty user}">
			<input type="button" class="write-btn default-btn" value="글쓰기" onclick="location.href='write'">
		</c:if>
		</div>
		<table class="board-table">
			<thead>
				<tr>
					<td colspan="2">
						
					</td>
					<td colspan="2" style="text-align: right;">
						<div class="search">
							<form action="list" id="search_form" method="get" style="margin-left: auto;">
								<input type="search" class="search-input" name="keyword" placeholder="제목,내용,작성자 검색">
								<button type="submit" class="search-button" aria-label="검색"></button>
		                   </form>
		               </div>
		           </td>
		       </tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="4">
					<div class="cell-content">
						<div class="title"><a href="detail">티켓 무료 나눔합니다</a></div>
						<div class="likes-container"><div class="likes"><img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>20</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>2</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>5</span></div></div>
						<div class="writer"><img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${board.mem_num}" width="18" height="18" class="my-photo">&nbsp;moja&nbsp;&nbsp; 24.07.09</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="cell-content">
						<div class="title"><a href="detail">티켓 무료 나눔합니다</a></div>
						<div class="likes-container"><div class="likes"><img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>20</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>2</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>5</span></div></div>
						<div class="writer"><img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${board.mem_num}" width="18" height="18" class="my-photo">&nbsp;moja&nbsp;&nbsp; 24.07.09</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="cell-content">
						<div class="title"><a href="detail">티켓 무료 나눔합니다</a></div>
						<div class="likes-container"><div class="likes"><img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>20</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>2</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>5</span></div></div>
						<div class="writer"><img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${board.mem_num}" width="18" height="18" class="my-photo">&nbsp;moja&nbsp;&nbsp; 24.07.09</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="cell-content">
						<div class="title"><a href="detail">티켓 무료 나눔합니다</a></div>
						<div class="likes-container"><div class="likes"><img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>20</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>2</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>5</span></div></div>
						<div class="writer"><img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${board.mem_num}" width="18" height="18" class="my-photo">&nbsp;moja&nbsp;&nbsp; 24.07.09</div>
					</div>
				</td>
			</tr>
			
			
			<%-- <c:if test="${count == 0}">
				<tr>
 					<td colspan="4">
						<div style="height:250px; display:flex; align-items:center; justify-content: center;">표시할 게시물이 없습니다.</div>
					</td>
				</tr>
			</c:if>
			
			<c:if test="${count > 0}">
				<c:forEach var="board" items="${list}">
				<tr>
					<td colspan="4">
						<div class="cell-content">
							<div class="title"><a href="detail?cb_num=${board.cb_num}">${board.cb_title}</a></div>
							<div class="likes-container"><div class="likes"><img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>${board.cb_hit}</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>${board.re_cnt}</span> <img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12px;"><span>${board.fav_cnt}</span></div></div>
							<div class="writer"><img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${board.mem_num}" width="18" height="18" class="my-photo">&nbsp;${board.mem_id}&nbsp;&nbsp; ${board.cb_reg_date}</div>
						</div>
					</td>
				</tr>
				</c:forEach>
			</c:if> --%>
			</tbody>
		</table>
	</div>
</div>