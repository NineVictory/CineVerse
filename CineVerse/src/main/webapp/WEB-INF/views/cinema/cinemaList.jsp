<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/location.cinema.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cinema.location.js"></script>
<header class="secondary-location-header">
<div class="own-movie-title">자체영화관</div>
    <div class="container-location">
        <div class="responsive-image">
            <a href="${pageContext.request.contextPath}/main/main"><img src="${pageContext.request.contextPath}/images/ksh/movieshow.png"></a>
            <nav class="main-location-navigation">
                <ul class="secondary-location-ul">
                    <!-- 서울 -->
                    <li class="secondary-location-li" id="seoul-location">
                        <a href="#" class="secondary-location-a">서울</a>
                        <div class="hide_location_menu" id="seoul">
                            <ul class="hide_location_menu_ul">
                               <c:forEach var="cinema" items="${list}">
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a">${cinema.c_branch}</a></li>
                           		</c:forEach>
                            </ul>
                            
                        </div>
                    </li>
                    <!-- 경기 -->
                    <li class="secondary-location-li" id="gyeonggi-location">
                        <a href="#" class="secondary-location-a">경기</a>
                        <div class="hide_location_menu" id="gyeonggi">
                            <ul class="hide_location_menu_ul">
                                <c:forEach var="cinema" items="${list}">
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a">${cinema.c_branch}</a></li>
                           		</c:forEach>
                            </ul>
                        </div>    
                    </li>

                    <!-- 강원 -->
                    <li class="secondary-location-li" id="gangwon-location">
                        <a href="#" class="secondary-location-a">강원</a>
                        <div class="hide_location_menu" id="gangwon">
                            <ul class="hide_location_menu_ul">
                                <c:forEach var="cinema" items="${list}">
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a">${cinema.c_branch}</a></li>
                           		</c:forEach>
                            </ul>
                        </div>
                    </li>
                    <!-- 대전/충청 -->
                    <li class="secondary-location-li" id="chungcheong-location">
                        <a href="#" class="secondary-location-a">대전/충청</a>
                        <div class="hide_location_menu" id="chungcheong">
                            <ul class="hide_location_menu_ul">
                                <li class="hide_location_menu_li"><a class="location-hide-menu-a" href="#" title="당진">당진</a></li>
                                <li class="hide_location_menu_li"><a class="location-hide-menu-a" href="#" title="대전(백화점)">대전(백화점)</a></li>
                            </ul>
                        </div>
                    </li>
                    <!-- 경상 -->
                    <li class="secondary-location-li" id="gyeongnam-location">
                        <a href="#" class="secondary-location-a">경상</a>
                        <div class="hide_location_menu" id="gyeongnam">
                            <ul class="hide_location_menu_ul">
                                 <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="홈">남원주</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="동해">동해</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="원주무실">원주무실</a></li>
                                <li class="hide_location_menu_li"><a href="#" class="location-hide-menu-a" title="춘천">춘천</a></li>                            </ul>
                        </div>
                    </li>
                    <!-- 광주/전라 -->
                    <li class="secondary-location-li" id="jeolla-location">
                        <a href="#" class="secondary-location-a">광주/전라</a>
						<div class="hide_location_menu" id="jeolla">
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
    <script>
	$(document).ready(function(){
	    // 화면 첫 진입할 때 서울 지점명?들 호출하기
	    $('#seoul-location').addClass('secondary-location-li-active');
	    $('#seoul').show();
	    
	    // 지점들 클릭할 때마다 class 추가해서 새로운 css 적용해주기
	    $('.secondary-location-li > a').click(function(){
	        $('.hide_location_menu').hide();
	        $('.secondary-location-li').removeClass('secondary-location-li-active');
	        $(this).next('.hide_location_menu').toggle();
	        $(this).parent().toggleClass('secondary-location-li-active');
	    });
	});
 </script>
</header>
