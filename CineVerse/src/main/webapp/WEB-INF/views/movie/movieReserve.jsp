<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 지점 클릭 이벤트 핸들러
    $('.theater-place > a').click(function(e) {
        e.preventDefault(); // 기본 동작 중지
        let c_num = $(this).data('cnum'); // 클릭한 지점의 c_num 값 가져오기

        // 영화 목록 불러오기
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/getMoviesByCinema',
            data: { c_num: c_num },
            dataType: 'json',
            success: function(data) {
                // 성공적으로 데이터를 받았을 때 처리
                var movieListHtml = '';
                $.each(data, function(index, movie) {
                    movieListHtml += '<li class="select"><a href="#" class="movie-item" data-cnum="' + c_num + '" data-mcode="' + movie.m_code + '">' + movie.m_name + '</a></li>';
                });
                $('.movie-list ul').html(movieListHtml); // 영화 목록 업데이트
            },
            error: function() {
                alert('영화 목록을 불러오는 데 실패했습니다.');
            }
        });
    });

    // 영화 클릭 이벤트 핸들러 설정
    $(document).on('click', '.movie-item', function(e) {
        e.preventDefault(); // 기본 동작 중지

        let c_num = $(this).attr('data-cnum');
        let m_code = $(this).attr('data-mcode'); // 클릭한 영화의 m_code 값 가져오기

        // 영화 시간표 목록 불러오기
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/selectMovieTimeList',
            data: { c_num: c_num, m_code: m_code },
            dataType: 'json',
            success: function(data) {
                // 성공적으로 데이터를 받았을 때 처리
                let selectMovieTimeListHtml = '';
                $.each(data, function(index, movietime) {
                	selectMovieTimeListHtml += '<li class="movietime-item" data-end-time="' + movietime.mt_end + '">';
                    selectMovieTimeListHtml += '<div class="mt-start">' + movietime.mt_start + '</div>';
                    selectMovieTimeListHtml += '<div class="mt-date">' + movietime.mt_date + '</div>';
                    selectMovieTimeListHtml += '<div class="th-name">' + movietime.th_name + '</div>';
                    selectMovieTimeListHtml += '</li>';
                });
                $('.movietime-select').html(selectMovieTimeListHtml); // 영화 시간표 목록 업데이트
            },
            error: function() {
                alert('영화 시간표 목록을 불러오는 데 실패했습니다.');
            }
        });
    });

    // 툴팁 생성
    $(document).on('mouseenter', '.movietime-item', function() {
        var endTime = $(this).data('end-time');
        var tooltip = '<div class="tooltip">종료: ' + endTime + '</div>';
        $('body').append(tooltip);
        var tooltipElement = $('.tooltip');
        tooltipElement.css({
            top: event.pageY + 10,
            left: event.pageX + 10
        });
    });

    $(document).on('mousemove', '.movietime-item', function(event) {
        var tooltipElement = $('.tooltip');
        tooltipElement.css({
            top: event.pageY + 10,
            left: event.pageX + 10
        });
    });

    $(document).on('mouseleave', '.movietime-item', function() {
        $('.tooltip').remove();
    });
});
</script>
<div class="reserve-container">
	<!-- 지점명 -->
	<div class="theater-part">
		<div class="reserve-title">지점명</div>
		<div class="theater-container">
			<div class="theater-wrapper">
				<ul class="theater-location-wrapper">
					<li class="theater-location" id="seoul-location">
					<a href="movieReserve?c_location=1" class="button">서울</a>
					<a href="movieReserve?c_location=2" class="button">경기</a>
					<a href="movieReserve?c_location=3" class="button">인천</a> 
					<a href="movieReserve?c_location=4" class="button">강원</a>
					<a href="movieReserve?c_location=5" class="button">대전/충청</a>
					<a href="movieReserve?c_location=6" class="button">경상</a>
					<a href="movieReserve?c_location=7" class="button">광주/전라</a>
					</li>
					</ul>
						<div class="location" id="seoul" style="display: none;">
						<c:forEach var="cinema" items="${list}">
							<ul class="theater-place-wrapper">
								<li class="theater-place"> <a href="#" class="button theater-branch" data-cnum="${cinema.c_num}">
                                    ${cinema.c_branch}
                                </a>
                            </li>
                        </ul>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
	<script>
	$(document).ready(function(){
	    // 화면 첫 진입할 때 서울 지점명?들 호출하기
	    $('#seoul-location').addClass('theater-location-active');
	    $('#seoul').show();
	    
	    // 지점들 클릭할 때마다 class 추가해서 새로운 css 적용해주기
	    $('.theater-location > a').click(function(){
	        $('.location').hide();
	        $('.theater-location').removeClass('theater-location-active');
	        $(this).next('.location').toggle();
	        $(this).parent().toggleClass('theater-location-active');
	    });
	});

 </script>
 
	<!-- 영화 -->
    <div class="movie-part">
        <div class="reserve-title">영화</div>
        <div class="sort-wrapper">
            <div class="sort-rate sort-selected">예매율순</div>
            <div class="sort-korean">가나다순</div>
        </div>
        <div class="movie-list-wrapper">
            <div class="movie-list">
                <ul class="movie-select">
                    <!-- Ajax로 받아온 영화 목록이 여기에 추가됩니다. -->
                </ul>
            </div>
        </div>
    </div>

	
	<!-- 날짜 및 시간 -->
	<div class="time-part">
		<div class="reserve-title">날짜 및 시간</div>
		<div class="reserve-time">
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
			<div class="reserve-time-wrapper">
				<div class="movitime-list">
                <ul class="movietime-select">
                    <!-- Ajax로 받아온 영화 목록이 여기에 추가됩니다. -->
                </ul>
            </div>
			</div>
		</div>

		<div class="seat-select-button">
			<input type="button" class="moveSeatButton" value="좌석 선택" onclick="location.href='movieSeat'">
		</div>
	</div>

</div>