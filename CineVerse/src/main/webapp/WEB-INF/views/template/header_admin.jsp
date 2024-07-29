<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.header.css" type="text/css">
<header class="site-header">
    <div class="container_admin">
        <nav class="main-navigation">
            <ul>
                <li><a href="${pageContext.request.contextPath}/main/main">홈</a></li>
                <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                <li><a><span id="currentDateTime"></span></a></li>
            </ul>
        </nav>
    </div>
</header>

<script>
    // 현재 시간을 가져오는 함수
    function getCurrentDateTime() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1; // 월은 0부터 시작하므로 1을 더함
        var day = now.getDate();
        var dayOfWeek = now.getDay(); // 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)

        // 월, 일이 한 자리 숫자일 경우 앞에 0을 추가하여 두 자리로 표시
        if (month < 10) { month = '0' + month; }
        if (day < 10) { day = '0' + day; }

        // 요일을 숫자에서 문자열로 변환
        var days = ['일', '월', '화', '수', '목', '금', '토'];
        var dayOfWeekStr = days[dayOfWeek];

        // 현재 날짜와 요일을 원하는 형식으로 출력
        var formattedDateTime = year + '-' + month + '-' + day + ' (' + dayOfWeekStr + ')';
        return formattedDateTime;
    }

    // 페이지가 로드될 때 실행되는 함수
    window.onload = function() {
        // 현재 날짜와 요일을 가져와서 span 요소에 적용
        document.getElementById('currentDateTime').innerHTML = getCurrentDateTime();
    };
</script>
