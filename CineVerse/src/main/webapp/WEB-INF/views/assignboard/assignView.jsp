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
		<div class="board-btn">
				<span class="board-cbtn"><a href="" onclick="return false;"><img src="${pageContext.request.contextPath}/images/kbm/menu.png" height="23"></a></span>
	
				<ul class="btn-hide">
	            	<li><a href="update">수정</a></li>
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
		    			location.replace('delete');
		    		}
		    		//기본 이벤트 제거
		    		event.preventDefault();
	        	});
	        	</script>
		</div>

	
		<hr size="1" width="100%">
	
		<div class="assign-info-container 상품정보">
		
			<div class="flexbox-h side">
				<div class="marg445">
				<img src="${pageContext.request.contextPath}/images/kbm/ot.png" width="420">
				</div>
				<div class="marg445">
					<div class="flexbox-p simple-info">
						<h3>퓨리오사 오리지널 티켓 2종 굿즈</h3>
						<span>양도</span>
						<span><b>30000</b>원</span>
						<div class="flexbox-h side">
							<div class="">
								<div>
								<%-- 북마크 --%>
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
								<span>5</span>
								&nbsp;&nbsp;
								<%-- 조회수 --%>
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
								<span>25</span>
								</div>
							</div>
							<div>
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="15" height="15"><span style="margin-left:2px;" id="board-report">신고하기</span>
							</div>
						</div>
						<div>
							<div> 상품상태  <b>새 상품</b></div>
						</div>
						<div>
							<div> 배송비 일반 4000원 | gs반값 2000원</div>
						</div>
						<div>
							<input type="button" value="찜">
							<input type="button" value="채팅">
						</div>
					</div>
				</div>
			</div><%--상품텍스트 --%>
		</div>
		
		<hr size="1" width="100%">
	
		<div class="flexbox-p assign-info-container">
			<div class="info-detail">
				<span class="info-detail-top">상품정보</span>
			</div>
			<div>
				<div class="info-detail-main">
					퓨리오사 오리지널 티켓 메가박스 굿즈 특전<br>
					총 3장 일괄 판매합니다.
					편의점 반값택배로 보내드리고 반값택배비는 1800원입니다.
				</div>
			</div>
		</div>
		
		<div>
			<div class="flexbox-h side">
			<span class="ml10">댓글(2)</span>
			
			</div>
			<hr size="1" width="100%">
		</div>	
		
		<div class="댓글">
			<!-- 댓글 목록 출력 -->
			 //댓글 출력//
			<div id="output"></div>
			<div id="loading" style="display:none;">
				<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="30" height="30">
			</div>
			<div class="paging-button" style="display:none;">
				<input type="button" value="더보기">
			</div>
			<!-- 댓글 출력 끝 -->
		
		
			<!-- 댓글 작성 UI 시작 -->
			<div id="reply_div" class="ml10 mt10">
				<div><span class="re-title">댓글쓰기</span></div>
				<div class="flexbox-h">
					<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${mem_num}" width="45" height="45" class="my-photo">
					<form id="re_form">
						<%-- <input type="hidden" name="ab_num" value="${board.ab_num}" id="ab_num"> --%>
							<div class="flexbox-h">
								<textarea rows="4" cols="105" name="re_content" id="ac_content" class="rep-content"
											<c:if test="${empty user}">disabled="disabled"</c:if>
											<c:if test="${!empty user}">placeholder="내용을 입력해주세요."</c:if>
										><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>
								<c:if test="${!empty user}">
								<!-- <div id="re_first">
									<span class="letter-count">300/300</span>
								</div> -->
									<input type="submit" class="default-btn ml10" value="등록">
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