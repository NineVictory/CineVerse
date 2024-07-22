<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/board.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/board.reply.js"></script>

<div class="page-container page-main">
	<div class="boardview-main">
	<div class="board-info">
		<div class="flexbox-h side">
			<div class="ml10">
				<span>
					<c:if test="${board.cb_type == 'movieTalk'}">영화톡톡</c:if>
					<c:if test="${board.cb_type == 'dailyTalk'}">일상톡톡</c:if>
				</span>
			</div>
			<div>
				<c:if test="${empty board.cb_modify_date}">
				<span>${board.cb_reg_date}</span>
				</c:if>
				<c:if test="${!empty board.cb_modify_date}">
				<span>수정일 ${board.cb_modify_date}</span>
				</c:if>			
			</div>
		</div>
		
		<div class="flexbox-h side">
			<div class="p-center board-title-bm">
				<h3>${board.cb_title}</h3><img src="${pageContext.request.contextPath}/images/kbm/bookmark01.png" width="25" height="22" id="bookmark" data-num="${board.cb_num}">
			</div>
			<div class="p-center hit-comment">
				<img src="${pageContext.request.contextPath}/images/kbm/hit.png" width="18">
				<span>${board.cb_hit}</span>
				
				<img src="${pageContext.request.contextPath}/images/kbm/comment.png" width="18">
				<span class="output-rcount">0</span>
			</div>
		</div>			
					
					
		<div class="flexbox-h side">
			<div class="writer ml10">
				<img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${board.mem_num}" width="22" height="22" class="my-photo">
				<c:if test="${!empty board.mem_nickname}">
				${board.mem_nickname}
				</c:if>
				<c:if test="${empty board.mem_nickname}">
				${board.mem_id}
				</c:if>
				<%--<input type="button" class="chatBtn" id="chatBtn" value="1:1채팅">--%>
			</div>
			<div>
				<c:if test="${board.mem_num == user.mem_num}">
			
				<div class="board-btn">
					<%-- <span class="board-cbtn"><a href="" onclick="return false;"><img src="${pageContext.request.contextPath}/images/kbm/menu.png" height="23"></a></span>  --%>
						<span class="board-cbtn"><img src="${pageContext.request.contextPath}/images/kbm/menu.png" height="23"></span>
			
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
				    			location.replace('delete?cb_num=${board.cb_num}');
				    		}
				    		//기본 이벤트 제거
				    		event.preventDefault();
			        	});
			        	</script>

				</div>
				</c:if>
			</div>
		</div>
		
		</div>
		
		
		<hr size="1" width="100%">
		
		<div class="detail-content">
			${board.cb_content}
		</div>
		
		<div class="flexbox-h side">
			<span class="ml10">댓글(<span class="output-rcount">${comment_cnt}</span>)</span>
			<div class="view-likes p-center like-report">
		
				<img id="output_fav" data-num="${board.cb_num}" src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="15">
				<span id="output_fcount">0</span>
					
				<img src="${pageContext.request.contextPath}/images/kbm/report.png" width="15" height="15">
				<span style="margin-left:2px;" id="board_report">신고</span>
				
			</div>
		</div>
		<hr size="1" width="100%">
	
		<!-- 댓글 목록 출력 -->
		<div id="output"></div>
		<div id="loading" style="display:none; margin:20px 0;" class="align-center">
			<img src="${pageContext.request.contextPath}/images/kbm/loading.gif" width="30" height="30">
		</div>
		<div class="paging-button" style="display:none;">
			<input type="button" value="더보기">
		</div>
		<!-- 댓글 UI 끝 -->
		
		
		<!-- 댓글 작성 UI 시작 -->
      <div id="comment_div">
         <div class="flexbox-h">
         	<c:if test="${!empty user}">
            <img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${user.mem_num}"
               width="40" height="40" class="my-photo">
 		 	</c:if>
 		 	<c:if test="${empty user}">
            <img src="${pageContext.request.contextPath}/images/profile_none.png"
               width="40" height="40" class="my-photo">
 		 	</c:if>
	         <div id="reply_div">
	            <form id="comment_form">
	               <input type="hidden" name="cb_num" id="cb_num" value="${board.cb_num }">
	               <div class="flexbox-h">
	               <textarea rows="4" cols="115" name="cc_content" id="cc_content" class="rep-content"
	                  <c:if test="${empty user}">disabled="disabled"</c:if>><c:if
	                     test="${empty user}">로그인 후 작성 가능합니다.</c:if></textarea>
	               <c:if test="${!empty user}">
	                  <div id="re_second">
	                     <input type="submit" class="default-btn ml10" value="등록">
	                  </div>
	               </c:if>
	               </div>
	            </form>
	
	         </div>
		</div>
        
      </div>
	
		
		
		<div class="align-center">
			<input type="button" class="default-btn2 mt70" value="목록" onclick="location.href='list'">
		</div>
		
	</div>
</div>


<!-- 신고 모달 -->
<%-- <div class="modal" id="reportModal">
	<div class="modal-content">
		<span class="close" id="closeModal">&times;</span>
			<h2>신고하기</h2>
			<form:form id="reportForm">
				<div class="rform-group">
				<form:label path="reportReason">신고 사유</form:label>
				<form:radiobutton path="cr-category" value="1" checked="checked"/>스팸홍보/도배<br>
				<form:radiobutton path="cr-category" value="2" />음란물
				<form:radiobutton path="cr-category" value="3" />불법정보
				<form:radiobutton path="cr-category" value="4" />청소년에게 유해한 내용
				<form:radiobutton path="cr-category" value="5" />욕설/생명경시/혐오/차별적 표현
				<form:radiobutton path="cr-category" value="6" />개인정보 노출
				<form:radiobutton path="cr-category" value="7" />불쾌한 표현
				<form:radiobutton path="cr-category" value="8" />기타
				</div>
	            <div class="form-group">
	                <form:label path="cr-content">신고 내용</form:label>
	                <form:textarea path="cr-content" rows="3" required="true"></form:textarea>
	            </div>
            <button type="submit" class="btn">신고하기</button>
        </form:form>
    </div>
</div> --%>
