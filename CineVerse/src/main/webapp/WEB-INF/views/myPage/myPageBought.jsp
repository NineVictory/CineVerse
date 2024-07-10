<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  굿즈 내역 시작 -->
<div class="myPage_main">

	<div class="main_body_reservation">
		<div class="my_reserv_info">
			<span class="reserv_font">나의 굿즈 결제 내역</span><span class="main_count">1건</span>
		</div>

		<div class="myPageReservation_list">
			<!--  css 수정 예매추가로 하면 박스 늘어나게 -->
			<div class="mp_reserv">
				<div class="m_movie_photo">
					<img src="${pagecontext.reuqest.contextPath }/images/pmj/dune.jpg"
						alt="굿즈 내역" width="150" height="210" onclick="location.href='/myPage/boughtDetail'">
				</div>
				<div class="mpMovie_info">
					<div>
						<span class="mp_movie_number_1">결제번호</span><span
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




</div>
<!--  내가 본 영화 끝 -->