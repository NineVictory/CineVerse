<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="reserve-container">
	<!-- 지점명 시작 -->
	<div class="theater-part">
		<div class="reserve-title">지점명</div>
		<div class="theater-container">
			<div class="theater-wrapper">
				<ul class="theater-location-wrapper">
					<li class="depth1" id="depth1"><a href="#none">서울<em>(10)</em></a>
						<div class="depth2" id="depth2">
							<div>
								<div>
									<div>
										<ul>
											<li class=""><a href="#none">가산디지털</a></li>
											<li class=""><a href="#none">가양</a></li>
											<li class=""><a href="#none">강동</a></li>
											<li class=""><a href="#none">건대입구</a></li>
											<li class=""><a href="#none">김포공항</a></li>
											<li class=""><a href="#none">노원</a></li>
											<li class=""><a href="#none">도곡</a></li>
											<li class=""><a href="#none">독산</a></li>
											<li class=""><a href="#none">서울대입구</a></li>
											<li class=""><a href="#none">수락산</a></li> 
										</ul>
									</div>
								</div>
							</div>
						</div> 
					</li>
					<li class="depth1" id="depth1"><a href="#none">경기/인천<em>(10)</em></a>
						<div class="depth2" id="depth2">
							<div>
								<div>
									<div>
										<ul>
											<li class=""><a href="#none">광교아울렛</a></li>
											<li class=""><a href="#none">광교아울렛</a></li>
											<li class=""><a href="#none">광명(광명사거리)</a></li>
											<li class=""><a href="#none">광명아울렛</a></li>
											<li class=""><a href="#none">구리아울렛</a></li>
											<li class=""><a href="#none">동탄</a></li>
											<li class=""><a href="#none">라페스타</a></li>
											<li class=""><a href="#none">마석</a></li>
											<li class=""><a href="#none">별내</a></li>
											<li class=""><a href="#none">병점</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</li>
					
					
				</ul>			
			</div>
		</div>
	</div>
	<script>
	 $('.depth1 > a').click(function(){
         let depth2 = $(this).next('.depth2');
         if (depth2.css('display') === "none") {
             depth2.css('display', 'block');
         } else {
             depth2.css('display', 'none');
         }
     });
	</script>
	<!-- 지점명 끝 -->

	<!-- 영화 시작 -->
	<div class="movie-part">
		<div class="reserve-title">영화명</div>
		<div class="movie-list-wrapper">
			<ul>
				<li class=""><a href="#none">인사이드아웃2</a></li>
				<li class=""><a href="#none">파일럿</a></li>
				<li class=""><a href="#none">탈출</a></li>
				<li class=""><a href="#none">콰이어트 플레이스</a></li>
				<li class=""><a href="#none">존 오브 인터레스트</a></li>
				<li class=""><a href="#none">귀멸의 칼날</a></li>
			</ul>
		</div>
	</div>
	<!-- 영화 끝 -->


	<!-- 날짜 및 시간 시작 -->
	<div class="time-part">
		<div class="reserve-title">날짜 및 시간</div>
		<div class="reserve-time">
			<div class="reserve-where">날짜</div>
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
	<!-- 날짜 및 시간 종료 -->
</div>