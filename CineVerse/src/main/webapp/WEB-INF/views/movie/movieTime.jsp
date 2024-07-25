<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
 <div class="reserve-container">
        <!-- 영화 -->
        <div class="movie-part">
            <div class="reserve-title">영화</div>
            <div class="select-movietime">선택한 영화</div>
            <div class="sort-wrapper">
                <div class="sort-rate sort-selected">예매율순</div>
                <div class="sort-korean">가나다순</div>
            </div>
            <div class="movie-list-wrapper">
                <div class="movie-list">
                    <ul class="movie-select">
                        <c:forEach items="${movieList}" var="movie">
                            <li class="select" data-mcode="${movie.m_code}"><a href="#none">${movie.m_name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        
        <!-- 날짜 및 시간 -->
        <div class="time-part">
            <div class="reserve-title">날짜 및 시간</div>
            <div class="select-movietime">선택한 날짜</div>
            <div class="reserve-time">
                <div class="cinema-gallery"></div>
                <script>
                    // 현재 날짜 객체 생성
                    let currentDate = new Date();

                    // 요일 배열 생성
                    let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

                    let selectedMovie = null;
                    let selectedDate = null;

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
                                document.querySelectorAll('.movie-day').forEach(day => day.classList.remove('selected'));
                                this.classList.add('selected');
                                selectedDate = this.dataset.date;
                                loadMovieTimeTable();
                            });

                            gallery.appendChild(dayElement);
                        }
                    }

                    // 영화 선택 클릭 이벤트 처리
                    document.querySelectorAll('.movie-select li').forEach(item => {
                        item.addEventListener('click', function() {
                            document.querySelectorAll('.movie-select li').forEach(li => li.classList.remove('selected'));
                            this.classList.add('selected');
                            selectedMovie = this.dataset.mcode;
                            loadMovieTimeTable();
                        });
                    });

                    // 영화 날짜 생성 함수 호출
                    generateMovieDays();

                    // 시간표를 로드하는 함수
                    function loadMovieTimeTable() {
                        if (selectedMovie && selectedDate) {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/showMovieTimeList', 
                                type: 'GET',
                                data: {
                                    m_code: selectedMovie,
                                    mt_date2: selectedDate
                                },
                                success: function(response) {
                                	 // 성공 시 시간표 데이터를 처리하는 코드
                                    let tableHtml = '<table><thead><tr><th>지점명</th><th>상영일자</th><th>시작시간</th><th>종료시간</th><th>상영관 이름</th></tr></thead><tbody>';
                                    response.forEach(function(item) {
                                        tableHtml += '<tr>';
                                        tableHtml += '<td>' + item.c_branch + '</td>';
                                        tableHtml += '<td>' + item.mt_date + '</td>';
                                        tableHtml += '<td>' + item.mt_start + '</td>';
                                        tableHtml += '<td>' + item.mt_end + '</td>';
                                        tableHtml += '<td>' + item.th_name + '</td>';
                                        tableHtml += '</tr>';
                                    });
                                    tableHtml += '</tbody></table>';
                                    $('.reserve-time-wrapper').html(tableHtml);
                                },
                                error: function() {
                                    alert('시간표 조회 오류 발생')
                                }
                            });
                        } else {
                            $('.reserve-time-wrapper').empty(); // 영화와 날짜가 모두 선택되지 않은 경우
                        }
                    }
                </script>
                <!-- 날짜 끝 -->
                <div class="reserve-time-wrapper">
                    <!-- 시간표가 여기에 표시됩니다. -->
                </div>
            </div>
        </div>
    </div>