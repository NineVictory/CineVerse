<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var currentUrl = window.location.href;
        
        if (currentUrl.includes("?cb_type=movieTalk")) {
            document.getElementById("link-type1").classList.add("active");
        } else if (currentUrl.includes("?cb_type=dailyTalk")) {
            document.getElementById("link-type2").classList.add("active");
        } else {
            document.getElementById("link-all").classList.add("active");
        }
    });
</script>

<div class="page-container page-main">
	
	<div class="board-main">
		<h2>커뮤니티</h2>
		
		<div class="write-btn-container">
		
		<c:if test="${!empty user}">
			<input type="button" class="write-btn default-btn" value="글쓰기" onclick="location.href='write'">
		</c:if>
				
		</div>
		<table class="board-table">
			<thead>
				<tr>
					<td colspan="2">
						<div class="types">
							<a href="list" id="link-all">전체</a>
							<a href="list?cb_type=movieTalk" id="link-type1">영화톡톡</a>
							<a href="list?cb_type=dailyTalk" id="link-type2">일상톡톡</a>
						</div>
					</td>
					<td colspan="2" style="text-align: right;">
						<div class="search">
							<form action="list" id="search_form" method="get" style="margin-left: auto;">
								<select id="order" name="order">
								<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
								<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
								<option value="3" <c:if test="${param.order == 3}">selected</c:if>>좋아요</option>
								<option value="4" <c:if test="${param.order == 4}">selected</c:if>>댓글수</option>
								</select>
								<script type="text/javascript">
									$('#order').change(function(){>
										location.href='list?cb_type=${param.cb_type}&keyword='+$('#keyword').val()+'&order='+$('#order').val();
									});
								</script>
								
								<input type="hidden" name="cb_type" value="${param.cb_type}">
								<input type="search" class="search-input" name="keyword" placeholder="제목,내용,작성자 검색">
								<button type="submit" class="search-button" aria-label="검색"></button>
								<%--<input type="image" src="${pageContext.request.contextPath}/images/kbm/search.png" width="20" alt="검색"> --%>
		                   		
		                   		
		                   </form>
		               </div>
		           </td>
		       </tr>
			</thead>
			<tbody>
			<c:if test="${count == 0}">
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
							<div class="writer">
								<img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${board.mem_num}" width="18" height="18" class="my-photo">&nbsp;
								<c:if test="${empty board.mem_nickname}">
									${board.mem_id}&nbsp;&nbsp; ${board.cb_reg_date}
								</c:if>
								<c:if test="${!empty board.mem_nickname}">
									${board.mem_nickname}&nbsp;&nbsp; ${board.cb_reg_date}
								</c:if>
							</div>
						</div>
					</td>
				</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
			<c:if test="${count > 0}"><div class="align-center page-count">${page}</div></c:if>
	</div>
</div>