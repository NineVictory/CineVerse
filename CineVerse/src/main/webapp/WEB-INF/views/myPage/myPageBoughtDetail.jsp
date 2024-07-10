<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 굿즈 결제 내역 상세 시작 -->
<div class="myPage_main">

	<div class="reservation_display">
		<span class="myPage_title_re">결제 내역</span>
		<span class="watched_movie">내가 산 굿즈</span>
	</div>
	<hr size="1" width="100%" class="wa_line">

	<div class="reservation_rep">
		<div class="re_movie_number">
			<span class="mp_movie_number_1">결제 번호</span><span
				class="mp_movie_number_2">0023-</span> <span
				class="mp_movie_number_3">0619-3123-229</span>
		</div>
		<div class="reserv_display">
		<!-- 여기도 검은색삐죽... -->
			<div class="wa_photo">
				<img src="${pagecontext.reuqest.contextPath }/images/cje/product.png"
					alt="상품" width="160" height="160">
			</div>
			<div class="reservation_info">
				<div class="reservation_movie_name">
					클래식 티셔츠(아이보리)
				</div>
				<div class="reservation_infomation">
					<div class="my_reserv_info_1">
						<div>구매일시</div>
						<div>상품금액</div>
						<div>주문수량</div>
					</div>
					<div class="my_reserv_info_2">
						<div>2024.07.06(토) 26:00</div>
						<div>39,000원</div>
						<div>2개</div>
					</div>
					<div class="my_reserv_info_3">
						<div></div>
						<div></div>
						<div></div>
					</div>
					<div class="my_reserv_info_4">
						<div></div>
						<div></div>
						<div></div>
					</div>

				</div>
				<hr size="1" width="100%" class="wa_line">
				<div class="reserv_pay_cancle">
					<div>
						<span class="m_pay">총 결제금액 </span><span class="my_blue_font">78,000원</span>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="payment_receipt">결제 내역</div>
	<div class="pay_receipt_box">
		<div class="pay_receipt">
			<div class="reservation_pay">총 결제금액</div>
			<div class="reservation_pay_blue_font">78,000원</div>
		</div>
		<hr size="1" width="100%" class="wa_line">



		<div class="payment_way">
			<div class="pay_way">
				<div class="pay_point">포인트 결제</div>
				<div class="pay_coupon">쿠폰 결제</div>
			</div>
			<div class="pay_way_count">
				<div class="point_count">78,000원</div>
				<div class="coupon_count">0원</div>
			</div>
		</div>
	</div>


	<div></div>
	<div></div>

</div>
<!-- 굿즈 결제 내역 상세 끝-->
