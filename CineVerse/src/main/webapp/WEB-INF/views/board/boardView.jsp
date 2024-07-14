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
			<h3>${board.cb_title}</h3>
			<div>
				<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="12" height="12"><span style="margin-left:2px;" id="board-report">신고</span>
				
			</div>
		</div>			
					
					
		<div class="flexbox-h side">
			<div class="writer ml10">
				<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${board.mem_num}" width="20" height="20" class="my-photo">&nbsp;${board.mem_id}&nbsp;&nbsp;&nbsp;<input type="button" class="chatBtn" id="chatBtn" value="1:1채팅">
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
			<span class="ml10">댓글(<span class="output-rcount">0</span>)</span>
			<div class="likes">
				<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
				<span>${board.cb_hit}</span>
				
				<%-- 댓글수 --%>
				<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
				<span class="output-rcount">0</span>
				
				<%-- 좋아요 --%>
					<img id="output_fav" data-num="${board.cb_num}" src="${pageContext.request.contextPath}/images/kbm/heart01.png">
					<span id="output_fcount">0</span>
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
		
		
		<!-- 댓글 UI 시작 -->
		<div id="comment_div" class="ml10 mt10">
			<div class="flexbox-h">
				<c:if test="${empty user}">
					<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${user.mem_num}" width="40" height="40" class="my-photo">
					<textarea rows="4" cols="105" name="cc_content" id="cc_content" class="rep-content"
										<c:if test="${empty user}">disabled="disabled"</c:if>
									>로그인해야 작성할 수 있습니다.</textarea>
				</c:if>
				<c:if test="${!empty user}">
					<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${user.mem_num}" width="40" height="40" class="my-photo">
					<span>
						<c:if test="${empty user.mem_nickname}">
									${user.mem_id}
						</c:if>
						<c:if test="${!empty board.mem_nickname}">
							${board.mem_nickname}
						</c:if>
					</span>
					<form id="comment_form">
						<input type="hidden" name="cb_num" value="${board.cb_num}" id="cb_num">
							<div class="flexbox-h">
								<textarea rows="4" cols="105" name="cc_content" id="cc_content" class="rep-content"
											placeholder="내용을 입력해주세요."></textarea>
								
									<input type="submit" class="default-btn ml10" value="등록">
								
					
							</div>
					</form>
				</c:if>
			</div>
		</div>
		
		
		<div class="align-center">
			<input type="button" class="default-btn2 mt70" value="목록" onclick="location.href='list'">
		</div>
		
	</div>
</div>