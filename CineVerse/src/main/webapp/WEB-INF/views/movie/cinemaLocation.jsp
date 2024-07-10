<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/location.cinema.css" type="text/css">

<header class="secondary-location-header">
<div class="own-movie-title">자체영화관</div>
    <div class="container-location">
        <div class="responsive-image">
            <a href="${pageContext.request.contextPath}/main/main"><img src="${pageContext.request.contextPath}/images/ksh/movieshow.png"></a>
            <nav class="main-location-navigation">
                <ul class="secondary-location-ul">
                    <!-- 서울 -->
                    <li class="secondary-location-li">
                        <a href="#" class="secondary-location-a">서울</a>
                        <div class="hide_location_menu">
                            <ul class="hide_location_menu_ul">
                                <li class="hide_location_menu_li"><a href="#" title="강남" class="location-hide-menu-a">강남</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="강북" class="location-hide-menu-a">강북</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="동서울" class="location-hide-menu-a">동서울</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="잠실" class="location-hide-menu-a">잠실</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="마곡" class="location-hide-menu-a">마곡</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="목동" class="location-hide-menu-a">목동</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="신사" class="location-hide-menu-a">신사</a></li>    
                                <li class="hide_location_menu_li"><a href="#" title="상봉" class="location-hide-menu-a">상봉</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="상암월드컵경기장 " class="location-hide-menu-a">상암월드컵경기장</a></li>
                            </ul>
                            <ul class="hide_location_menu_ul"> 
                                <li class="hide_location_menu_li"><a href="#" title="센트럴" class="location-hide-menu-a">센트럴</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="송파파크하비오" class="location-hide-menu-a">송파파크하비오</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="신촌" class="location-hide-menu-a">신촌</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="이수" class="location-hide-menu-a">이수</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="창동" class="location-hide-menu-a">창동</a></li>
                            </ul>
                        </div>
                    </li>
                    <!-- 경기 -->
                    <li class="secondary-location-li">
                        <a href="#" class="secondary-location-a">경기</a>
                        <div class="hide_location_menu">
                            <ul class="hide_location_menu_ul">
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="광교아울렛">광교아울렛</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="광명아울렛" class="location-hide-menu-a">광명아울렛</a></li>
                                <li class="hide_location_menu_li"><a href="#" title="광주터미널" class="location-hide-menu-a">광주터미널</a></li>
                            </ul>
                        </div>    
                    </li>
					<!-- 인천 -->
					<li class="secondary-location-li">
					    <a href="#" class="secondary-location-a">인천</a>
					    <div class="hide_location_menu">
					        <ul class="hide_location_menu_ul">
					            <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="스페셜관">부천역</a></li>
					            <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="스페셜관">부평</a></li>
					            <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="스페셜관">부평역사</a></li>
					        </ul>
					    </div>
					</li>

                    <!-- 강원 -->
                    <li class="secondary-location-li">
                        <a href="#" class="secondary-location-a">강원</a>
                        <div class="hide_location_menu">
                            <ul class="hide_location_menu_ul">
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="남원주">홈</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="영화">영화</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="시사회/무대인사">시사회/무대인사</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="제휴할인">제휴할인</a></li>
                            </ul>
                        </div>
                    </li>
                    <!-- 대전/충청 -->
                    <li class="secondary-location-li">
                        <a href="${pageContext.request.contextPath}/board/list" class="secondary-location-a">대전/충청</a>
                        <div class="hide_location_menu">
                            <ul class="hide_location_menu_ul">
                                <li class="hide_location_menu_li"><a class="location-hide-menu-a" href="#" title="당진">당진</a></li>
                                <li class="hide_location_menu_li"><a class="location-hide-menu-a" href="#" title="대전(백화점)">대전(백화점)</a></li>
                            </ul>
                        </div>
                    </li>
                    <!-- 경상 -->
                    <li class="secondary-location-li">
                        <a href="#" class="secondary-location-a">경상</a>
                        <div class="hide_location_menu">
                            <ul class="hide_location_menu_ul">
                                 <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="홈">남원주</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="동해">동해</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="원주무실">원주무실</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="춘천">춘천</a></li>                            </ul>
                        </div>
                    </li>
                    <!-- 광주/전라/제주 -->
                    <li class="secondary-location-li">
                        <a href="#" class="secondary-location-a">광주/전라</a>
						<div class="hide_location_menu">
                            <ul class="hide_location_menu_ul">
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="광주(백화점)">광주(백화점)</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="광주광산">광주광산</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="전주(백화점)">전주(백화점)</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="전주송천">전주송천</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<script>
document.querySelectorAll('.main-location-navigation > ul > li').forEach(function(menu) {
    let timeoutId;

    menu.addEventListener('mouseenter', function() {
        clearTimeout(timeoutId); // 마우스를 올리면 기존 타임아웃 제거
        const submenu = this.querySelector('.hide_location_menu');
        if (submenu) {
            submenu.style.display = 'block';
            submenu.style.opacity = 1;
            
        }
    });

    menu.addEventListener('mouseleave', function() {
        const submenu = this.querySelector('.hide_location_menu');
        if (submenu) {
            timeoutId = setTimeout(() => {
                submenu.style.display = 'none';
                submenu.style.opacity = 0;
            }); // 딜레이 더 길게 잡음
        }
    });

    const submenu = menu.querySelector('.hide_location_menu');
    if (submenu) {
        submenu.addEventListener('mouseenter', function() {
            clearTimeout(timeoutId); // 하위 메뉴에 마우스가 올라갔을 때 타이머 초기화 하여 유지 되게 설정
        });

        submenu.addEventListener('mouseleave', function() {
            timeoutId = setTimeout(() => {
                submenu.style.display = 'none';
                submenu.style.opacity = 0;
            }, 250); // 하위 메뉴를 떠났을 때 250ms 후에 사라지도록 딜레이 설정
        });
    }
});
</script>