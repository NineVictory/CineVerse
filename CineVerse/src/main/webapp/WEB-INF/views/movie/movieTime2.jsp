<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<div class="reserve-container">
    <!-- 영화 -->
    <div class="movie-part">
        <div class="reserve-title">영화</div>
        <div class="select-movietime"><span id="selected-movie">선택한 영화명</span></div>
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

                    let selectedMovie = '${m_code}';
                    let selectedDate = '${mt_date}';
                    let selectedLocation = '${c_location}';

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
                            let fullDate = year + '/' + month + '/' + formattedDay;
                            $dayElement.attr('data-date', fullDate); // 날짜 데이터 속성 추가

                            // 클릭 이벤트 추가
                            $dayElement.on('click', function() {
                                $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('movie-day-selected');
                                $(this).addClass('movie-day-selected');
                                selectedDate = $(this).attr('data-date');
                                $('#selected-date').text(selectedDate); // 선택한 날짜를 표시
                                console.log('Selected Date:', selectedDate);
                                loadMovieTimeTable();
                            });

                            $gallery.append($dayElement);

                            // 페이지 로드 시 선택된 날짜 표시
                            if (fullDate === selectedDate) {
                                $dayElement.addClass('movie-day-selected');
                                $('#selected-date').text(selectedDate);
                            }
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
                        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('movie-day-selected'); // 날짜 선택 초기화

                        // 지역 선택 초기화
                        $('.theater-location .button').removeClass('movie-day-selected'); 

                        // 스크롤을 선택된 영화 항목으로 이동
                        scrollToSelectedMovie(selectedMovie);

                        loadMovieTimeTable();
                    });

                    // 지역 선택 클릭 이벤트 처리
                    $('.theater-location .button').on('click', function() {
                        $('.theater-location .button').removeClass('movie-day-selected');
                        $(this).addClass('movie-day-selected');
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
                                    // c_branch별로 항목을 그룹화하기 위한 객체 생성
                                    let branches = {};

                                    response.forEach(function(item) {
                                        if (!branches[item.c_branch]) {
                                            // 새로운 c_branch를 발견한 경우, 객체에 추가하고 HTML에 추가
                                            branches[item.c_branch] = [];
                                        }
                                        // c_branch에 해당하는 항목들을 배열에 추가
                                        branches[item.c_branch].push(item);
                                    });

                                    let selectMovieTimeListHtml = '';

                                    // 각 c_branch에 대해 반복
                                    for (let branch in branches) {
                                        // c_branch 제목을 추가
                                        selectMovieTimeListHtml +='<h3 class="c-location">' + branch + '</h3>';
                                        selectMovieTimeListHtml += '<div class="branch-section">';

                                        // 시간표 항목들을 가로로 정렬할 수 있도록 HTML 생성
                                        branches[branch].forEach(function(item) {
                                            selectMovieTimeListHtml += '<div class="movietime-container" data-mtNum="' + item.mt_num + '">';
                                            selectMovieTimeListHtml += '<div class="movietime-item" data-end-time="' + formatTime(item.mt_end) + '">';
                                            selectMovieTimeListHtml += '<div class="mt-start">' + formatTime(item.mt_start) + '</div>';
                                            selectMovieTimeListHtml += '<div class="th-name">' + item.th_name + '관' + '</div>';
                                            selectMovieTimeListHtml += '</div>';
                                            selectMovieTimeListHtml += '</div>'; // movietime-container 종료
                                        });
                                        selectMovieTimeListHtml += '</div>'; // branch-section 종료
                                    }


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

                    function scrollToSelectedMovie(movieCode) {
                        let $selectedMovieElement = $('.movie-select li[data-mcode="' + movieCode + '"]');
                        if ($selectedMovieElement.length) {
                            // 선택된 영화 항목이 있는 경우, movie-list-wrapper의 스크롤을 조정
                            $('.movie-list-wrapper').animate({
                                scrollTop: $selectedMovieElement.position().top + $('.movie-list-wrapper').scrollTop() - $('.movie-list-wrapper').height() / 2 + $selectedMovieElement.outerHeight() / 2
                            }, 500);
                        }
                    }

                    // 영화 날짜 생성 함수 호출
                    generateMovieDays();

                    // 페이지 로드 시 선택된 영화 및 지역 표시 및 시간표 로드
                    if (selectedMovie) {
                        $('.movie-select li[data-mcode="' + selectedMovie + '"]').addClass('selected');
                        $('#selected-movie').text($('.movie-select li[data-mcode="' + selectedMovie + '"]').text());

                        // 페이지 로드 시 자동 스크롤
                        scrollToSelectedMovie(selectedMovie);
                    }

                    if (selectedLocation) {
                        $('.theater-location .button[data-c_location="' + selectedLocation + '"]').addClass('movie-day-selected');
                    }

                    loadMovieTimeTable(); // 초기 로드 시 시간표 로드

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

                    // movietime-container 클릭 이벤트 처리
                    $(document).on('click', '.movietime-container', function() {
                        let check = confirm('영화를 예매하시겠습니까?');
                        let mt_num = $(this).data('mtnum');
                        if (check) {
                            window.location.href = '../movie/movieSeat?mt_num=' + mt_num;
                        }
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


<div id="banner_reserve_section" class="banner_reserve_wrap">
    <div class="bx_lft"><a
            href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_37&amp;adgroupid=adg_lottecinema_20240530_55&amp;adid=adi_lottecinema_20240530_65"
            target="_blank" title="새창열기"><img
                src="https://cf2.lottecinema.co.kr/lotte_image/2024/LotteCard/LotteCard_160300.png"></a></div>
    <div class="bx_rgt"><a
            href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_37&amp;adgroupid=adg_lottecinema_20230706_10&amp;adid=adi_lottecinema_20230706_10"
            target="_blank" title="새창열기"><img
                src="https://cf2.lottecinema.co.kr/lotte_image/2024/Hyundai_Insurance/Hyundai_Insurance_1603002.jpg"></a></div>
</div>

<div id="banner_section" class="banner_wrap">
    <div class="banner_01"><a
            href="${pageContext.request.contextPath}/movie/movieDetail?m_code=37"
            target="" title="화면이동"><img src="https://cf2.lottecinema.co.kr/lotte_image/2024/Pilot/Pilot_9801807.jpg"
                alt="올 여름 코미디의 정석이 이륙합니다 입소문 폭발 더위 탈출 코미디 파일럿 7월 31일 극장 대개봉"></a></div>
</div>

<style>
.banner_side_wrap {
        position: absolute;
        top: 220px;
        left: 50%;
        margin-left: -660px;
        z-index: 10;
    }

    .banner_wrap .banner_01 {
        margin-bottom: 50px;
    }

    .banner_wrap {
        padding-top: 70px;
        text-align: center;
    }

    .banner_wrap a {
        display: block;
        width: 980px;
        margin: 0 auto;
    }

    a,
    a:link,
    a:visited,
    a:active,
    a:hover {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .banner_reserve_wrap .bx_lft {
        left: 50%;
        margin-left: -820px;
    }

    .banner_reserve_wrap .bx_lft,
    .banner_reserve_wrap .bx_rgt {
        position: absolute;
        z-index: 10;
        top: 220px;
        width: 160px;
        height: 300px;
    }

    .banner_reserve_wrap .bx_rgt {
        right: 50%;
        margin-right: -820px;
    }

    .quick-reserve-ad-area {
        overflow: hidden;
        width: 1100px;
        height: 80px;
        margin-top: 10px;
    }

    iframe {
        display: inline-block;
        border: 0;
    }
</style>
