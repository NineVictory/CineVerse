<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 영화상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="detail-main">
	<div class="movie-container">
    <div class="movie-photo">
        <img src="${pageContext.request.contextPath}/upload/${movie.m_filename}" alt="Movie Photo">
    </div>
    <div class="movie-details">
     <div class="movie-title-screening">
        <div class="movie-title">${movie.m_name}</div> 
        <div class="movie-screening">
        <c:choose>
    			<c:when test="${movie.m_status == 1}">
       			 현재 미상영
    			</c:when>
    	<c:when test="${movie.m_status == 2}">
        		현재 상영
    			</c:when>
		</c:choose>
        </div>
     </div>
        <div class="movie-infolist">
            <span>예매율</span>
            <span>23.3%</span>
            <span>좋아요 수 </span>
            <span>5.7K</span>
        </div>
        <hr class="menu-hr" size="1" width="100%" noshade="noshade">
        
        <!-- 영화정보 -->
		<div class="movie-info">
			<ul>
				<li><b>장르 : </b> ${movie.genre}</li>
				<li><b>감독 : </b> ${movie.director}</li>
				<li><b>영화배우/출연 : </b> ${movie.actor}</li>
				<li><b>개봉 :</b>${movie.m_opendate}</li>
			</ul>
		</div>
	
        <div class="movie-reservation" onclick="location.href='/movie/'">
            <div class="movie-reservation-button">예매하기</div>
        </div>
    </div>
    </div>

<!-- 상세정보와 별점 및 후기 -->
<div class="detail-menu">
    <span class="detail-info">주요정보</span>
    <span class="detail-grade">트레일러</span>
    <span class="detail-review">평점/리뷰</span>
    <hr class="menu-hr" size="1" width="50%" noshade="noshade">
</div>
<div class="movie-content">
           ${movie.m_content}
        </div>
<!-- 영화 예고편 -->
<div class="menu-title">트레일러</div>
<div class="movie-teaser">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/EiCmnIaj4u8?si=x1eQENSmEMIMFaxh" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
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
		<form id="mr_form">
		<input type="hidden" name="m_code" value="${movie.m_code}" id="m_code">
			<textarea rows="3" cols="50" name="mr_content" name="mr_content" class="review-content" placeholder="*작성 글이 다른 고객에게 일정 기준 이상 신고 될 경우 자동 숨김 처리되며 고객센터로 이의 제기 가능합니다.*"></textarea>
			<div id="review_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="review_second" style="text-align: right;">
    			<div class="review-button">등록</div>
			</div>

		</form>
	</div>
</div>
<div class="review-menu">
    <span id="recommendation">추천순</span>
    <span>|</span>
    <span id="latest">최신순</span>
</div>
</div>
<script>
</script>
	
<!-- 영화상세 끝 -->
