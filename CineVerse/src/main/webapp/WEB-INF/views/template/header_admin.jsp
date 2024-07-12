<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
@charset "UTF-8";

* {
    box-sizing: border-box;
    margin : 0;
}

body {
    line-height: 2.0;
}

.container {
padding: 4px;
    margin: 0 auto;
    overflow: hidden;
}

.site-header {
    background-color: var(--gray-1);
}

.site-header .logo {
    float: left;
}

.site-header .logo a {
    color: #fff;
    text-decoration: none;
}


.site-header .main-navigation {
    float: right;
}

.site-header .main-navigation ul {
    list-style-type: none;
}

.site-header .main-navigation ul li {
    display: inline-block;
}

.site-header .main-navigation ul li a {
        font-weight: 600;
    color: #000;
    text-decoration: none;
    font-size: 13px;
    transition: all 0.3s ease;
    padding: 10px;
}

</style>    
    
<header class="site-header">
    <div class="container">
        <nav class="main-navigation">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/adminMain">홈</a></li>
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
