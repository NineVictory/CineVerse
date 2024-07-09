<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="reserve-container">
	<!-- 지점명 -->
	<div class="theater-part">
		<div class="reserve-title">지점명</div>
		<div class="theater-container">
			<div class="theater-wrapper">
				<ul class="theater-location-wrapper">
					<li class="theater-location" id="seoul-location"><a
						href="#none">서울(10)</a>
						<div class="location" id="seoul" style="display: none;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">가산디지털</a></li>
								<li class="theater-place"><a href="#none">가양</a></li>
								<li class="theater-place"><a href="#none">강동</a></li>
								<li class="theater-place"><a href="#none">건대입구</a></li>
								<li class="theater-place"><a href="#none">김포공항</a></li>
								<li class="theater-place"><a href="#none">노원</a></li>
								<li class="theater-place"><a href="#none">도곡</a></li>
								<li class="theater-place"><a href="#none">독산</a></li>
								<li class="theater-place"><a href="#none">서울대입구</a></li>
								<li class="theater-place"><a href="#none">수락산</a></li>
							</ul>
						</div></li>
					<li class="theater-location" id="gyeonggi-location"><a
						href="#none">경기/인천(10)</a>
						<div class="location" id="gyeonggi" style="display: none; top: -50px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">광교</a></li>							
								<li class="theater-place"><a href="#none">광명</a></li>
								<li class="theater-place"><a href="#none">인덕원</a></li>
								<li class="theater-place"><a href="#none">구리</a></li>
								<li class="theater-place"><a href="#none">동탄</a></li>
								<li class="theater-place"><a href="#none">라페스타</a></li>
								<li class="theater-place"><a href="#none">마석</a></li>
								<li class="theater-place"><a href="#none">별내</a></li>
								<li class="theater-place"><a href="#none">병점</a></li>
								<li class="theater-place"><a href="#none">평촌(범계)</a></li>
							</ul>
						</div></li> 
					<li class="theater-location" id="chungcheong-location"><a
						href="#none">충청/대전(8)</a>
						<div class="location" id="chungcheong" style="display: none; top: -100px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">당진</a></li>
								<li class="theater-place"><a href="#none">대전</a></li>
								<li class="theater-place"><a href="#none">서산</a></li>
								<li class="theater-place"><a href="#none">서청주</a></li>
								<li class="theater-place"><a href="#none">아산터미널</a></li>
								<li class="theater-place"><a href="#none">천안</a></li>
								<li class="theater-place"><a href="#none">청주용암</a></li>
								<li class="theater-place"><a href="#none">충주</a></li>
							</ul>
						</div></li>
					<li class="theater-location" id="jeolla-location"><a
						href="#none">전라/광주(4)</a>
						<div class="location" id="jeolla" style="display: none; top: -151px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">광주</a></li>				
								<li class="theater-place"><a href="#none">군산</a></li>
								<li class="theater-place"><a href="#none">익산</a></li>
								<li class="theater-place"><a href="#none">전주</a></li>
							</ul>
						</div></li>
					<li class="theater-location" id="gyeongbuk-location"><a
						href="#none">경북/대구(8)</a>
						<div class="location" id="gyeongbuk" style="display: none; top:-201px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">경주</a></li>
								<li class="theater-place"><a href="#none">구미</a></li>
								<li class="theater-place"><a href="#none">대구</a></li>
								<li class="theater-place"><a href="#none">상인</a></li>
								<li class="theater-place"><a href="#none">동성로</a></li>
								<li class="theater-place"><a href="#none">상주</a></li>
								<li class="theater-place"><a href="#none">포항</a></li>
								<li class="theater-place"><a href="#none">영주</a></li>
							</ul>
						</div></li>
						<li class="theater-location" id="gyeongnam-location"><a
						href="#none">경남/부산/울산(10)</a>
						<div class="location" id="gyeongnam" style="display: none; top: -251px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">거창</a></li>
								<li class="theater-place"><a href="#none">마산</a></li>
								<li class="theater-place"><a href="#none">김해</a></li>
								<li class="theater-place"><a href="#none">부산</a></li>
								<li class="theater-place"><a href="#none">사천</a></li>
								<li class="theater-place"><a href="#none">광복</a></li>
								<li class="theater-place"><a href="#none">서면</a></li>
								<li class="theater-place"><a href="#none">울산</a></li>
								<li class="theater-place"><a href="#none">창원</a></li>
								<li class="theater-place"><a href="#none">통영</a></li>
							</ul>
						</div></li>
						<li class="theater-location" id="gangwon-location"><a
						href="#none">강원(5)</a>
						<div class="location" id="gangwon" style="display: none; top: -301px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">원주</a></li>
								<li class="theater-place"><a href="#none">동해</a></li>
								<li class="theater-place"><a href="#none">춘천</a></li>
								<li class="theater-place"><a href="#none">철원</a></li>
								<li class="theater-place"><a href="#none">강릉</a></li>
							</ul>
						</div></li>
						<li class="theater-location" id="jeju-location"><a
						href="#none">제주(2)</a>
						<div class="location" id="jeju" style="display: none; top: -351px;">
							<ul class="theater-place-wrapper">
								<li class="theater-place"><a href="#none">서귀포</a></li>
								<li class="theater-place"><a href="#none">제주</a></li>
							</ul>
						</div></li>
				</ul>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function(){
	    // 화면 첫 진입할 때 서울 지점명?들 호출하기
	    $('#seoul-location').addClass('theater-location-active');
	    $('#seoul').show();
	    
	    // 지점들 클릭할 때마다 class 추가해서 새로운 css 적용해주기
	    $('.theater-location > a').click(function(){
	        $('.location').hide();
	        $('.theater-location').removeClass('theater-location-active');
	        $(this).next('.location').toggle();
	        $(this).parent().toggleClass('theater-location-active');
	    });
	});

 </script>
 
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
					<li class="select"><a href="#none">인사이드아웃2</a></li>
					<li class="select"><a href="#none">파일럿</a></li>
					<li class="select"><a href="#none">탈출</a></li>
					<li class="select"><a href="#none">콰이어트 플레이스</a></li>
					<li class="select"><a href="#none">존 오브 인터레스트</a></li>
					<li class="select"><a href="#none">귀멸의 칼날</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 날짜 및 시간 -->
	<div class="time-part">
		<div class="reserve-title">날짜 및 시간</div>
		<div class="reserve-time">
			<div class="reserve-where">날짜</div>
			<div class="reserve-time-wrapper">
				<button class="reserve-time-button">
					<span class="reserve-time-want">18:50</span> <span
						class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">19:40</span> <span
						class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">20:20</span> <span
						class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">21:30</span> <span
						class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">22:10</span> <span
						class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">23:05</span> <span
						class="reserve-time-remain">240석</span>
				</button>
				<button class="reserve-time-button">
					<span class="reserve-time-want">00:10</span> <span
						class="reserve-time-remain">240석</span>
				</button>
			</div>
		</div>

		<div>
			<input type="button" class="moveSeatButton" value="좌석 선택" onclick="location=''">
		</div>
	</div>

</div>