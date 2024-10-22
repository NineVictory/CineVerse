<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- <script type="text/javascript">
$(document).ready(function() {
    let selectedCNum = null;
    let selectedMCode = null;
    let selectedDate = null;
    let selectedMtStart = null;

    // 지점 클릭 이벤트 핸들러
    $('.theater-place > a').click(function(e) {	
        e.preventDefault(); // 기본 동작 중지
        let c_num = $(this).data('cnum'); // 클릭한 지점의 c_num 값 가져오기
        selectedCNum = $(this).attr('data-cnum');
        
        // 선택된 영화, 날짜, 시간 초기화
        selectedMCode = null;
        selectedDate = null;
        selectedMtStart = null;
        $('#mt_num').val(''); // hidden input 초기화
        
        // 영화 목록 불러오기
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/movieReserveList',
            data: { c_num: c_num },
            dataType: 'json',
            success: function(data) {
                // 성공적으로 데이터를 받았을 때 처리
                let movieListHtml = '';
                $.each(data, function(index, movie) {
                	let gradeClass = '';
                    
                    switch (movie.rating) {
                        case '12세관람가':
                        case '12세이상관람가':
                            gradeClass = 'gr_12';
                            break;
                        case '전체관람가':
                            gradeClass = 'gr_all';
                            break;
                        case '15세관람가':
                        case '15세이상관람가':
                            gradeClass = 'gr_15';
                            break;
                        case '18세관람가(청소년관람불가)':
                        case '청소년관람불가':
                            gradeClass = 'gr_19';
                            break;
                        default:
                            gradeClass = 'gr_unknown';
                    }
                	
                    movieListHtml += '<li class="select" data-cnum="' + c_num + '" data-mcode="' + movie.m_code + '">';
                    movieListHtml += '<a href="#" class="movie-item" ><span class="ic_grade ' + gradeClass + '"></span></a>';
                    movieListHtml += '<a href="#" class="movie-item" >'+ movie.m_name + '</a>';
                    movieListHtml += '</li>';
                });
                $('.movie-list ul').html(movieListHtml); // 영화 목록 업데이트
            },
            error: function() {
                alert('영화 목록을 불러오는 데 실패했습니다.');
            }
        });
        
        // 날짜 및 시간 초기화
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        $('.movietime-item').removeClass('active');
        $('.movietime-select').empty(); // 시간표 목록 초기화
    });

    // 영화 클릭 이벤트 핸들러 설정
    $(document).on('click', '.select', function(e) {
        e.preventDefault(); // 기본 동작 중지

        selectedMCode = $(this).attr('data-mcode');
        
        // 선택된 날짜, 시간 초기화
        selectedDate = null;
        selectedMtStart = null;
        $('#mt_num').val(''); // hidden input 초기화
        
        // 모든 영화 항목에서 active 클래스 제거
        $('.select').removeClass('active');
        
        // 클릭한 영화 항목에 active 클래스 추가
        $(this).addClass('active');
        
        // 날짜 및 시간 초기화
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        $('.movietime-item').removeClass('active');
        $('.movietime-select').empty(); // 시간표 목록 초기화
    });

    // 날짜 클릭 이벤트 핸들러 설정
    $(document).on('click', '.movie-day, .movie-day-sun, .movie-day-sat', function() {
        if (selectedMCode) { // 영화가 선택된 경우에만 날짜 선택
            selectedDate = $(this).data('date'); // 클릭한 날짜의 값 가져오기
            
            // 모든 날짜 항목에서 active 클래스 제거
            $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
            
            // 클릭한 날짜 항목에 active 클래스 추가
            $(this).addClass('active');
            
            // 선택된 시간 초기화
            selectedMtStart = null;
            $('#mt_num').val(''); // hidden input 초기화
            
            // 모든 상영시간 항목에서 active 클래스 제거
            $('.movietime-item').removeClass('active');
             
            loadMovieTimeTable(); // 영화 시간표 목록을 불러오는 함수 호출
        } else {
            alert('영화를 먼저 선택해주세요.');
        }
    });

    function formatTime(time) {
        let str = time.toString().padStart(4, '0'); // Ensure the time is at least 4 digits
        return str.slice(0, 2) + ':' + str.slice(2);
    }

    function loadMovieTimeTable() {
        if (selectedCNum && selectedMCode && selectedDate) {
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
                        selectMovieTimeListHtml += '<li class="movietime-item" data-end-time="' + formatTime(movietime.mt_end) + '" data-mtnum="' + movietime.mt_num + '">';
                        selectMovieTimeListHtml += '<div class="mt-start">' + formatTime(movietime.mt_start) + '</div>';
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
        selectedMtStart = $(this).data('mtnum'); 
        $('#mt_num').val(selectedMtStart);
        // 모든 상영시간 항목에서 active 클래스 제거
        $('.movietime-item').removeClass('active');
        
        // 클릭한 상영시간 항목에 active 클래스 추가
        $(this).addClass('active');
    });  
    
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
    
    // 좌석 선택 버튼 클릭 이벤트 핸들러 추가
    $('.movieSeatButton').click(function(e) {
        if (!selectedCNum) {
            alert('지점을 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedMCode) {
            alert('영화를 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedDate) {
            alert('날짜를 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedMtStart) {
            alert('시간을 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }
    });
});
</script> -->
<script type="text/javascript">
$(document).ready(function() {
    let selectedCNum = null;
    let selectedMCode = null;
    let selectedDate = null;
    let selectedMtStart = null;
    let selectedMovieHtml = null;

    // 지점 클릭 이벤트 핸들러
    $('.theater-place > a').click(function(e) {
        e.preventDefault(); // 기본 동작 중지
        selectedCNum = $(this).attr('data-cnum');
        
        // 다른 지점 클릭 시 초기화
        selectedDate = null;
        selectedMtStart = null;
        selectedMovieHtml = null;
        $('#mt_num').val('');
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        $('.movietime-item').removeClass('active');
        $('.movietime-select').empty(); // 시간표 목록 초기화
        $('.selected-movie-info').empty();
        
        // 모든 영화 항목에서 active 클래스 제거
        $('.theater-place > a').removeClass('active');

        // 클릭한 영화 항목에 active 클래스 추가
        $(this).addClass('active');
        
        loadMovieList('default'); // 기본 정렬
    });

    // 예매율 순 버튼 클릭 이벤트 핸들러
    $('.sort-rate').click(function(e) {
        e.preventDefault();
        loadMovieList('reservation'); // 예매율 순 정렬
    });

    // 가나다순 버튼 클릭 이벤트 핸들러
    $('.sort-korean').click(function(e) {
        e.preventDefault();
        loadMovieList('korean'); // 가나다순 정렬
    });
    
    // 최신순 버튼 클릭 이벤트 핸들러
    $('.sort-date-movie').click(function(e) {
        e.preventDefault();
        loadMovieList('date'); // 최신순 정렬
    });

    function loadMovieList(sort) {
        if (!selectedCNum) return; // 지점이 선택되지 않은 경우 반환
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/movieReserveList',
            data: { c_num: selectedCNum, sort: sort },
            dataType: 'json',
            success: function(data) {
                let movieListHtml = '';
                $.each(data, function(index, movie) {
                    let gradeClass = getGradeClass(movie.rating);
                    movieListHtml += '<li class="select" data-cnum="' + selectedCNum + '" data-mcode="' + movie.m_code + '">';
                    movieListHtml += '<a href="#" class="movie-item"><span class="ic_grade ' + gradeClass + '"></span></a>';
                    movieListHtml += '<a href="#" class="movie-item"><span class="movie_name_over">'+ movie.m_name + '</span></a>';
                    movieListHtml += '</li>';
                });
                $('.movie-list ul').html(movieListHtml); // 영화 목록 업데이트
            },
            error: function() {
                alert('영화 목록을 불러오는 데 실패했습니다.');
            }
        });
    }

    function getGradeClass(rating) {
        switch (rating) {
            case '12세관람가':
            case '12세이상관람가':
                return 'gr_12';
            case '전체관람가':
                return 'gr_all';
            case '15세관람가':
            case '15세이상관람가':
                return 'gr_15';
            case '18세관람가(청소년관람불가)':
            case '청소년관람불가':
                return 'gr_19';
            default:
                return 'gr_unknown';
        }
    }

    // 영화 클릭 이벤트 핸들러 설정
    $(document).on('click', '.select', function(e) {
        e.preventDefault(); // 기본 동작 중지

        selectedMCode = $(this).attr('data-mcode');

        // 선택된 날짜, 시간 초기화
        selectedDate = null;
        selectedMtStart = null;
        $('#mt_num').val(''); // hidden input 초기화

        // 모든 영화 항목에서 active 클래스 제거
        $('.select').removeClass('active');

        // 클릭한 영화 항목에 active 클래스 추가
        $(this).addClass('active');

        // 날짜 및 시간 초기화
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        $('.movietime-item').removeClass('active');
        $('.movietime-select').empty(); // 시간표 목록 초기화
    });

    // 날짜 클릭 이벤트 핸들러 설정
    $(document).on('click', '.movie-day, .movie-day-sun, .movie-day-sat', function() {
        if (selectedMCode) { // 영화가 선택된 경우에만 날짜 선택
            selectedDate = $(this).data('date'); // 클릭한 날짜의 값 가져오기

            // 모든 날짜 항목에서 active 클래스 제거
            $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');

            // 클릭한 날짜 항목에 active 클래스 추가
            $(this).addClass('active');

            // 선택된 시간 초기화
            selectedMtStart = null;
            $('#mt_num').val(''); // hidden input 초기화

            // 모든 상영시간 항목에서 active 클래스 제거
            $('.movietime-item').removeClass('active');

            loadMovieTimeTable(); // 영화 시간표 목록을 불러오는 함수 호출
        } else {
            alert('영화를 먼저 선택해주세요.');
        }
    });

    function formatTime(time) {
        let str = time.toString().padStart(4, '0'); // Ensure the time is at least 4 digits
        return  str.slice(0, 2) + ':' + str.slice(2);
    }

    function loadMovieTimeTable() {
        if (selectedCNum && selectedMCode && selectedDate) {
        	console.log('선택한 날짜 : ' + selectedDate);
            // 영화 시간표 목록 불러오기
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/selectMovieTimeList',
                data: { c_num: selectedCNum, m_code: selectedMCode, mt_date2: selectedDate },
                dataType: 'json',
                success: function(data) {
                    let selectMovieTimeListHtml = '';
                    let currentTime = new Date(); // 현재 시간 가져오기
					
                    $.each(data, function(index, movietime) {
                        //let movieStartTime = new Date('20'+selectedDate + ' ' + formatTime(movietime.mt_start)); // 영화 시작 시간을 Date 객체로 변환
                        let movieStartTime = new Date(selectedDate + ' ' + formatTime(movietime.mt_start)); // 영화 시작 시간을 Date 객체로 변환
						console.log('영화 시간 : '+movieStartTime+ ',현재 시간:' + currentTime);
                        // 현재 시간이 영화 시작 시간보다 이후인 경우에만 표시
                        if (currentTime < movieStartTime) {
                            selectMovieTimeListHtml += '<li class="movietime-item" data-end-time="' + formatTime(movietime.mt_end) + '" data-mtnum="' + movietime.mt_num + '">';
                            selectMovieTimeListHtml += '<div class="mt-start">' + formatTime(movietime.mt_start) + '</div>';
                            selectMovieTimeListHtml += '<div class="th_seat_name">';
                            selectMovieTimeListHtml += '<div class="available-seats">' + movietime.availableSeats + '/96</div>'; // 좌석 수 추가
                            selectMovieTimeListHtml += '<div class="th-name">' + movietime.th_name + '관' + '</div>';
                            selectMovieTimeListHtml += '</div>';
                            selectMovieTimeListHtml += '</li>';
                        }
                    });

                    if (selectMovieTimeListHtml === '') {
                        selectMovieTimeListHtml = '<li>현재 시간 이후의 상영 일정이 없습니다.</li>';
                    }

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
        selectedMtStart = $(this).data('mtnum');
        $('#mt_num').val(selectedMtStart);
        // 모든 상영시간 항목에서 active 클래스 제거
        $('.movietime-item').removeClass('active');

        // 클릭한 상영시간 항목에 active 클래스 추가
        $(this).addClass('active');
    });

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

    // 좌석 선택 버튼 클릭 이벤트 핸들러 추가
    $('.moveSeatButton').click(function(e) {
        if (!selectedCNum) {
            alert('지점을 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedMCode) {
            alert('영화를 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedDate) {
            alert('날짜를 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedMtStart) {
            alert('시간을 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }
    });
});
</script>

<!-- <script type="text/javascript">
$(document).ready(function() {
    let selectedCNum = null;
    let selectedMCode = null;
    let selectedDate = null;
    let selectedMtStart = null;
    let selectedMovieHtml = null;

    // 지점 클릭 이벤트 핸들러
    $('.theater-place > a').click(function(e) {
        e.preventDefault(); // 기본 동작 중지
        selectedCNum = $(this).attr('data-cnum');
        
        //다른 지점 클릭 시 초기화
        selectedDate = null;
        let selectedMtStart = null;
        let selectedMovieHtml = null;
        $('#mt_num').val('');
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        $('.movietime-item').removeClass('active');
        $('.movietime-select').empty(); // 시간표 목록 초기화
        $('.selected-movie-info').empty();
        
        // 모든 영화 항목에서 active 클래스 제거
        $('.theater-place > a').removeClass('active');

        // 클릭한 영화 항목에 active 클래스 추가
        $(this).addClass('active');
        
        
        loadMovieList('default'); // 기본 정렬
    });

    // 예매율 순 버튼 클릭 이벤트 핸들러
    $('.sort-rate').click(function(e) {
        e.preventDefault();
        loadMovieList('reservation'); // 예매율 순 정렬
    });

    // 가나다순 버튼 클릭 이벤트 핸들러
    $('.sort-korean').click(function(e) {
        e.preventDefault();
        loadMovieList('korean'); // 가나다순 정렬
    });
    
    // 최신순 버튼 클릭 이벤트 핸들러
    $('.sort-date-movie').click(function(e) {
        e.preventDefault();
        loadMovieList('date'); // 최신순 정렬
    });

    function loadMovieList(sort) {
        if (!selectedCNum) return; // 지점이 선택되지 않은 경우 반환
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/movieReserveList',
            data: { c_num: selectedCNum, sort: sort },
            dataType: 'json',
            success: function(data) {
                let movieListHtml = '';
                $.each(data, function(index, movie) {
                    let gradeClass = getGradeClass(movie.rating);
                    movieListHtml += '<li class="select" data-cnum="' + selectedCNum + '" data-mcode="' + movie.m_code + '">';
                    movieListHtml += '<a href="#" class="movie-item"><span class="ic_grade ' + gradeClass + '"></span></a>';
                    movieListHtml += '<a href="#" class="movie-item"><span class="movie_name_over">'+ movie.m_name + '</span></a>';
                    movieListHtml += '</li>';
                });
                $('.movie-list ul').html(movieListHtml); // 영화 목록 업데이트
            },
            error: function() {
                alert('영화 목록을 불러오는 데 실패했습니다.');
            }
        });
    }

    function getGradeClass(rating) {
        switch (rating) {
            case '12세관람가':
            case '12세이상관람가':
                return 'gr_12';
            case '전체관람가':
                return 'gr_all';
            case '15세관람가':
            case '15세이상관람가':
                return 'gr_15';
            case '18세관람가(청소년관람불가)':
            case '청소년관람불가':
                return 'gr_19';
            default:
                return 'gr_unknown';
        }
    }

    // 영화 클릭 이벤트 핸들러 설정
    $(document).on('click', '.select', function(e) {
        e.preventDefault(); // 기본 동작 중지

        selectedMCode = $(this).attr('data-mcode');

        // 선택된 날짜, 시간 초기화
        selectedDate = null;
        selectedMtStart = null;
        $('#mt_num').val(''); // hidden input 초기화

        // 모든 영화 항목에서 active 클래스 제거
        $('.select').removeClass('active');

        // 클릭한 영화 항목에 active 클래스 추가
        $(this).addClass('active');

        // 날짜 및 시간 초기화
        $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
        $('.movietime-item').removeClass('active');
        $('.movietime-select').empty(); // 시간표 목록 초기화
    });

    // 날짜 클릭 이벤트 핸들러 설정
    $(document).on('click', '.movie-day, .movie-day-sun, .movie-day-sat', function() {
        if (selectedMCode) { // 영화가 선택된 경우에만 날짜 선택
            selectedDate = $(this).data('date'); // 클릭한 날짜의 값 가져오기

            // 모든 날짜 항목에서 active 클래스 제거
            $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');

            // 클릭한 날짜 항목에 active 클래스 추가
            $(this).addClass('active');

            // 선택된 시간 초기화
            selectedMtStart = null;
            $('#mt_num').val(''); // hidden input 초기화

            // 모든 상영시간 항목에서 active 클래스 제거
            $('.movietime-item').removeClass('active');

            loadMovieTimeTable(); // 영화 시간표 목록을 불러오는 함수 호출
        } else {
            alert('영화를 먼저 선택해주세요.');
        }
    });

    function formatTime(time) {
        let str = time.toString().padStart(4, '0'); // Ensure the time is at least 4 digits
        return str.slice(0, 2) + ':' + str.slice(2);
    }

    function loadMovieTimeTable() {
        if (selectedCNum && selectedMCode && selectedDate) {
            // 영화 시간표 목록 불러오기
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/selectMovieTimeList',
                data: { c_num: selectedCNum, m_code: selectedMCode, mt_date2: selectedDate },
                dataType: 'json',
                success: function(data) {
                    let selectMovieTimeListHtml = '';
                    $.each(data, function(index, movietime) {
                        selectMovieTimeListHtml += '<li class="movietime-item" data-end-time="' + formatTime(movietime.mt_end) + '" data-mtnum="' + movietime.mt_num + '">';
                        selectMovieTimeListHtml += '<div class="mt-start">' + formatTime(movietime.mt_start) + '</div>';
                        selectMovieTimeListHtml += '<div class="th_seat_name">';
                        selectMovieTimeListHtml += '<div class="available-seats">' + movietime.availableSeats + '/96</div>'; // 좌석 수 추가
                        selectMovieTimeListHtml += '<div class="th-name">' + movietime.th_name + '관' + '</div>';
                        selectMovieTimeListHtml += '</div>';
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
        selectedMtStart = $(this).data('mtnum');
        $('#mt_num').val(selectedMtStart);
        // 모든 상영시간 항목에서 active 클래스 제거
        $('.movietime-item').removeClass('active');

        // 클릭한 상영시간 항목에 active 클래스 추가
        $(this).addClass('active');
    });

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

    // 좌석 선택 버튼 클릭 이벤트 핸들러 추가
    $('.moveSeatButton').click(function(e) {
        if (!selectedCNum) {
            alert('지점을 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedMCode) {
            alert('영화를 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedDate) {
            alert('날짜를 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (!selectedMtStart) {
            alert('시간을 선택해주세요.');
            e.preventDefault(); // 폼 제출 방지
            return;
        }
    });
});
</script> -->

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
        	<div class="sort-date-movie">최신순</div>
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
	
	<script type="text/javascript">
	$(document).ready(function() {
	    // 기존의 지점 클릭 이벤트 핸들러와 기타 코드들은 생략
	    
	    // 정렬 버튼 클릭 이벤트 핸들러
	    $('.sort-wrapper div').click(function() {
	        // 모든 버튼의 selected 클래스 제거
	        $('.sort-wrapper div').removeClass('selected');
	        // 클릭된 버튼에 selected 클래스 추가
	        $(this).addClass('selected');
	    });
	});
	</script>
	
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
                        //let year = displayDate.getFullYear().toString().slice(-2); // YY 형식
                        let year = displayDate.getFullYear().toString(); // YYYY 형식
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
            <script type="text/javascript">
            $(document).on('click', '.select', function(e) {
                e.preventDefault();

                selectedMCode = $(this).attr('data-mcode');
                let movieName = $(this).find('.movie-item').eq(1).text();
                let gradeClass = $(this).find('.ic_grade').attr('class').split(' ')[1];

                let movieGrade;
                switch (gradeClass) {
                    case 'gr_12':
                        movieGrade = '12세관람가';
                        break;
                    case 'gr_all':
                        movieGrade = '전체관람가';
                        break;
                    case 'gr_15':
                        movieGrade = '15세관람가';
                        break;
                    case 'gr_19':
                        movieGrade = '청소년관람불가';
                        break;
                    default:
                        movieGrade = '등급 정보 없음';
                }

                selectedMovieHtml = '<div class="movie-item selected">';
                selectedMovieHtml += '<span class="ic_grade ' + gradeClass + '"></span>';
                selectedMovieHtml += '<span class="reserve_movie_nm">' +movieName+'</span>';
                selectedMovieHtml += '</div>';

                $('.selected-movie-info').html(selectedMovieHtml);

                selectedDate = null;
                selectedMtStart = null;
                $('#mt_num').val(''); 
                
                $('.select').removeClass('active');
                
                $(this).addClass('active');
                
                $('.movie-day, .movie-day-sun, .movie-day-sat').removeClass('active');
                $('.movietime-item').removeClass('active');
                $('.movietime-select').empty(); // 시간표 목록 초기화
            });
            </script>
            
            <div class="reserve-time-wrapper">
                <div class="movitime-list">
                <div class="selected-movie-info"></div>
                    <ul class="movietime-select">
                        <!-- Ajax로 받아온 영화 시간표 목록이 여기에 추가됩니다. -->
                    </ul>
                </div>
            </div>
        </div>

        <div class="seat-select-button">
            <form action="movieSeat" method="get" id="movieSeat">
                <input type="hidden" name="mt_num" id="mt_num">
                <c:if test="${!empty user}">
                	<div class="moveSeatButton" id="moveSeatDiv">
                	<img src="${pageContext.request.contextPath}/images/wright-arrow.png" width="30">
                    <input type="submit" class="button_styles" value="좌석 선택" id="movieSeatDiv">
                    </div>
                </c:if>
                <c:if test="${empty user}">
                <div class="moveSeatButton" onclick="alertAndRedirect()">
                <img src="${pageContext.request.contextPath}/images/wright-arrow.png" width="30">
                <input type="submit" class="button_styles" value="좌석 선택">
                </div>
		</c:if>
            </form>    
        </div>
        <script>
        	document.getElementById('moveSeatDiv').addEventListener('click', function() {
            	// 버튼 요소를 찾아서 클릭 이벤트를 트리거
            	document.getElementById('movieSeatDiv').click();
       		 });
        
            function alertAndRedirect() {
                alert("로그인 후 이용하실 수 있습니다.");
                location.href = '${pageContext.request.contextPath}/member/login';
            }
        </script>
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