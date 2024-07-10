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
    <div class="cinema-gallery"></div>
    <!-- 12일을 자동으로 업데이트 해주는 스크립트 -->
    <script>
        // 현재 날짜 객체 생성
        var currentDate = new Date();

        // 요일 배열 생성
        var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

        // 영화 날짜 생성 함수
        function generateMovieDays() {
            var gallery = document.querySelector('.cinema-gallery');
            gallery.innerHTML = ''; // 기존 내용을 비웁니다.

            for (var i = 0; i < 12; i++) {
                var dayElement = document.createElement('div');
                var displayDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + i);
                var day = displayDate.getDate();
                var dayOfWeek = daysOfWeek[displayDate.getDay()]; // 요일 가져오기

                var formattedDate = day + '<br>' + dayOfWeek; // 날짜와 요일 포맷
                var dayClass = 'movie-day';

                // 요일에 따라 클래스 추가
                switch (displayDate.getDay()) {
                    case 0:
                        dayClass = 'movie-day-sun';
                        break;
                    case 6:
                        dayClass = 'movie-day-sat';
                        break;
                }

                dayElement.className = dayClass;
                dayElement.innerHTML = formattedDate;

                // 클릭 이벤트 추가
                dayElement.addEventListener('click', function() {
                    alert('Clicked date: ' + this.innerHTML);
                    // 여기에 원하는 동작을 추가하세요
                });

                gallery.appendChild(dayElement);
            }
        }

        // 영화 날짜 생성 함수 호출
        generateMovieDays();
    </script>
    <!-- 날짜 끝 -->
</div>
<!-- 자체영화관 끝 -->
