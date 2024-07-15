<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/board.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/assignboard.bookmark.js"></script>

<div class="page-container page-main">
	<div class="boardview-main">
		<div class="assboard-btn">
				<span class="assboard-cbtn"><a href="" onclick="return false;"><img src="${pageContext.request.contextPath}/images/kbm/menu.png" height="23"></a></span>
	
				<ul class="btn-hide">
	            	<li><a href="update?ab_num=${assign.ab_num}">수정</a></li>
	            	<li><a href="#" id ="delete_btn">삭제</a></li>
	        	</ul>
	        	
	        	<script type="text/javascript">
	        	$('.btn-hide').hide();
	        	$('.assboard-cbtn').click(function() {
	        	    $(this).parent().find('.btn-hide').toggle();
	        	});
	        	$('#delete_btn').click(function(event) {
		        	let choice = confirm('삭제하시겠습니까?');
		    		if(choice){
		    			location.replace('delete?ab_num=${assign.ab_num}');
		    		}
		    		//기본 이벤트 제거
		    		event.preventDefault();
	        	});
	        	</script>
		</div>

	
		<hr size="1" width="100%">
	
		<div class="assign-info-container 상품정보">
		
			<div class="flexbox-h side">
				<div class="marg440">
				<c:if test="${!empty assign.ab_filename}">
				<img src="${pageContext.request.contextPath}/upload/${assign.ab_filename}" width="420">
				</c:if>
				<c:if test="${empty assign.ab_filename}">
				<img src="${pageContext.request.contextPath}/images/kbm/noimage.jpg" width="420">
				</c:if>
				</div>
				<div class="marg440">
					<div class="flexbox-p simple-info">
						<span class="font15">
							<c:if test="${assign.ab_type == 'handover'}">
								양도
							</c:if>
							<c:if test="${assign.ab_type == 'exchange'}">
								교환
							</c:if>
						</span><%--양도 or 교환 카테고리 --%>
						<h2>${assign.ab_title}</h2><%--ab_title--%>
						<span class="assign-price"><b><fmt:formatNumber value="${assign.ab_price}" type="number"/></b>원</span>
						<hr size="1" width="100%" class="middle-hr">
						<div class="flexbox-h side assign-likes">
							<div class="">
								<div>
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
								<span class="output-fcount"></span><%-- 북마크 --%>
								&nbsp;&nbsp;
								
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png">
								<span>${assign.ab_hit}</span><%-- 조회수 --%>
								&nbsp;&nbsp;
								<span class="ab-status">
									<c:if test="${assign.ab_status == 1}">
										판매중
									</c:if>
									<c:if test="${assign.ab_status == 2}">
										예약중
									</c:if>
									<c:if test="${assign.ab_status == 3}">
										거래완료
									</c:if>
								</span>
								</div>
							</div>
							<div class="assign-report">
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="15" height="15"><span style="margin-left:2px;" id="board-report"><a href="#">신고하기</a></span>
							</div>
						</div>
						<div>
							<ul class="status-df">
							 	<li class="font14"><label>상품상태</label> <span>
																		 	<c:if test="${assign.ab_status == 0}">
																				새 상품(미사용)
																			</c:if>
																			<c:if test="${assign.ab_status == 1}">
																				사용감 없음
																			</c:if>
																			<c:if test="${assign.ab_status == 2}">
																				사용감 적음
																			</c:if>
																			<c:if test="${assign.ab_status == 3}">
																				사용감 많음
																			</c:if>
																			<c:if test="${assign.ab_status == 4}">
																				고장/파손 상품
																			</c:if></span>
								</li>
						
							 	<%-- <li class="font14"><label>배송비</label> <span><fmt:formatNumber value="3000" type="number"/>원</span></li> --%>
							 </ul>
						</div>
						<div class="assView-btn flexbox-h side">
							<button class="likeBtn" data-num="${assign.ab_num}" 
							
							 <c:if test="${assign.ab_status == 3}">disabled</c:if>><img src="${pageContext.request.contextPath}/images/kbm/heartwhite.png" width="16"><span> 찜 </span><span class="output-fcount"></span></button>
							<button class="ass-chatBtn"
							 <c:if test="${assign.ab_status == 3}">disabled style="background:#c7c7c7;"</c:if>><img src="${pageContext.request.contextPath}/images/kbm/heartwhite.png" width="16"><span>채팅</span></button>
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
					${assign.ab_content}
				</div>
			</div>
		</div>
		
		<div>
			<div class="flexbox-h side">
			<span class="ml10">댓글(0)</span>
			
			</div>
			<hr size="1" width="100%">
		</div>	
		
		<div class="assign-comment">
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
			<div id="reply_div" class=" mt10">
				<div><span class="re-title">댓글쓰기</span></div>
				<div class="flexbox-h">
					<c:if test="${!empty user}"><img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${user.mem_num}" width="45" height="45" class="my-photo"></c:if>
					<c:if test="${empty user}"><img src="${pageContext.request.contextPath}/images/profile_none.png" width="45" height="45" class="my-photo"></c:if>
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