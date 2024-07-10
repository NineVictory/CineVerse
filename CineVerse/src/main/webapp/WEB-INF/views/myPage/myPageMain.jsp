<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 마이페이지 시작 -->
<div class="myPage_main">
	<div class="myPage_active">
		<div class="m_except" onclick="location.href='/myPage/expectingMovie'">
			<!-- 아이콘 이미지 -->
			<div class="test_icon">아이콘</div>
			<div class="myPageMain_font_b">기대되는 영화</div>
			<div class="myPageMain_font_s">보고싶은 영화들을 미리 담아놓고 싶다면?</div>
		</div>
		<div class="m_watching" onclick="location.href='/myPage/watchedMovie'">
			<!-- 아이콘 이미지 -->
			<div class="test_icon">아이콘</div>
			<div class="myPageMain_font_b">내가 본 영화</div>
			<div class="myPageMain_font_s">관람한 영화들을 한번에 모아 보고 싶다면?</div>
		</div>
		<div class="m_review" onclick="location.href='/myPage/#'"><!-- 내가 쓴 평점 링크 추가 -->
			<!-- 아이콘 이미지 -->
			<div class="test_icon">아이콘</div>
			<div class="myPageMain_font_b">내가 쓴 평점</div>
			<div class="myPageMain_font_s">관람 후 내 감상평을 적어 추억하고 싶다면?</div>
		</div>
	</div>

	<div class="main_body_reservation">
		<div class="my_reserv_info">
			<span class="reserv_font">MY 예매내역</span><span class="main_count">0건</span>
		</div>

		<div class="myPageReservation_list">
			<!--  css 수정 예매추가로 하면 박스 늘어나게 -->
			<div class="mp_reserv">
				<div class="m_movie_photo">
					<img src="${pagecontext.reuqest.contextPath }/images/pmj/dune.jpg"
						alt="내가 본 영화2" width="150" height="210">
				</div>
				<div class="mpMovie_info">
					<div>
						<span class="mp_movie_number_1">예매번호</span>
						<span class="mp_movie_number_2">0023-</span> 
						<span class="mp_movie_number_3">0619-3123-229</span>
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

	<div class="qna_box">
		<div class="my_reserv_info">
			<span class="reserv_font">MY QnA</span><span class="main_count">0건</span>
		</div>

		<div class="qna">
			<div class="mpQna">고객님의 1:1 문의내역이 존재하지 않습니다</div>
			<!-- css box늘어나게 -->
		</div>
	</div>
</div>
<!-- 마이페이지 끝-->