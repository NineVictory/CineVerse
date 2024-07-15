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
	<c:if test="${!empty orderDetail}">
	
	<c:forEach var="od" items="${orderDetail}">
	<div class="reservation_rep">
		<div class="re_movie_number">
			<span class="mp_movie_number_1">결제 번호</span> <span
				class="mp_movie_number_3">${order.od_number}</span>
		</div>
		<div class="reserv_display">
		<!-- 여기도 검은색삐죽... -->
			<div class="wa_photo" style="background:none;">
					<img src="${pagecontext.reuqest.contextPath}/upload/${od.p_filename}"
						alt="결제 내역" width="160" height="160" onclick="location.href=''">
			</div>
			<div class="reservation_info">
				<div class="reservation_movie_name">
					${od.p_name}
				</div>
				<div class="reservation_infomation">
					<div class="my_reserv_info_1">
						<div>구매일시</div>
						<div>상품금액</div>
						<div>주문수량</div>
					</div>
					<div class="my_reserv_info_2">
						<div>${od.order_date }</div>
						<div>${od.p_price }원</div>
						<div>${od.order_quantity}개</div>
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
						<span class="m_pay">총 결제금액 </span><span class="my_blue_font">${od.p_price*od.order_quantity}원</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
</c:if>
	<div class="payment_receipt">결제 내역</div>
	<div class="pay_receipt_box">
		<div class="pay_receipt">
			<div class="reservation_pay">총 결제금액</div>
			<div class="reservation_pay_blue_font">
				<c:if test="${order_price<50000}">
					${order_price+3000}원
				</c:if>
				<c:if test="${order_price>=50000}">
					${order_price}원
				</c:if>
			</div>
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
