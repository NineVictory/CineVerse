<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 영화상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/movie.review.js"></script>
<script src="${pageContext.request.contextPath}/js/movie.bookmark.js"></script>

<div class="movie_details_all">
<div class="detail-main">
    <div class="movie-container">
        <div class="movie-photo">
            <img src="${fn:split(movie.m_filename, '|')[0]}" alt="Movie Photo">
        </div>
        <div class="movie-details">
            <div class="movie-title-screening">
                <div class="movie-title">${movie.m_name}</div>
                <div class="movie-screening">
                    <c:choose>
                        <c:when test="${movie.m_status == 1}">
                            현재 상영
                        </c:when>
                        <c:when test="${movie.m_status == 2}">
                            현재 미상영
                        </c:when>
                    </c:choose>
                </div>
            </div>
            
             <!-- 영화정보 -->
            <div class="movie-info">
            	<div class="movie_opendate"><span>${movie.m_opendate}</span> 개봉 </div>
            	<div class="movie_runtime"><span class="icon_clock_black"></span><span>${movie.runtime}</span> 분 </div>
            	<div class="movie_rating">
            	<span class="ic_grade <c:choose><c:when test="${movie.rating eq '12세관람가' }">gr_12</c:when>
                    <c:when test="${movie.rating eq '12세이상관람가' }">gr_12</c:when>
                    <c:when test="${movie.rating eq '전체관람가' }">gr_all</c:when>
                    <c:when test="${movie.rating eq '15세관람가' }">gr_15</c:when>
                    <c:when test="${movie.rating eq '15세이상관람가' }">gr_15</c:when>
                    <c:when test="${movie.rating eq '18세관람가(청소년관람불가)' }">gr_19</c:when>
                    <c:when test="${movie.rating eq '청소년관람불가' }">gr_19</c:when></c:choose>">
                </span>${movie.rating}</div>
            </div>
            <div>
            	<ul class="movie-info-list">
                	<c:if test="${empty movie.m_genre}">
                	<li><b>장르 : </b> 없음</li>
                	</c:if>
                	<c:if test="${!empty movie.m_genre}">
                	<li><b>장르 : </b> ${movie.m_genre}</li>
                	</c:if>
                    <li><b>감독 : </b> ${movie.m_director}</li>
                    <li><b>배우 : </b> ${movie.m_actor}</li>
             	</ul>
            </div>
            
            <div class="movie-infolist">
                <!-- 좋아요 -->
                <div class="movie-fav-button-detail">
                    <img class="output_bookMark" data-num="${movie.m_code}" src="${pageContext.request.contextPath}/images/heart01.png">
                    <span class="output_mfcount"></span>
                </div>
                <div class="movie-reservation" onclick="location.href='/movie/movieReserve'">
               	 	예매하기
            	</div>
            </div>
        </div>
    </div>

    <!-- 상세정보와 별점 및 후기 -->
<!-- 상세정보와 별점 및 후기 -->
<div class="detail-menu">
    <a href="#movie-plot-section" class="detail-infomation" id="info-link">주요정보</a>
    <a href="#movie-teasers-section" class="detail-grade" id="teasers-link">트레일러</a>
    <a href="#movie-still-section" class="detail-still" id="still-link">스틸컷</a>
    <a href="#movie-review-section" class="detail-review" id="review-link">평점/리뷰</a>
</div>

	<div id="movie-plot-section" class="menu-title">주요정보</div>
	<div class="movie-plot">
	${movie.plot}
	</div>
    <!-- 영화 예고편 -->
    <div class="menu-title">트레일러</div>
    <div id="movie-teasers-section" class="movie-content">
 	<c:set var="teasers" value="${fn:split(movie.m_content, ',')}" />
	<c:forEach var="teaser" items="${teasers}">
    	<iframe src="${teaser}" class="movie-teasers" width="910" height="580" frameborder="0"></iframe>
	</c:forEach>
   </div>
   
    <!-- 영화 스틸컷 -->
    <div id="movie-still-section" class="menu-title">스틸컷</div>
    	<div class="movie-still">
 			<c:set var="stills" value="${fn:split(movie.still, '|')}" />
				<c:forEach var="still" items="${stills}">
					<img src="${still}" alt="Movie Photo">
			</c:forEach>
   	</div>

