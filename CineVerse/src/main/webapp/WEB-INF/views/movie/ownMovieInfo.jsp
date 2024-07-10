<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 자체영화관 시작 -->
<div class="ownMovie-main">
    <!-- 영화관 선택 시작 -->
    
    
    <!-- 영화관 선택 끝 -->
    <!-- 영화관 정보 시작-->
    <div class="movie-content-place">
        
        <div class="location-button" onclick="location.href='/movie/'"> 
        		<div class="content-place-title">CINEVERSE 강남</div>
              <div class="location-button-list">위치/지도보기</div>
             </div>
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
        //cinema-gallery 클래스를 가진 div 요소를 gallery에 저장
        function generateMovieDays() {
        	//querySelector는 주어진 CSS 선택자를 사용하여 첫 번째로 일치하는 요소를 선택하여 반환하는데 여기선 .cinema-gallery 클래스가 있는 첫번째 요소로를 선택했다. 그외에 <div>,id 등등 다양하게 선택 가능하다.
            var gallery = document.querySelector('.cinema-gallery'); 
            gallery.innerHTML = ''; // 기존 내용을 비웁니다.

            for (var i = 0; i < 12; i++) {
            							//createElement는 document 객체의 메서드로 지정한 HTML 요소를 생성 시키는 역할이다. 여기선 div 요소를 생성시킴
                var dayElement = document.createElement('div');//각 루프마다 dayElement라는 div 요소를 생성
                		//Date객체함수들:  getFullYear:현재Date를 4자리 숫자로 반환	| getMonth:월을 0~11까지의 숫자로 반환 	| getDate: 1~31까지 숫자로 반환
                var displayDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + i); //현재날짜에 i일을 더함
                var day = displayDate.getDate(); //displayDate 에 '일' 부분을 저장 
                var dayOfWeek = daysOfWeek[displayDate.getDay()]; // getDay() 는 요일을 가져오는 Date 객체의 함수 : 숫자 0~6사이를 반환

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
				//gallery 요소에 dayElement를 자식 요소로 추가
                gallery.appendChild(dayElement);
            }
        }

        // 영화 날짜 생성 함수 호출
        generateMovieDays();
    </script>
    <!-- 날짜 끝 -->
    <!-- 연령고지 시작 -->
    <div class="watch-age">
    <div class="movie-all">
    <img class="watch-all" src="${pageContext.request.contextPath}/images/ksh/watch-all.png">
    전체사용자
    </div>
    <div class="movie-12">
    <img class="watch-12" src="${pageContext.request.contextPath}/images/ksh/watch-12.png">
    만 12세 이상 관람가
    </div>
    <div class="movie-15">
    <img class="watch-15" src="${pageContext.request.contextPath}/images/ksh/watch-15.png">
    만 15세 이상 관람가
    </div>
    <div class="movie-19">
    <img class="watch-19" src="${pageContext.request.contextPath}/images/ksh/watch-19.png">
    청소년 관람불가
    </div>
    </div>
    <!-- 연령고지 끝 -->
    <!-- 영화관 별 영화 목록 시작-->
    <div class="cinema-movie">
	    <div class="cinema-movie-title">
		    <img class="watch-all-2" src="${pageContext.request.contextPath}/images/ksh/watch-all.png">
		    <div>인사이드 아웃</div>
	    </div>
	    <div class="screening-room">
	    	<div class="cinema-hall">
	    		1관 <br> 총 120석
	    	</div>
	    	<div class="timeorseat">
	    			18:00<br>155/232
	    	</div>
	    	<div class="timeorseat">
	    			21:00<br>180/232
	    	</div>
	    	<div class="timeorseat">
	    			00:00<br>211/232
	    	</div>
	    
	    </div>
	    <hr class="custom-hr">
	    <div class="screening-room">
	    	<div class="cinema-hall">
	    		2관 <br> 총 102석
	    	</div>
	    	<div class="timeorseat">
	    			17:00<br>155/232
	    	</div>
	    	<div class="timeorseat">
	    			20:00<br>180/232
	    	</div>
	    	<div class="timeorseat">
	    			23:00<br>211/232
	    	</div>
	    	
	    </div>
    </div>
    <hr class="custom-hr">
    <!--  -->
    <div class="cinema-movie">
	    <div class="cinema-movie-title">
		    <img class="watch-12-2" src="${pageContext.request.contextPath}/images/ksh/watch-12.png">
		    <div>탈주</div>
	    </div>
	    <div class="screening-room">
	    	<div class="cinema-hall">
	    		1관 <br> 총 120석
	    	</div>
	    	<div class="timeorseat">
	    			18:00<br>155/232
	    	</div>
	    	<div class="timeorseat">
	    			21:00<br>180/232
	    	</div>
	    	<div class="timeorseat">
	    			00:00<br>211/232
	    	</div>
	    
	    </div>
	    <hr class="custom-hr">
	    <div class="screening-room">
	    	<div class="cinema-hall">
	    		2관 <br> 총 102석
	    	</div>
	    	<div class="timeorseat">
	    			17:00<br>155/232
	    	</div>
	    	<div class="timeorseat">
	    			20:00<br>180/232
	    	</div>
	    	<div class="timeorseat">
	    			23:00<br>211/232
	    	</div>
	    	
	    </div>
    </div>
    <hr class="custom-hr">
    <div class="cinema-movie">
	    <div class="cinema-movie-title">
		    <img class="watch-15-2" src="${pageContext.request.contextPath}/images/ksh/watch-15.png">
		    <div>대충만든영화</div>
	    </div>
	    <div class="screening-room">
	    	<div class="cinema-hall">
	    		1관 <br> 총 120석
	    	</div>
	    	<div class="timeorseat">
	    			18:00<br>155/232
	    	</div>
	    	<div class="timeorseat">
	    			21:00<br>180/232
	    	</div>
	    	<div class="timeorseat">
	    			00:00<br>211/232
	    	</div>
	    
	    </div>
	    <hr class="custom-hr">
	    <div class="screening-room">
	    	<div class="cinema-hall">
	    		2관 <br> 총 102석
	    	</div>
	    	<div class="timeorseat">
	    			17:00<br>155/232
	    	</div>
	    	<div class="timeorseat">
	    			20:00<br>180/232
	    	</div>
	    	<div class="timeorseat">
	    			23:00<br>211/232
	    	</div>
	    	
	    </div>
    </div>
    <hr class="custom-hr">
    <!-- 영화관 별 영화 목록 끝-->
</div>
<!-- 자체영화관 끝 -->
