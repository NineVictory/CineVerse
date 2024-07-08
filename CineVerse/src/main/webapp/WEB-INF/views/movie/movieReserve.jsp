<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="reserve-container">
	<!-- 지점명 시작 -->
	<div class="theater-part">
		<div class="reserve-title">지점명</div>
		<div class="theater-container">
			<div class="theater-wrapper">
				<div class="theater-location-wrapper">
					<button class="theater-location">서울</button>
					<button class="theater-location">경기</button>
					<button class="theater-location">인천</button>
					<button class="theater-location">충청</button>
					<button class="theater-location">대전</button>
					<button class="theater-location">전라</button>
					<button class="theater-location">광주</button>
					<button class="theater-location">경북</button>
					<button class="theater-location">대구</button>
					<button class="theater-location">경남</button>
					<button class="theater-location">강원</button>
					<button class="theater-location">제주</button>
				</div>
				<div class="theater-place-wrapper">
					<button class="theater-place">가산디지털</button>
					<button class="theater-place">가양</button>
					<button class="theater-place">강동</button>
					<button class="theater-place">건대입구</button>
					<button class="theater-place">김포공항</button>
					<button class="theater-place">노원</button>
					<button class="theater-place">도곡</button>
					<button class="theater-place">독산</button>
					<button class="theater-place">서울대입구</button>
					<button class="theater-place">수락산</button>
					<button class="theater-place">신대방</button>
					<button class="theater-place">신도림</button>
					<button class="theater-place">신림</button>
					<button class="theater-place">영등포</button>
					<button class="theater-place">용산</button>
					<button class="theater-place">월드타워</button>
					<button class="theater-place">중량</button>
					<button class="theater-place">청량리</button>
					<button class="theater-place">합정</button>
					<button class="theater-place">홍대입구</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 지점명 끝 -->

	<!-- 영화 시작 -->
	<div class="movie-part">
		<div class="reserve-title">영화명</div>
		<div class="movie-list-wrapper"></div>
	</div>
	<!-- 영화 끝 -->

	<!-- 날짜 시작 -->
	<div class="day-part">
		<div class="reserve-title">날짜</div>
		<div class="reserve-date"></div>
	</div>
	<!-- 날짜 끝 -->

	<!-- 시간 시작 -->
	<div class="time-part">
		<div class="reserve-title">시간</div>
		<div class="reserve-time">
			<div class="reserve-where">4관(Laser) 6층(총 240석)</div>
			<div class="reserve-time-wrapper">
				<button class="reserve-time-button">
					<span class="reserve-time-want">18:50</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">19:40</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">20:20</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">21:30</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">22:10</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">23:05</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">00:10</span> 
					<span class="reserve-time-remain">240석</span>
				</button>
			</div>
		</div>

		<div>
			<button class="moveSeatButton" type="button">결제하기</button>
		</div>
	</div>
	<!-- 시간 종료 -->
</div>