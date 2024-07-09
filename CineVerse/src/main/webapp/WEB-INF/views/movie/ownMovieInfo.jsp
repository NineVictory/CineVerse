<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 자체영화관 시작 -->
<div class="ownMovie-main">
	<!-- 영화관 선택 시작 -->
    <div class="ownMovie-container">
    <div class="own-movie-title">자체영화관</div>
        <div class="location-img">
            <img class="responsive-image" src="${pageContext.request.contextPath}/images/ksh/movieshow.png" alt="Movie Show" >
        </div>
        <div class="location-text">
        <ul>
        	<li>
            <a href="#">서울</a>
            	<div>
						<ul>
							<li><a href="" class="" title="강남">강남</a></li>
							<li><a href="" class="" title="강북">강북</a></li>
							<li><a href="#" title="동서울">동서울</a></li>
							<li><a href="#" title="서울">잠실</a></li>
							<li><a href="#" title="동대문">동대문</a></li>
							<li><a href="#" title="마곡">마곡</a></li>
							<li><a href="#" title="목동">목동</a></li>
							<li><a href="#" title="신사">신사</a></li>
							<li><a href="#" title="성수">성수</a></li>
							<li><a href="#" title="신촌">신촌</a></li>
							<li><a href="#" title="홍대">홍대</a></li>
						</ul>
				</div>
             </li>
        </ul>
        </div>
    
    </div>
    <!-- 영화관 선택 끝 -->
    <!-- 영화관 정보 시작-->
    <div class="movie-content-place">
    	<div class="content-place-title">CINEVERSE 강남</div>
    	<div class="content-place-location">위치 : <b>서울특별시 강남구 테헤란로 132 (한독약품빌딩)</b></div>
    	<div class="content-place-tell">문의전화 : <b>1544-0000</b></div>
    	<div class="content-place-cinema">상영관수 : <b>6관,874석</b></div>
    	<div class="content-place-parking">주차정보 : <b>주차가능</b></div>
    </div>
    <!-- 영화 정보 끝-->
    <!-- 날짜 시작-->
    <div class="cinema-gallery">
	    <div class="movie-day">9<br>일</div>
	    <div class="movie-day">10<br>일</div>
	    <div class="movie-day">11<br>일</div>
	    <div class="movie-day">12<br>일</div>
	    <div class="movie-day-sat">13<br>일</div>
	    <div class="movie-day-sun">14<br>일</div>
	    <div class="movie-day">15<br>일</div>
	    <div class="movie-day">16<br>일</div>
	    <div class="movie-day">17<br>일</div>
	    <div class="movie-day">18<br>일</div>
	    <div class="movie-day">19<br>일</div>
	    <div class="movie-day">20<br>일</div>
	</div>

<script>
    // 현재 날짜 객체 생성
    var currentDate = new Date();

    // 각 요소의 내부 텍스트를 설정
    document.querySelectorAll('.movie-day').forEach(function(dayElement) {
        var day = parseInt(dayElement.textContent); // 텍스트를 정수형으로 변환
        var displayDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), day);

        // 날짜 포맷 설정
        var formattedDate = displayDate.getDate() + '일'; // 일자 포맷

        // 요일 포맷
        switch (displayDate.getDay()) {
            case 0:
                formattedDate += ' 일'; // 일요일
                break;
            case 1:
                formattedDate += ' 월'; // 월요일
                break;
            case 2:
                formattedDate += ' 화'; // 화요일
                break;
            case 3:
                formattedDate += ' 수'; // 수요일
                break;
            case 4:
                formattedDate += ' 목'; // 목요일
                break;
            case 5:
                formattedDate += ' 금'; // 금요일
                break;
            case 6:
                formattedDate += ' 토'; // 토요일
                break;
        }

        // 요일 포맷을 적용하여 각 요소의 텍스트 변경
        dayElement.innerHTML = formattedDate;
    });
</script>

    <!-- 날짜 끝 -->
</div> 
<!-- 자체영화관 끝 -->
<!-- 영화상세 시작 -->
