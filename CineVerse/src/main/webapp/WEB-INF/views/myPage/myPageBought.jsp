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
				<!-- 근데 이 부분 css를 똑같이 썼더니 하얀색으로 삐죽... --><!-- 영화사진 비율로 느낌만 낸거라 삐죽/css를 다르게 해야될수도! -->
				<div class="m_movie_photo">
					<img src="${pagecontext.reuqest.contextPath}/images/cje/product.png"
						alt="결제 내역" width="160" height="160" onclick="location.href='/myPage/boughtDetail'">
				</div>
				<div class="mpMovie_info">
					<div class="bought_info"><!-- 20,47,48,49에 사용한 변수는 myPage.css(1086)에 새로 추가했어요 쩝 -->
						<span class="mp_movie_number_1">결제번호</span>
						<span class="mp_movie_number_2">0023-</span> 
						<span class="mp_movie_number_3">0619-3123-229</span>
						<span class="my_delivery_process">상품 준비 중</span>
					</div>
					<div class="mp_movie_title">클래식 티셔츠(아이보리)</div>

					<div class="reservation_list">
						<div class="reserv_info">
							<div>구매일시</div>
							<div>상품금액</div>
							<div>주문수량</div>
						</div>

						<div class="my_reserv_info">
							<div>2024.07.06(토) 26:00</div>
							<div>39,000원</div>
							<div>2개</div>
						</div>
					</div>
					<hr size="1" width="100%" class="reserv_line">
					<div class="reserv_pay_cancle">
						<div>
							<span class="m_pay">총 결제금액 </span><span class="my_blue_font">78,000원</span>
						</div>
						<!-- 버튼들 -->
						<div class="my_bought_btn">
						<span class="my_order_confirm">주문확정</span>
						<span class="my_order_return">교환/반품</span>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>




</div>
<!--  내가 본 영화 끝 -->