<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header_all.css" type="text/css">
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
            <a href="${pageContext.request.contextPath}/main/main"><img src="${pageContext.request.contextPath}/images/cmj/header_logo.png" width="140"></a>
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
                            <li><a href="${pageContext.request.contextPath}/movie/movieList" title="홈">홈</a></li>
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
                	<a href="${pageContext.request.contextPath}/board/list">커뮤니티</a>
                	<div class="hide_menu">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/board/list?cb_type=movieTalk" title="영화톡톡">영화톡톡</a></li>
                            <li><a href="#" title="양도/교환">양도/교환</a></li>
                        </ul>
                    </div>
                </li>
                <li><a href="${pageContext.request.contextPath}/shop/shopMain">벌스샵</a></li>
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
               	<a href="${pageContext.request.contextPath}/myPage/myPageMain">마이페이지</a>
                </c:if>
                <c:if test="${empty user}">
				<a href="${pageContext.request.contextPath}/member/register">회원가입</a>               
                </c:if>
        </div>
    </div>
</header>

<script>
document.querySelectorAll('.main-navigation > ul > li').forEach(function(menu) {
    let timeoutId;

    menu.addEventListener('mouseenter', function() {
        clearTimeout(timeoutId); // 마우스를 올리면 기존 타임아웃 제거
        const submenu = this.querySelector('.hide_menu');
        if (submenu) {
            submenu.style.display = 'block';
            submenu.style.opacity = 1;
        }
    });

    menu.addEventListener('mouseleave', function() {
        const submenu = this.querySelector('.hide_menu');
        if (submenu) {
            timeoutId = setTimeout(() => {
                submenu.style.display = 'none';
                submenu.style.opacity = 0;
            }, 200); // 200ms 후에 메뉴가 사라지도록 딜레이 설정
        }
    });

    const submenu = menu.querySelector('.hide_menu');
    if (submenu) {
        submenu.addEventListener('mouseenter', function() {
            clearTimeout(timeoutId); // 하위 메뉴에 마우스가 올라갔을 때 타이머 취소
        });

        submenu.addEventListener('mouseleave', function() {
            timeoutId = setTimeout(() => {
                submenu.style.display = 'none';
                submenu.style.opacity = 0;
            }, 200); // 하위 메뉴를 떠났을 때 200ms 후에 사라지도록 딜레이 설정
        });
    }
});
</script>

