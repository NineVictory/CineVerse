<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/location.cinema.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cinema.js"></script>
<header class="secondary-location-header">
<div class="own-movie-title">자체영화관</div>
    <div class="container-location">
        <div class="responsive-image">
            <a href="${pageContext.request.contextPath}/main/main"><img src="${pageContext.request.contextPath}/images/ksh/movieshow.png"></a>
            <nav class="main-location-navigation">
                <ul class="secondary-location-ul">
                    <!-- 서울 -->
                    <li class="secondary-location-li" id="seoul-location">
                        <a href="#" class="secondary-location-a" data-num="1">서울</a>
                        <div class="hide_location_menu">
		                    <ul class="hide_location_menu_ul" id="branch"></ul>
		                </div> 
                    </li>
                    <!-- 경기 -->
                    <li class="secondary-location-li" id="gyeonggi-location">
                        <a href="#" class="secondary-location-a" data-num="2">경기</a>                    
                    </li>

                    <!-- 강원 -->
                    <li class="secondary-location-li" id="gangwon-location">
                        <a href="#" class="secondary-location-a" data-num="3">인천</a>          
                    </li>
                    <!-- 대전/충청 -->
                    <li class="secondary-location-li" id="chungcheong-location">
                        <a href="#" class="secondary-location-a" data-num="4">강원</a>                 
                    </li>
                    <!-- 경상 -->
                    <li class="secondary-location-li" id="gyeongnam-location">
                        <a href="#" class="secondary-location-a" data-num="5">대전/충청</a>                     
                    </li>
                    <!-- 광주/전라 -->
                    <li class="secondary-location-li" id="jeolla-location">
                        <a href="#" class="secondary-location-a" data-num="6">경상</a>			
                    </li>
                    <li class="secondary-location-li" id="jeolla-location">
                        <a href="#" class="secondary-location-a" data-num="7">광주/전라</a>			
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
