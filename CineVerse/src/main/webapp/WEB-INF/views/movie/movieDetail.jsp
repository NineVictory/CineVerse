<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 영화상세 시작 -->

<div class="detail-main">
	<div class="movie-container">
    <div class="movie-photo">
        <img src="${pageContext.request.contextPath}/images/ksh/movie.jpg" alt="Movie Photo">
    </div>
    <div class="movie-details">
     <div class="movie-title-screening">
        <div class="movie-title">인사이드 아웃2</div> 
        <div class="movie-screening">현재상영</div>
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
				<li><b>장르 : </b> 애니매이션/미국</li>
				<li><b>감독 : </b> 켈시만</li>
				<li><b>영화배우/출연 : </b> 에이미 포엘러, 마야 호크, 루이스 블랙, 필리스 스미스, 토니 헤일</li>
				<li><b>개봉 :</b>2024.06.12</li>
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
           디즈니·픽사의 대표작 <인사이드 아웃>
			새로운 감정과 함께 돌아오다!<br>
			13살이 된 라일리의 행복을 위해 매일 바쁘게 머릿속 감정 컨트롤 본부를 운영하는 ‘기쁨’, ‘슬픔’, ‘버럭’, ‘까칠’, ‘소심’.<br>
			그러던 어느 날,<br>
			낯선 감정인 ‘불안’, ‘당황’, ‘따분’, ‘부럽’이가 본부에 등장하고,<br>
			언제나 최악의 상황을 대비하며 제멋대로인 ‘불안’이와 기존 감정들은 계속 충돌한다.<br>
			결국 새로운 감정들에 의해 본부에서 쫓겨나게 된 기존 감정들은<br>
			다시 본부로 돌아가기 위해 위험천만한 모험을 시작하는데…<br>
			2024년, 전 세계를 공감으로 물들인 유쾌한 상상이 다시 시작된다!<br>
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
		<form>
			<textarea rows="3" cols="50"class="review-content" placeholder="*작성 글이 다른 고객에게 일정 기준 이상 신고 될 경우 자동 숨김 처리되며 고객센터로 이의 제기 가능합니다.*"></textarea>
			<div id="review_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="review_second" class="review-align-right">
				<input type="submit" value="등록">
			</div>
		</form>
	</div>
</div>
<div class="review-menu">
<span>추천순</span>
<span>|</span>
<span>최신순</span>
</div>
</div>
<!-- 영화상세 끝 -->