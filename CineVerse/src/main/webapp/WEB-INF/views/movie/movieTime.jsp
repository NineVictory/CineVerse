<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<div class="reserve-container">
    <!-- 영화 -->
    <div class="movie-part">
        <div class="reserve-title">영화</div>
        <div class="select-movietime"><span id="selected-movie">선택한 영화명</span></div>
        <div class="sort-wrapper">
            <div class="sort-rate sort-selected">예매율순</div>
            <div class="sort-korean">가나다순</div>
        </div>
        <div class="movie-list-wrapper">
            <div class="movie-list">
                <ul class="movie-select">
                    <c:forEach items="${movieList}" var="movie">
                        <li class="select" data-mcode="${movie.m_code}">
                        	<span class="ic_grade <c:choose><c:when test="${movie.rating eq '12세관람가' }">gr_12</c:when>
						                    <c:when test="${movie.rating eq '12세이상관람가' }">gr_12</c:when>
						                    <c:when test="${movie.rating eq '전체관람가' }">gr_all</c:when>
						                    <c:when test="${movie.rating eq '15세관람가' }">gr_15</c:when>
						                    <c:when test="${movie.rating eq '15세이상관람가' }">gr_15</c:when>
						                    <c:when test="${movie.rating eq '18세관람가(청소년관람불가)' }">gr_19</c:when>
						                    <c:when test="${movie.rating eq '청소년관람불가' }">gr_19</c:when></c:choose>">
					                	</span>
                        <a href="#none">${movie.m_name}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <!-- 날짜 및 시간 -->
    <div class="time-part">
        <div class="reserve-title">날짜 및 시간</div>
        <div class="select-movietime"><span id="selected-date">선택한 날짜</span></div>
        <div class="reserve-time">
            <div class="cinema-gallery"></div>
            <script>
                $(document).ready(function() {
                    // 현재 날짜 객체 생성
                    let currentDate = new Date();

                    // 요일 배열 생성
                    let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

                    let selectedMovie = null;
                    let selectedDate = null;
                    let selectedLocation = null;

                    // 영화 날짜 생성 함수
                    function generateMovieDays() {
                        let $gallery = $('.cinema-gallery');
                        $gallery.empty(); // 기존 내용을 비웁니다.

                        for (let i = 0; i < 12; i++) {
                            let $dayElement = $('<div></div>');
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

                            $dayElement.addClass(dayClass);
                            $dayElement.html(formattedDate);
                            $dayElement.attr('data-date', year + '/' + month + '/' + formattedDay); // 날짜 데이터 속성 추가

                            // 클릭 이벤트 추가
                            $dayElement.on('click', function() {
                                $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('selected');
                                $(this).addClass('selected');
                                selectedDate = $(this).attr('data-date');
                                $('#selected-date').text(selectedDate); // 선택한 날짜를 표시
                                console.log('Selected Date:', selectedDate);
                                loadMovieTimeTable();
                            });

                            $gallery.append($dayElement);
                        }
                    }

                    // 영화 선택 클릭 이벤트 처리
                    $('.movie-select li').on('click', function() {
                        $('.movie-select li').removeClass('selected');
                        $(this).addClass('selected');
                        selectedMovie = $(this).attr('data-mcode');
                        $('#selected-movie').text($(this).text()); // 선택한 영화명을 표시
                        console.log('Selected Movie:', selectedMovie);

                        // 날짜 및 지역 초기화
                        selectedDate = null;
                        selectedLocation = null;
                        $('#selected-date').text('선택한 날짜');
                        $('.reserve-time-wrapper').empty();
                        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('selected'); // 날짜 선택 초기화

                        // 지역 선택 초기화
                        $('.theater-location .button').removeClass('selected'); 

                        loadMovieTimeTable();
                    });

                    // 지역 선택 클릭 이벤트 처리
                    $('.theater-location .button').on('click', function() {
                        $('.theater-location .button').removeClass('selected');
                        $(this).addClass('selected');
                        selectedLocation = $(this).attr('data-c_location'); // 데이터 속성에서 값을 가져옵니다.
                        console.log('Selected Location:', selectedLocation);
                        loadMovieTimeTable(); // 지역이 선택되었으므로 시간표를 로드합니다.
                    });

                    function formatTime(time) {
                        let str = time.toString().padStart(4, '0'); // Ensure the time is at least 4 digits
                        return str.slice(0, 2) + ':' + str.slice(2);
                    }
                    
                    
                    // 시간표를 로드하는 함수
                    function loadMovieTimeTable() {
                        console.log('Loading Time Table with:', {
                            selectedMovie: selectedMovie,
                            selectedDate: selectedDate,
                            selectedLocation: selectedLocation
                        }); 
                        if (selectedMovie && selectedDate && selectedLocation) {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/showMovieTimeList', 
                                type: 'GET',
                                data: {
                                    m_code: selectedMovie,
                                    mt_date2: selectedDate,
                                    c_location: selectedLocation
                                },
                                success: function(response) {
                                    // 중복된 c_branch를 추적하기 위한 객체 생성
                                    let branches = {};
                                    let selectMovieTimeListHtml = '';

                                    response.forEach(function(item) {
                                        // c_branch가 객체에 없으면 추가하고 HTML에 추가
                                        if (!branches[item.c_branch]) {
                                            branches[item.c_branch] = true;
                                            selectMovieTimeListHtml += '<div class="branch-section"><h3 class="c-location">' + item.c_branch + '</h3><div class="branch-time-list">';
                                        }

                                        selectMovieTimeListHtml += '<div class="movietime-item" data-end-time="' + formatTime(item.mt_end) + '">';
                                        selectMovieTimeListHtml += '<div class="mt-start">' + formatTime(item.mt_start) + '</div>';
                                        selectMovieTimeListHtml += '<div class="th-name">' + item.th_name + '관' + '</div>';
                                        selectMovieTimeListHtml += '</div>';

                                        
                                    });

                                    $('.reserve-time-wrapper').html(selectMovieTimeListHtml);
                                },
                                error: function() {
                                    alert('시간표 조회 오류 발생');
                                }
                            });
                        } else {
                            $('.reserve-time-wrapper').empty(); // 영화와 날짜가 모두 선택되지 않은 경우
                        }
                    }

                    // 영화 날짜 생성 함수 호출
                    generateMovieDays();
                    
                    // 툴팁 생성
                    $(document).on('mouseenter', '.movietime-item', function(event) {
                        let endTime = $(this).data('end-time');
                        let tooltip = '<div class="tooltip">종료 | ' + endTime + '</div>';
                        $('body').append(tooltip);
                        let tooltipElement = $('.tooltip');
                        tooltipElement.css({
                            top: event.pageY + 8,
                            left: event.pageX + 10
                        });
                    });

                    $(document).on('mousemove', '.movietime-item', function(event) {
                        let tooltipElement = $('.tooltip');
                        tooltipElement.css({
                            top: event.pageY + 8,
                            left: event.pageX + 10
                        });
                    });

                    $(document).on('mouseleave', '.movietime-item', function() {
                        $('.tooltip').remove();
                    });
                    
                    
                });
            </script>
            <!-- 날짜 끝 -->
            <!-- 지역 선택 -->
            <div class="location-part">
                <ul class="theater-location-wrapper">
                    <li class="theater-location" id="seoul-location">
                        <a href="#" class="button" data-c_location="1">서울</a>
                        <a href="#" class="button" data-c_location="2">경기</a>
                        <a href="#" class="button" data-c_location="3">인천</a> 
                        <a href="#" class="button" data-c_location="4">강원</a>
                        <a href="#" class="button" data-c_location="5">대전/충청</a>
                        <a href="#" class="button" data-c_location="6">경상</a>
                        <a href="#" class="button" data-c_location="7">광주/전라</a>
                    </li>
                </ul>
            </div>
            <div class="reserve-time-wrapper">
                <!-- 시간표가 여기에 표시됩니다. -->
            </div>
        </div>
    </div>
</div>
