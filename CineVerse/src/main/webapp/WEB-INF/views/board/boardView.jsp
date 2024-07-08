<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/board.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/board.reply.js"></script>

<div class="page-container page-main">
	<div class="boardview-main">
		<div class="flexbox-h side">
			<div>
				<span>
					<c:if test="${board.cb_type == 'movieTalk'}">영화톡톡</c:if>
					<c:if test="${board.cb_type == 'swap'}">양도/교환</c:if>
				</span>
			</div>
			<div>
				<c:if test="${empty cb_modify_date}">
				<span>${board.cb_reg_date}</span>
				</c:if>
				<c:if test="${!empty cb_modify_date}">
				<span>수정일 ${board.cb_modify_date}</span>
				</c:if>			
			</div>
		</div>
		
		<h4>${board.cb_title}</h4>
		<div class="writer">
		<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${mem_num}" width="20" height="20" class="my-photo">&nbsp;${board.mem_id}
		</div>
		<div class="flexbox-h">
			<div>
			<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
			<span>${board.cb_hit}</span>
			</div>
			
			<div>
			<%-- 댓글수 --%>
			<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
			<span id="output_rcount"></span>
			</div>
			
			<div>
			<%-- 좋아요 --%>
			<img id="output_fav" data-num="${board.cb_num}" src="${pageContext.request.contextPath}/images/kbm/heart01.png">
			<span id="output_fcount"></span>
			</div>
			
		</div>
		
		
		<c:if test="${board.mem_num == user.mem_num || user.mem_auth == 9}">
				
				<ul class="board-btn-container">
					<li class="board-btn">
						<span class="board-cbtn" style="position:absolute; z-index:999; right:0; bottom:10px;"><a href="" onclick="return false;"><img src="${pageContext.request.contextPath}/images/kbm/heart01.png"></a></span>
			
						<ul class="btn-hide">
			            	<li><a href="update?cb_num=${board.cb_num}">수정</a></li>
			            	<li><a href="#" id ="delete_btn">삭제</a></li>
			        	</ul>
			        	<script type="text/javascript">
			        	$('.btn-hide').hide();
			        	$('.board-cbtn').click(function() {
			        	    $(this).parent().find('.btn-hide').toggle();
			        	});
			        	$('#delete_btn').click(function(event) {
				        	let choice = confirm('삭제하시겠습니까?');
				    		if(choice){
				    			location.replace('newsDelete.do?news_num=${news.news_num}');
				    		}
				    		//기본 이벤트 제거
				    		event.preventDefault();
			        	});
			        	</script>
					</li>
				</ul>	
				
		</c:if>
		
		
		<hr size="1" width="100%">
		
		<div class="detail-content">
			${board.cb_content}
		</div>
		
		
		<span>댓글(<span id="output_rcount"></span>)</span>
		<div><img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12" height="12"><span>신고</span></div>
		<hr size="1" width="100%">
		
		
		
		<div class="align-center">
			<input type="button" value="목록" onclick="location.href='list'">
		</div>
	
		<!-- 댓글 UI 시작 -->
		<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<form id="re_form">
				<input type="hidden" name="cb_num" value="${board.cb_num}" id="cb_num">
				<textarea rows="3" cols="50" name="re_content" id="cc_content" class="rep-content"
							<c:if test="${empty user}">disabled="disabled"</c:if>
						><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>
				<c:if test="${!empty user}">
				<div id="re_first">
					<span class="letter-count">300/300</span>
				</div>
				<div id="re_second" class="align-right">
					<input type="submit" value="전송">
				</div>
				</c:if>
			</form>
		</div>
		<!-- 댓글 목록 출력 -->
		<div id="output"></div>
		<div id="loading" style="display:none;">
			<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="30" height="30">
		</div>
		<div class="paging-button" style="display:none;">
			<input type="button" value="더보기">
		</div>
		<!-- 댓글 UI 끝 -->
		
	</div>
</div>