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

<div class="detail-main">
    <div class="movie-container">
        <div class="movie-photo">
            <img src="<c:url value='/upload/${movie.m_filename}' />" alt="Movie Photo">
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
            <div class="movie-infolist">
                <span>예매율</span>
                <span>23.3%</span>
                <span>좋아요 수 </span>
                <!-- 좋아요 -->
                <div class="movie-fav-button-detail">
                    <img class="output_bookMark" data-num="${movie.m_code}" src="${pageContext.request.contextPath}/images/heart01.png">
                    <span class="output_mfcount"></span>
                </div>
            </div>
            <hr class="menu-hr" size="1" width="100%" noshade="noshade">
            
            <!-- 영화정보 -->
            <div class="movie-info">
                <ul>
                	<c:if test="${empty movie.m_genre}">
                	<li><b>장르 : </b> 없음</li>
                	</c:if>
                	<c:if test="${!empty movie.m_genre}">
                	<li><b>장르 : </b> ${movie.m_genre}</li>
                	</c:if>
                    <li><b>감독 : </b> ${movie.director}</li>
                    <li><b>영화배우/출연 : </b> ${movie.actor}</li>
                    <li><b>개봉 :</b>${movie.m_opendate}</li>
                </ul>
            </div>
        
            <div class="movie-reservation" onclick="location.href='/movie/movieReserve'">
                <div class="movie-reservation-button">예매하기</div>
            </div>
        </div>
    </div>

    <!-- 상세정보와 별점 및 후기 -->
    <div class="detail-menu">
        <span class="detail-infomation">주요정보</span>
        <span class="detail-grade">트레일러</span>
        <span class="detail-review">평점/리뷰</span>
        <hr class="menu-hr" size="1" width="100%" noshade="noshade">
    </div>
	<div class="menu-title">주요정보</div>
	<div class="movie-plot">
	${movie.plot}
	</div>
    <!-- 영화 예고편 -->
    <div class="menu-title">트레일러</div>
 <!--    <div class="movie-teaser">
        <iframe width="560" height="315" src="https://www.youtube.com/embed/EiCmnIaj4u8?si=x1eQENSmEMIMFaxh" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
    </div> -->
    <div class="movie-content">
  <%--                   <c:if test="${not empty movie.m_content}">
                    <c:forEach var="url" items="${fn:split(movie.m_content, ',')}">
                        <iframe src="${url.trim()}" width="1000" height="800"></iframe>
                    </c:forEach>
                </c:if>
     --%>
      <%-- <c:when test="${not empty movie.m_content}">
                <script>
                    $(document).ready(function() {
                        var videoUrls = JSON.parse('${movie.m_content}');
                        videoUrls.forEach(function(url) {
                            $('.movie-content').append('<iframe src="' + url + '" width="1000" height="800"></iframe>');
                        });
                    });
                </script>
            </c:when>
            <c:otherwise>
                <p>영화 소개 영상이 없습니다.</p>
            </c:otherwise>--%>
 <%--        <iframe src="${movie.m_content}" class="movie-tearsers" width="910" height="580" ></iframe> --%>
    <c:if test="${not empty videoUrls}">
        <c:forEach var="videoUrl" items="${videoUrls}">
            <iframe src="${videoUrl}" class="movie-teasers" width="910" height="580"></iframe>
        </c:forEach>
    </c:if>
   <!--      <iframe src="https://www.kmdb.or.kr/trailer/trailerPlayPop?pFileNm=MK059016_P02.mp4" width="1000" height="800"></iframe>  -->
    </div>

<!-- 별점 및 후기 -->             
<div class="menu-title">평점/리뷰</div>
<div class="grade-review">
    <div class="star-rating">
    <span class="star" data-value="1"><img src="${pageContext.request.contextPath}/images/ksh/star.png"></span>
    <span class="star" data-value="2"><img src="${pageContext.request.contextPath}/images/ksh/star.png"></span>
    <span class="star" data-value="3"><img src="${pageContext.request.contextPath}/images/ksh/star.png"></span>
    <span class="star" data-value="4"><img src="${pageContext.request.contextPath}/images/ksh/star.png"></span>
    <span class="star" data-value="5"><img src="${pageContext.request.contextPath}/images/ksh/star.png"></span>
</div>									
    <div class="review-choice">별점을 선택해주세요</div>
    <div id="review_div">
        <!-- 댓글 작성 폼 -->
        <form id="mr_form">
            <input type="hidden" name="m_code" value="${movie.m_code}" id="m_code">
            <input type="hidden" name="mb_num" value="${booking != null ? booking.mb_num : 0}" id="mb_num">
            <input type="hidden" name="mr_grade" id="mr_grade"> <!-- 별점 값 저장 -->
            <c:if test="${!empty booking}">
                <p>예매 번호: ${booking.mb_num}</p>
            </c:if>
            <c:choose>
                <c:when test="${empty user}">
                    <textarea rows="3" cols="50" name="mr_content" class="review-content" disabled>로그인해야 작성할 수 있습니다.</textarea>
                </c:when>
                <c:when test="${!empty user}">
                    <c:choose>
                        <c:when test="${!canWriteReview}">
                            <textarea rows="3" cols="50" name="mr_content" id="mr_content" class="review-content" disabled>영화를 예매한 경우에만 댓글을 작성할 수 있습니다.</textarea>
                        </c:when>
                        <c:otherwise>
                            <textarea rows="3" cols="50" name="mr_content" id="mr_content" class="review-content"></textarea>
                            <label for="mr_spoiler">스포일러 포함</label>
                            <input type="checkbox" name="mr_spoiler" value="1" id="mr_spoiler">
                            <div id="review_first">
                                <span class="letter-count">300/300</span>
                            </div>
                            <div id="review_second" style="text-align: right;">
                                <div class="review-button"><input type="submit" value="등록"></div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
            </c:choose>
        </form>
    </div>
    <!-- 최신순, 추천순 선택 텍스트 -->
    <div class="review-sort">
        <span id="latest" class="sort-option active">최신순</span> | 
        <span id="recommendation" class="sort-option">추천순</span>
    </div>
</div>


<!-- 댓글수 -->
		<span id="output_mrcount"></span>
<!-- 댓글 목록 출력 -->
<div id="output"></div>
<div id="loading" style="display:none;">
    <img src="<c:url value='/images/loading.gif' />" width="30" height="30">
</div>
<div class="paging-button" style="display:none;">
    <input type="button" value="더보기">
</div>
<!-- <button id="loadComments">리뷰보기</button>
<div id="output"></div>
-->
</div> 