<!-- 별점 및 후기 -->             
<div class="menu-title">평점/리뷰</div>
		<div id="movie-review-section" class="grade-review">
		<div id="review_form" style="display: none;">
			<div class="star-rating">
				<span class="star" data-value="1"><img
					src="${pageContext.request.contextPath}/images/cje/star_no.png"></span>
				<span class="star" data-value="2"><img
					src="${pageContext.request.contextPath}/images/cje/star_no.png"></span>
				<span class="star" data-value="3"><img
					src="${pageContext.request.contextPath}/images/cje/star_no.png"></span>
				<span class="star" data-value="4"><img
					src="${pageContext.request.contextPath}/images/cje/star_no.png"></span>
				<span class="star" data-value="5"><img
					src="${pageContext.request.contextPath}/images/cje/star_no.png"></span>
			</div>
			<div class="review-choice">별점을 선택해주세요</div>
			<div id="review_div">
				<!-- 댓글 작성 폼 -->
				<form id="mr_form">
					<input type="hidden" name="mem_num" value="${user.mem_num}" id="mem_num">
					<input type="hidden" name="m_code" value="${movie.m_code}"
						id="m_code"> <input type="hidden" name="mb_num"
						value="${booking != null ? booking.mb_num : 0}" id="mb_num">
					<input type="hidden" name="mr_grade" id="mr_grade">
					<!-- 별점 값 저장 -->
					<c:if test="${!empty booking}">
						<p>예매 번호: ${booking.mb_num}</p>
					</c:if>
					<c:choose>
						<c:when test="${empty user}">
							<textarea rows="3" cols="50" name="mr_content"
								class="review-content" disabled>로그인해야 작성할 수 있습니다.</textarea>
						</c:when>
						<c:when test="${!empty user}">
							<c:choose>
								<c:when test="${!canWriteReview}">
									<textarea rows="3" cols="50" name="mr_content" id="mr_content"
										class="review-content" disabled>영화를 예매한 경우에만 댓글을 작성할 수 있습니다.</textarea>
								</c:when>
								<c:otherwise>
									<div>
										<label for="mr_spoiler">스포일러 포함</label> <input type="checkbox"
											name="mr_spoiler" value="1" id="mr_spoiler">
									</div>
									<textarea rows="3" cols="50" name="mr_content" id="mr_content"
										class="review-content"></textarea>
									<div id="review_first">
										<span class="letter-count">300/300</span>

										<div id="review_second">
											<div class="review-button">
												<input type="submit" value="등록" class="review_submit">
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
				</form>
			</div>
		</div>
			<!-- 댓글수 -->
			<div class="review_all_contents">
				<p>
					<span id="output_mrcount"></span> 명의 실관람객이 평가해주셨습니다.
				</p>
				<div class="my_review_btns">
				<div class="insert_my_review">
					<button class="my_review_all" onclick="showReviewForm()">평점 등록하기</button>
				</div>
				<div class="my_review">
					<button class="my_review_all" onclick="location.href='${pageContext.request.contextPath}/myPage/review'">내 평점</button>
				</div>
				</div>
			</div>

			<!-- 최신순, 추천순 선택 텍스트 -->
			<div class="review-sort">
				<span id="latest" class="sort-option active">최신순</span> | <span
					id="recommendation" class="sort-option">추천순</span>
			</div>
		</div>

		<script>
			function showReviewForm() {
				document.getElementById("review_form").style.display = "block";
			}
		</script>

		<!-- 댓글 목록 출력 -->
		<div id="output"></div>
		<div id="loading" style="display:none;">
		    <img src="<c:url value='/images/loading.gif' />" width="30" height="30">
		</div>
		<div class="paging-button" style="display:none;">
		    <input type="button" value="더보기">
		</div>
		</div> 
		</div>
		
		<!-- 상단 이동 버튼 -->
		<div id="scroll-to-top" style="display: none;">
		    <img src="${pageContext.request.contextPath}/images/up-arrow.png" alt="Scroll to Top">
		</div>
		
		<script type="text/javascript">
		$(document).ready(function() {
		    $(window).on('scroll', function() {
		        var scrollPosition = $(document).scrollTop();
		        if (scrollPosition > 200) { // 페이지가 200px 이상 스크롤되면 버튼을 표시
		            $('#scroll-to-top').fadeIn();
		        } else { // 페이지가 200px 이하로 스크롤되면 버튼을 숨김
		            $('#scroll-to-top').fadeOut();
		        }
		
		        $('.detail-menu a').removeClass('active');
		        $('.movie-plot, .movie-content, .grade-review, .movie-still').each(function() {
		            var sectionOffset = $(this).offset().top;
		            var sectionHeight = $(this).outerHeight();
		            var sectionId = $(this).attr('id');
		
		            if (scrollPosition >= sectionOffset && scrollPosition < sectionOffset + sectionHeight) {
		                $('.detail-menu a[href="#' + sectionId + '"]').addClass('active');
		            }
		        });
		    });
		
		    $('.detail-menu a').on('click', function(e) {
		        e.preventDefault();
		        var target = $(this).attr('href');
		        $('html, body').animate({
		            scrollTop: $(target).offset().top
		        }, 200);
		    });
		
		    $('#scroll-to-top').on('click', function() {
		        $('html, body').animate({
		            scrollTop: 0
		        }, 500);
		    });
		});
		
		
		</script>
