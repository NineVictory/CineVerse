<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 굿즈 결제 내역 상세 시작 -->
<div class="myPage_main">

	<div class="reservation_display">
		<span class="myPage_title_re">예매내역</span>
		<span class="watched_movie">내가 본 영화</span>
	</div>
	<hr size="1" width="100%" class="wa_line">

	<div class="reservation_rep">
		<div class="re_movie_number">
			<span class="mp_movie_number_1">예매번호</span><span
				class="mp_movie_number_2">0023-</span> <span
				class="mp_movie_number_3">0619-3123-229</span>
		</div>
		<div class="reserv_display">
			<div class="wa_photo">
				<img src="${pagecontext.reuqest.contextPath }/images/pmj/dune.jpg"
					alt="내가 본 영화2" width="150" height="210">
			</div>
			<div class="reservation_info">
				<div class="reservation_movie_name">
					듄<span>(IMAX)</span>
				</div>
				<div class="reservation_infomation">
					<div class="my_reserv_info_1">
						<div>관람극장</div>
						<div>관람일시</div>
						<div>상영관</div>
					</div>
					<div class="my_reserv_info_2">
						<div>CGV 용산아이파크몰</div>
						<div>2024.07.06(토) 26:00</div>
						<div>IMAX</div>
					</div>
					<div class="my_reserv_info_3">
						<div>관람인원</div>
						<div>관람좌석</div>
						<div>매수</div>
					</div>
					<div class="my_reserv_info_4">
						<div>일반 2</div>
						<div>L 22,L 23</div>
						<div>2매</div>
					</div>

				</div>
				<hr size="1" width="100%" class="wa_line">
				<div class="reserv_pay_cancle">
					<div>
						<span class="m_pay">총 결제금액 </span><span class="my_blue_font">32,000원</span>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="payment_receipt">결제내역</div>
	<div class="pay_receipt_box">
		<div class="pay_receipt">
			<div class="reservation_pay">총 결제금액</div>
			<div class="reservation_pay_blue_font">32000원</div>
		</div>
		<hr size="1" width="100%" class="wa_line">



		<div class="payment_way">
			<div class="pay_way">
				<div class="pay_point">포인트 결제</div>
				<div class="pay_coupon">쿠폰 결제</div>
			</div>
			<div class="pay_way_count">
				<div class="point_count">16000원</div>
				<div class="coupon_count">16000원</div>
			</div>
		</div>
	</div>
	<div class="m_cancle">예매취소</div>


	<div></div>
	<div></div>

</div>
<!-- 굿즈 결제 내역 상세 끝-->
