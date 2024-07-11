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
        
        <div class="location-button"> 
        	<c:forEach var="cinema" items="${list}">
        		<div class="content-place-title">${cinema.c_branch}</div>
        	</c:forEach>
              <div class="location-button-list" id="modal_open_btn">위치/지도보기</div>
             </div>
             <div id="modal">
    			<div class="modal_content">
    			<button type="button" class="close_btn" id="modal_close_btn">×</button>
        			<div class="modal_title">지도</div>
        			
        			<hr class="custom-hr">
       					 <!-- 지도 -->        		
       					<!-- 지도를 표시할 div 입니다 -->
						<div id="modal_map" style="width: 100%; height: 700px;"></div>
						<div class="map_wrap">
						<!--     <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div> -->

				    <div id="map" class="bg_white">
				        <div class="option">
				            <div>
				                <form onsubmit="searchPlaces(); return false;">
				                    키워드 : <input type="text" value="영화관" id="keyword" size="15"> 
				                    <button type="submit">검색하기</button> 
				                </form>
				            </div>
				        </div>
				        <hr>
				        <ul id="placesList"></ul>
				        <div id="pagination"></div>
				    </div>
</div>
<!-- 지도 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23eb84e1f8e8eadb7771addf44c8a193"></script>
<!-- <script type="text/javascript">
	document.getElementById("modal_open_btn").onclick = function() {
		document.getElementById("modal").style.display="block";

		var container = document.getElementById('modal_map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	}
   
	document.getElementById("modal_close_btn").onclick = function() {
		document.getElementById("modal").style.display="none";
	}
</script> -->
<script type="text/javascript">
    // 모달 열기 버튼 클릭 시
    document.getElementById("modal_open_btn").onclick = function() {
        document.getElementById("modal").style.display = "block";

        var container = document.getElementById('modal_map'); // 지도를 담을 영역의 DOM 레퍼런스
        var options = { // 지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 레벨(확대, 축소 정도)
        };

        var map = new kakao.maps.Map(container, options); // 지도 생성 및 객체 리턴
		
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }
        });
    }

    // 모달 닫기 버튼 클릭 시
    document.getElementById("modal_close_btn").onclick = function() {
        document.getElementById("modal").style.display = "none";
        // 지도를 초기화할 수 있다면 추가 코드 필요
    }
</script>
<!-- 지도 끝 -->
    			</div>
   
    			<div class="modal_layer"></div>
			</div>
		<c:forEach var="cinema" items="${list}">
        <div class="content-place-location">주소 : <b>${cinema.c_address}</b></div>
        <div class="content-place-tell">문의전화 : <b>${cinema.c_phone}</b></div>
        <div class="content-place-cinema">상영관수 : <b>${cinema.c_theater}관,${cinema.c_seat}석</b></div>
        <div class="content-place-parking">주차정보 : <b>${cinema.c_parkable}</b></div>
        </c:forEach>
        <input type="button" value="삭제" onclick="location.href='cinemaDelete'">
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
    
</div>
<!-- 자체영화관 끝 -->
