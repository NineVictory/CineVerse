<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 나의 예매목록 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">나의 예매 내역</span>
	</div>
	<!-- 반복 -->

	<div class="main_body_reservation">

		<div class="myPageReservation_list" onclick="location.href='/myPage/reservation'">
			<!--  css 수정 예매추가로 하면 박스 늘어나게 -->
			<div class="mp_reserv">
				<div class="m_movie_photo">
					<img src="${pageContext.request.contextPath}/images/pmj/dune.jpg"
						alt="내가 본 영화2" width="150" height="210">
				</div>
				<div class="mpMovie_info">
					<div>
						<span class="mp_movie_number_1">예매번호</span> <span
							class="mp_movie_number_2">0023-</span> <span
							class="mp_movie_number_3">0619-3123-229</span>
					</div>
					<div class="mp_movie_title">듄</div>

					<div class="reservation_list">
						<div class="reserv_info">
							<div>관람극장</div>
							<div>관람일시</div>
							<div>관람좌석</div>
						</div>

						<div class="my_reserv_info">
							<div>CGV 용산아이파크몰</div>
							<div>2024.07.06(토) 26:00</div>
							<div>L 22,L 23</div>
						</div>
					</div>
					<hr size="1" width="100%" class="reserv_line">
					<div class="reserv_pay_cancle">
						<div>
							<span class="m_pay">총 결제금액 </span><span class="my_blue_font">32,000원</span>
						</div>
						<div class="m_cancle">예매취소</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 반복 -->
</div>
<!-- 나의 예매목록 끝 -->