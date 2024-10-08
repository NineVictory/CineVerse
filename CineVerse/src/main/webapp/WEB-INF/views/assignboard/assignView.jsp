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
<script src="${pageContext.request.contextPath}/js/assignboard.changeStatus.js"></script>

<script src="${pageContext.request.contextPath}/js/assignboard.report.js"></script>

<div class="page-container page-main">
	<div class="boardview-main">
		<c:if test="${assign.mem_num == user.mem_num}">
		<div class="assboard-btn flexbox-h side">
				<span class="list-btn-container" onclick="location.href='list'" >
					<img src="${pageContext.request.contextPath}/images/kbm/arrow_back.png" width="25px;" height="22px;">
					<input type="button" value="목록" class="list-btn">
				</span>
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
	        	$(document).click(function(event) {
	                if (!$(event.target).closest('.assboard-cbtn').length) {
	                    $('.btn-hide').hide();
	                }
	            });
	        	</script>
		</div>
		</c:if>

	
		<hr size="1" width="100%">
	
		<div class="assign-info-container 상품정보">
		
			<div class="flexbox-h side">
				<div class="marg440 image-container">
				
				<%--<c:if test="${not empty filenames}">
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
				
				<c:if test="${!empty filenames}">
				<img src="${pageContext.request.contextPath}/upload/${filenames[0]}" width="420" class="item-img">
				</c:if>--%>
				
				<img src="${pageContext.request.contextPath}/upload/${assign.ab_filename}" width="420" height="420" class="item-img">
				<c:if test="${assign.ab_status == 3}">
					<div class="overlay-text">판매완료</div>
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
						<h2>${assign.ab_title}</h2>
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
								
								<c:if test="${assign.mem_num == user.mem_num}">
								<select id="ab_status" data-num="${assign.ab_num}">
									<option value="1" <c:if test="${assign.ab_status == 1}">selected</c:if>>판매중</option>
									<option value="2" <c:if test="${assign.ab_status == 2}">selected</c:if>>예약중</option>
									<option value="3" <c:if test="${assign.ab_status == 3}">selected</c:if>>거래완료</option>
								</select>
																
								</c:if>
								
								<c:if test="${assign.mem_num != user.mem_num}">
								<span class="ab-status" data-num="${assign.ab_num}">
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
								</c:if>	
								
								</div>
							</div>
							<div class="assign-report p-center">
								<img src="${pageContext.request.contextPath}/images/kbm/report.png" width="15" height="15">
								<span style="margin-left:2px;" id="board_report_con">
									<a id="board_report" data-num="${assign.ab_num}" data-memnum="${user.mem_num}" 
											<c:choose>
							                    <c:when test="${fn:length(assign.ab_title) > 20}">
							                        data-title="${fn:substring(assign.ab_title, 0, 20)}..."
							                    </c:when>
							                    <c:otherwise>
							                        data-title="${assign.ab_title}"
							                    </c:otherwise>
							                </c:choose>
												data-title="${assign.ab_title}"
												<c:if test="${!empty assign.mem_nickname}">
													data-writer="${assign.mem_nickname}"
												</c:if>
												<c:if test="${empty assign.mem_nickname}">
													data-writer="${assign.mem_id}"
												</c:if>>신고하기</a>
								</span>
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
								<div style="display:flex; align-items: baseline; "><img
									src="${pageContext.request.contextPath}/images/kbm/heartwhite.png"
									width="16">&nbsp;<span>찜 </span><span class="output-fcount"></span></div>
							</button>
							<button class="ass-chatBtn" data-abnum="${assign.ab_num}"
								data-abmemnum="${assign.mem_num}"
								data-usernum="${user.mem_num }"
								<c:if test="${assign.ab_status == 3}">disabled style="background:#c7c7c7;"</c:if>>
								<img
									src="${pageContext.request.contextPath}/images/kbm/paper.png"
									width="18">&nbsp;<span>채팅</span>
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
		
		<hr size="1" width="100%">
			
		<div class="align-center">
			<input type="button" class="default-btn4 mt70" value="목록" onclick="location.href='list'">
		</div>
		
	</div>
</div>


<%-- 신고 --%>
<%-- <div class="report-modal" id="reportModal">
	<div class="report-modal-content">
		<span class="modal-close" id="modalClose">&times;</span>
			<h2>신고하기</h2>
			<form:form id="reportForm">
				<div class="rform-group">
				<form:label path="reportReason">신고 사유</form:label>
				<form:radiobutton path="ar-category" value="1" checked="checked"/>스팸홍보/도배<br>
				<form:radiobutton path="ar-category" value="2" />음란물
				<form:radiobutton path="ar-category" value="3" />불법정보
				<form:radiobutton path="ar-category" value="4" />청소년에게 유해한 내용
				<form:radiobutton path="ar-category" value="5" />욕설/생명경시/혐오/차별적 표현
				<form:radiobutton path="ar-category" value="6" />개인정보 노출
				<form:radiobutton path="ar-category" value="7" />불쾌한 표현
				<form:radiobutton path="ar-category" value="8" />기타
				</div>
	            <div class="form-group">
	                <form:label path="ar-content">신고 내용</form:label>
	                <form:textarea path="ar-content" rows="3" required="true"></form:textarea>
	            </div>
            <button type="submit" class="btn">신고하기</button>
        </form:form>
    </div>
</div>
 --%>
  
