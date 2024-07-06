<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    line-height: 1.6;
}

.container {
    width: 80%;
    max-width: 1200px;
    margin: 0 auto;
    overflow: hidden;
}

.site-header {
    background-color: #F3F3F3;
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
    font-size: 10px;
    transition: all 0.3s ease;
    padding: 5px;
}

/* 하단 헤더 */
.secondary-header {
    padding: 10px 0;
    border-bottom: 1.5px solid #706FA2;
}

.secondary-header .container {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.secondary-header .logo {
    font-size: 20px;
}

.secondary-header .main-navigation {
    margin-left: 20px;
}

.secondary-header .main-navigation ul li {
    display: inline-block;
    margin-left: 20px;
}

.secondary-header .main-navigation ul li:first-child {
    margin-left: 0;
}

.secondary-header .main-navigation ul li a {
    font-weight: 700;
    color: #000;
    text-decoration: none;
    font-size: 14.5px;
    transition: all 0.3s ease;
    padding: 8px;
}

.secondary-header .main-navigation ul li a:hover {
    color: #555;
}

.secondary-header .user-menu {
    margin-right: 20px;
}

.secondary-header .user-menu a {
    font-weight: 600;
    color: #000;
    text-decoration: none;
    font-size: 12.5px;
    margin-left: 15px;
}

.secondary-header .user-menu a:hover {
    color: #555;
}

#nav {
    width: 980px;
    margin: 3px auto 0;
    text-align: center;
}

ul, ol {
    list-style: none;
}

.main-navigation > ul > li {
    display: inline-block;
    vertical-align: top;
}

.main-navigation > ul > li > a {
    display: block;
    position: relative;
    height: 25px;
    /*line-height: 40px;*/
    padding: 0 24px;
    font-size: 14px;
    letter-spacing: 0.1em;
    white-space: nowrap;
    color: #fff;
    font-weight: bold;
}

.main-navigation > ul > li > a:hover {
    color : #DBE3FF;
}

.main-navigation > ul > li > div {
	margin-top: 39px;
    display: none; 
    position: absolute;
    left: 0;
    right: 0;
    text-align: center;
    background-color: #F8F8F8;
}

.main-navigation > ul > li > div > ul {
    display: flex;
    justify-content: center;
    padding: 0;
}

.main-navigation > ul > li > div > ul > li {
    margin: 0 10px;
}


.main-navigation > ul > li > div > ul > li > a {
font-size: 12px !important;
    display: block;
    padding: 0 5px;
    color: #fff;
    font-size: 12px;
}
</style>

<header class="site-header">
    <div class="container">
        <nav class="main-navigation">
            <ul>
                <li><a href="#">멤버십</a></li>
                <li><a href="#">고객센터</a></li>
            </ul>
        </nav>
    </div>
</header>

<header class="secondary-header">
    <div class="container">
        <div class="logo">
            <a href="#"><img src="${pageContext.request.contextPath}/images/cmj/header_logo.png" width="140"></a>
        </div>
        <nav class="main-navigation">
            <ul>
                <li>
                	<a href="#">예매</a>
                	<div class="hide_menu">
                        <ul>
                            <li><a href="#" title="예매하기">예매하기</a></li>
                            <li><a href="#" title="상영시간표">상영시간표</a></li>
                            <li><a href="#" title="할인안내">할인안내</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                	<a href="#">영화</a>
                	<div class="hide_menu">
                        <ul>
                            <li><a href="#" title="홈">홈</a></li>
                            <li><a href="#" title="현재상영작">현재상영작</a></li>
                            <li><a href="#" title="상영예정작">상영예정작</a></li>
                        </ul>
                    </div>	
                </li>
                <li>
                	<a href="#">영화관</a>
                	<div class="hide_menu">
                        <ul>
                            <li class=""><a href="#" title="스페셜관">스페셜관</a></li>
                            <li><a href="#" title="서울">서울</a></li>
                            <li><a href="#" title="경기/인천">경기/인천</a></li>
                            <li><a href="#" title="충청/대전">충청/대전</a></li>
                            <li><a href="#" title="전라/광주">전라/광주</a></li>
                            <li><a href="#" title="경북/대구">경북/대구</a></li>
                            <li><a href="#" title="경남/부산/울산">경남/부산/울산</a></li>
                            <li><a href="#" title="강원">강원</a></li>
                            <li><a href="#" title="제주">제주</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                	<a href="#">이벤트</a>
               		<div class="hide_menu">
                        <ul>
                            <li><a href="#" title="홈">홈</a></li>
                            <li><a href="#" title="영화">영화</a></li>
                            <li><a href="#" title="시사회/무대인사">시사회/무대인사</a></li>
                            <li><a href="#" title="제휴할인">제휴할인</a></li>
                        </ul>
                    </div>
               	</li>
                <li>
                	<a href="#">커뮤니티</a>
                	<div class="hide_menu">
                        <ul>
                            <li><a href="#" title="영화톡톡">영화톡톡</a></li>
                            <li><a href="#" title="양도/교환">양도/교환</a></li>
                        </ul>
                    </div>
                </li>
                <li><a href="#">벌스샵</a></li>
            </ul>
        </nav>
        <div class="user-menu">
        		<c:if test="${!empty user }">
               	<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
                </c:if>
                <c:if test="${empty user}">
				<a href="${pageContext.request.contextPath}/member/login">로그인</a>               
                </c:if>
                
                <c:if test="${!empty user }">
               	<a href="#">마이페이지</a>
                </c:if>
                <c:if test="${empty user}">
				<a href="${pageContext.request.contextPath}/member/register">회원가입</a>               
                </c:if>
        </div>
    </div>
</header>

	<script>
	document.querySelectorAll('.main-navigation > ul > li').forEach(function(menu) {
	    menu.addEventListener('mouseenter', function() {
	        this.querySelector('.hide_menu').style.display = 'block';
	        this.querySelector('.hide_menu').style.opacity = 1;
	    });

	    menu.addEventListener('mouseleave', function() {
	        this.querySelector('.hide_menu').style.display = 'none';
	        this.querySelector('.hide_menu').style.opacity = 0;
	    });
	});

        </script>
