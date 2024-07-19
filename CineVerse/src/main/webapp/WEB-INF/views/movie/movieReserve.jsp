<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    let selectedCNum = null;
    let selectedMCode = null;
    let selectedDate = null;
    let selectedMtStart = null;

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
                let movieListHtml = '';
                $.each(data, function(index, movie) {
                    movieListHtml += '<li class="select" data-cnum="' + c_num + '" data-mcode="' + movie.m_code + '"><a href="#" class="movie-item" >' + movie.m_name + '</a></li>';
                });
                $('.movie-list ul').html(movieListHtml); // 영화 목록 업데이트
            },
            error: function() {
                alert('영화 목록을 불러오는 데 실패했습니다.');
            }
        });
    });

    // 영화 클릭 이벤트 핸들러 설정
    $(document).on('click', '.select', function(e) {
        e.preventDefault(); // 기본 동작 중지

        selectedCNum = $(this).attr('data-cnum');
        selectedMCode = $(this).attr('data-mcode');
        
        // 모든 영화 항목에서 active 클래스 제거
        $('.select').removeClass('active');
        
        // 클릭한 영화 항목에 active 클래스 추가
        $(this).addClass('active');
        

        loadMovieTimeTable(); // 영화 시간표 목록을 불러오는 함수 호출
    });

    // 날짜 클릭 이벤트 핸들러 설정
    $(document).on('click', '.movie-day, .movie-day-sun, .movie-day-sat', function() {
        selectedDate = $(this).data('date'); // 클릭한 날짜의 값 가져오기
        
     	// 모든 날짜 항목에서 active 클래스 제거
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        
        // 클릭한 날짜 항목에 active 클래스 추가
        $(this).addClass('active');
        
        loadMovieTimeTable(); // 영화 시간표 목록을 불러오는 함수 호출
    });

    function loadMovieTimeTable() {
        if (selectedCNum && selectedMCode && selectedDate) {
        	console.log('Request Data:', {
                c_num: selectedCNum,
                m_code: selectedMCode,
                mt_date: selectedDate
            });
            // 영화 시간표 목록 불러오기
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/selectMovieTimeList',
                data: { c_num: selectedCNum, m_code: selectedMCode, mt_date2: selectedDate },
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
        }
    }

    // 영화 시간 데이터 담기 클릭 이벤트 핸들러 추가
    $(document).on('click', '.movietime-item', function() {
        selectedMtStart = $(this).data('start-time'); // 클릭한 상영시간의 값 가져오기

        // 모든 상영시간 항목에서 active 클래스 제거
        $('.movietime-item').removeClass('active');
        
        // 클릭한 상영시간 항목에 active 클래스 추가
        $(this).addClass('active');
    });  
    
    
    // 툴팁 생성
    $(document).on('mouseenter', '.movietime-item', function() {
        let endTime = $(this).data('end-time');
        let tooltip = '<div class="tooltip">종료: ' + endTime + '</div>';
        $('body').append(tooltip);
        let tooltipElement = $('.tooltip');
        tooltipElement.css({
            top: event.pageY + 10,
            left: event.pageX + 10
        });
    });

    $(document).on('mousemove', '.movietime-item', function(event) {
        let tooltipElement = $('.tooltip');
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
                            <li class="theater-place"> <a href="#" class="button theater-branch" data-cnum="${cinema.c_num}">${cinema.c_branch}</a></li>
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
            <div class="cinema-gallery"></div>
            <script>
                // 현재 날짜 객체 생성
                let currentDate = new Date();

                // 요일 배열 생성
                let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

                // 영화 날짜 생성 함수
                function generateMovieDays() {
                    let gallery = document.querySelector('.cinema-gallery');
                    gallery.innerHTML = ''; // 기존 내용을 비웁니다.

                    for (let i = 0; i < 12; i++) {
                        let dayElement = document.createElement('div');
                        let displayDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + i);
                        let day = displayDate.getDate();
                        let dayOfWeek = daysOfWeek[displayDate.getDay()];
                        let year = displayDate.getFullYear().toString().slice(-2); // YY 형식
                        let month = (displayDate.getMonth() + 1).toString().padStart(2, '0'); // MM 형식
                        let formattedDay = day.toString().padStart(2, '0'); // DD 형식

                        let formattedDate = formattedDay + '<br>' + dayOfWeek;
                        let dayClass = 'movie-day';

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
                        dayElement.dataset.date = year + '/' + month + '/' + formattedDay; // 날짜 데이터 속성 추가

                        // 클릭 이벤트 추가
                        dayElement.addEventListener('click', function() {
                            selectedDate = this.dataset.date;
                            loadMovieTimeTable();
                        });

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
                        <!-- Ajax로 받아온 영화 시간표 목록이 여기에 추가됩니다. -->
                    </ul>
                </div>
            </div>
        </div>

        <div class="seat-select-button">
            <input type="button" class="moveSeatButton" value="좌석 선택" onclick="location.href='movieSeat'">
        </div>
    </div>
</div>
