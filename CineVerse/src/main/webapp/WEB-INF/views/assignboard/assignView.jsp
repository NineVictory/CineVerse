<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 게시판 글상세 시작 -->

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/talk.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/board.fav.js"></script>--%>
<script src="${pageContext.request.contextPath}/js/assignboard.bookmark.js"></script>

<div class="page-container page-main">
	<div class="boardview-main">
		<c:if test="${assign.mem_num == user.mem_num}">
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
		</c:if>

	
		<hr size="1" width="100%">
	
		<div class="assign-info-container 상품정보">
		
			<div class="flexbox-h side">
				<div class="marg440">
				
				<c:if test="${not empty filenames}">
			    <div class="slider-container">
			        <c:forEach items="${filenames}" var="filename" varStatus="loop">
			            <c:if test="${loop.index < 3}">
			                <div class="slide">
			                    <img src="${pageContext.request.contextPath}/upload/${filename}" width="420" class="item-img" alt="Image ${loop.index + 1}">
			                </div>
			            </c:if>
			        </c:forEach>
			        <c:if test="${fn:length(filenames) > 1}">
			            <div>
			                <a class="prev">&#10094;</a>
			                <a class="next">&#10095;</a>
			            </div>
			        </c:if>
			    </div>
				<script>
				    $(document).ready(function() {
				        var slideIndex = 0;
				        showSlide(slideIndex);
				
				        $('.prev').click(function() {
				            slideIndex--;
				            showSlide(slideIndex);
				        });
				
				        $('.next').click(function() {
				            slideIndex++;
				            showSlide(slideIndex);
				        });
				
				        function showSlide(index) {
				            var slides = $('.slide');
				            if (index >= slides.length) { slideIndex = 0; }
				            if (index < 0) { slideIndex = slides.length - 1; }
				            slides.hide();
				            slides.eq(slideIndex).show();
				        }
				    });
				</script>
				</c:if>
				
				<%-- <c:if test="${!empty filenames}">
				<img src="${pageContext.request.contextPath}/upload/${filenames[0]}" width="420" class="item-img">
				</c:if>--%>
				
				<c:if test="${empty filenames}">
				    <img src="${pageContext.request.contextPath}/images/kbm/noimage.jpg" width="420" class="item-img">
				</c:if> 
				
				</div>
				<div class="marg440">
					<div class="flexbox-p simple-info">
						<div class="flexbox-h side">
							<span class="font15">
								<c:if test="${assign.ab_type == 'handover'}">
									양도
								</c:if>
								<c:if test="${assign.ab_type == 'exchange'}">
									교환
								</c:if>
							</span><%--양도 or 교환 카테고리 --%>
							<div class="p-center font15">
								<img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${assign.mem_num}" width="22" height="22" class="my-photo">&nbsp;
								<c:if test="${!empty assign.mem_nickname}">
									<span>${assign.mem_nickname}</span>
								</c:if>
								<c:if test="${empty assign.mem_nickname}">
									<span>${assign.mem_id}</span>
								</c:if>
							</div>
						</div>	
						<h2>${assign.ab_title}</h2><%--ab_title--%>
						<span class="assign-price"><b><fmt:formatNumber value="${assign.ab_price}" type="number"/></b>원</span>
						<hr size="1" width="100%" class="middle-hr">
						<div class="flexbox-h side assign-likes">
							<div class="ass-detail-icon">
								<div class="p-center">
								<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" id="ass_view_like_img">
								<span class="output-fcount"></span><%-- 찜 --%>
								&nbsp;&nbsp;
								
								<img src="${pageContext.request.contextPath}/images/kbm/hit.png" width="18px;">
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
							<div class="assign-report p-center">
								<img src="${pageContext.request.contextPath}/images/kbm/report.png" width="15" height="15"><span style="margin-left:2px;" id="board-report"><a href="#">신고하기</a></span>
							</div>
						</div>
						<div>
							<ul class="status-df">
							 	<li class="font14"><label>상품상태</label> <span>
																		 	<c:if test="${assign.ab_item_status == 0}">
																				새 상품(미사용)
																			</c:if>
																			<c:if test="${assign.ab_item_status == 1}">
																				사용감 없음
																			</c:if>
																			<c:if test="${assign.ab_item_status == 2}">
																				사용감 적음
																			</c:if>
																			<c:if test="${assign.ab_item_status == 3}">
																				사용감 많음
																			</c:if>
																			<c:if test="${assign.ab_item_status == 4}">
																				고장/파손 상품
																			</c:if></span>
								</li>
						
							 	<%-- <li class="font14"><label>배송비</label> <span><fmt:formatNumber value="3000" type="number"/>원</span></li> --%>
							 </ul>
						</div>
						<div class="assView-btn flexbox-h side">
							<button class="likeBtn" data-num="${assign.ab_num}"
								<c:if test="${assign.ab_status == 3}">disabled</c:if>>
								<img
									src="${pageContext.request.contextPath}/images/kbm/heartwhite.png"
									width="16"><span> 찜 </span><span class="output-fcount"></span>
							</button>
							<button class="ass-chatBtn" data-abnum="${assign.ab_num}"
								data-abmemnum="${assign.mem_num}"
								data-usernum="${user.mem_num }"
								<c:if test="${assign.ab_status == 3}">disabled style="background:#c7c7c7;"</c:if>>
								<img
									src="${pageContext.request.contextPath}/images/kbm/heartwhite.png"
									width="16"><span>채팅</span>
							</button>
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
		
	<%-- 	<div>
			<div class="flexbox-h side">
			<span class="ml10">댓글(0)</span>
			
			</div>
			
		</div>	 --%>
		<hr size="1" width="100%">
			<%-- 
			<!-- 댓글 목록 출력 -->
			 
			<div id="output"></div>
			<div id="loading" style="display:none;">
				<img src="${pageContext.request.contextPath}/images/kbm/heart01.png" width="30" height="30">
			</div>
			<div class="paging-button" style="display:none;">
				<input type="button" value="더보기">
			</div>
			<!-- 댓글 출력 끝 -->
		
		
			<!-- 댓글 작성 UI 시작 -->
			<div id="comment_div">
				<div class="flexbox-h">
					<c:if test="${!empty user}"><img src="${pageContext.request.contextPath}/myPage/viewProfile?mem_num=${user.mem_num}" width="40" height="40" class="my-photo"></c:if>
					<c:if test="${empty user}"><img src="${pageContext.request.contextPath}/images/profile_none.png" width="40" height="40" class="my-photo"></c:if>

					<div id="reply_div">
			            <form id="ass-comment_form">
			               <input type="hidden" name="ab_num" id="ab_num" value="${assign.ab_num}">
			               <div class="flexbox-h">
			               <textarea rows="4" cols="115" name="ac_content" id="ac_content" class="rep-content"
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
		 --%>

		<div class="align-center">
			<input type="button" class="default-btn2 mt70" value="목록" onclick="location.href='list'">
		</div>
		
	</div>
</div>