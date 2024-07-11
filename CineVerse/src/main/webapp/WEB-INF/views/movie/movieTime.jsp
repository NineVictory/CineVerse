<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="reserve-container">
	<!-- 영화 -->
	<div class="movie-part">
		<div class="reserve-title">영화</div>
		<div class="sort-wrapper">
			<div class="sort-rate sort-selected">예매율순</div>
			<div class="sort-korean">가나다순</div>	
		</div>
		<div class="movie-list-wrapper">
			<div class="movie-list">
				<ul class="movie-select">
					<li class="select"><a href="#none"><span class="ic_grade gr_all">전체</span>인사이드아웃 2</a></li>
					<li class="select"><a href="#none"><span class="ic_grade gr_12">12세</span>파일럿</a></li>
					<li class="select"><a href="#none"><span class="ic_grade gr_15">15세</span>탈출</a></li>
					<li class="select"><a href="#none"><span class="ic_grade gr_15">15세</span>콰이어트 플레이스</a></li>
					<li class="select"><a href="#none"><span class="ic_grade gr_12">12세</span>존 오브 인터레스트</a></li>
					<li class="select"><a href="#none"><span class="ic_grade gr_15">15세</span>귀멸의 칼날</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 날짜 및 시간 -->
	<div class="time-part">
		<div class="reserve-title">날짜 및 시간</div>
		<div class="reserve-time">
			<div class="reserve-month">7월			
				<ul class="reserve-date">								
					<li class="date"><a href="#">10<br>수</a></li>
					<li class="date"><a href="#">11<br>목</a></li>
					<li class="date"><a href="#">12<br>금</a></li>
					<li class="date saturday"><a href="#">13<br>토</a></li>
					<li class="date sunday"><a href="#">14<br>일</a></li>
					<li class="date"><a href="#">15<br>월</a></li>
					<li class="date"><a href="#">16<br>화</a></li>
					<li class="date"><a href="#">17<br>수</a></li>
					<li class="date"><a href="#">18<br>목</a></li>
					<li class="date"><a href="#">19<br>금</a></li>
					<li class="date saturday"><a href="#">20<br>토</a></li>
					<li class="date sunday"><a href="#">21<br>일</a></li>
					<li class="date"><a href="#">22<br>월</a></li>
					<li class="date"><a href="#">23<br>화</a></li>
					<li class="date"><a href="#">24<br>수</a></li>
					<li class="date"><a href="#">25<br>목</a></li>
					<li class="date"><a href="#">26<br>금</a></li>
					<li class="date saturday"><a href="#">27<br>토</a></li>
					<li class="date sunday"><a href="#">28<br>일</a></li>
					<li class="date"><a href="#">29<br>월</a></li>
					<li class="date"><a href="#">30<br>화</a></li>
					<li class="date"><a href="#">31<br>수</a></li>
				</ul>
			</div>
			<div class="reserve-time-wrapper">
				<button class="reserve-time-button">
					<span class="reserve-time-want">18:50</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">1관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">19:40</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">2관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">20:20</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">3관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">21:30</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">4관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">22:10</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">5관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">23:05</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">6관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">00:10</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">7관</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">01:30</span> 
					<span class="reserve-time-remain">240/240</span><br>
					<span class="reserve-time-place">8관</span>
				</button>
			</div>
		</div>

		<div class="seat-select-button">
			<input type="button" class="moveSeatButton" value="좌석 선택" onclick="location.href='movieSeat'">
		</div>
	</div>

</div>