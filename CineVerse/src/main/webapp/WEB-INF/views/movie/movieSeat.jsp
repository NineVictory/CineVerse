<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<div class="select-container">
		<div class="select-wrapper">
			<div class="select-title">인원/좌석 선택</div>				
			<div class="select-seat-container">			
				<!-- 영화 상영 정보 -->
				<div class="select-seat-information">
					<div class="selected-movie"></div>
					<div class="select-seat-information-wrapper">
						<div class="select-theater-place selected-theater-place-info">CINEVERSE</div>
						<div class="select-theater-place selected-theater-place-info">3관</div>
						<div class="select-theater-place">
							<span>남은좌석</span><span class="remain-seats">240</span>/<span class="all-seats">240</span>						
						</div>

					</div>
					<div class="select-theater-date">
						<div class="theater-date"></div>
						<div class="theater-time"></div>
					</div>
					<div class="selected-seats-wrapper">
						<span class="selected-seats-title">좌석번호</span> <span
							class="selected-seats">선택한 좌석이 없습니다.</span>
					</div>					
				</div>
				
				<!-- 인원 수 체크 -->
				<div class="select-seat-number-container">
					<div class="select-seat-number-wrapper">
						<div class="select-seat">
							<div class="select-seat-age">성인</div>
							<div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">청소년</div>
							<div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">경로</div>
							<div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">우대</div>
							<div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 영화 좌석 선택 -->
			<div class="seat-container">
				<div class="seat-wrapper">
					<div class="screen-view-wrapper">
						<span class="title_screen1">SCREEN</span>
					</div>
				</div>
			</div>
			
			<!-- 총합계 및 결제하기 -->
			<div class="ticket-container">
			<div class="ticket-price-wrapper">
						<div class="ticket-price-title">총 합계</div>
						<div class="ticket-price">0원</div>
					</div>
					<form action="" class="seatForm" method="post">
						<input type="hidden" class="title" name="title"> 
						<input type="hidden" class="selectedTheater" name="selectedTheater">
						<input type="hidden" class="reserveDate" name="movieDate">
						<input type="hidden" class="runningTime" name="runningTime">
						<input type="hidden" class="movieAge" name="movieAge"
							value="">
						<!-- 티켓의수(선택한 좌석) -->
						<input type="hidden" class="ticketNumber" name="ticketNumber">
						<input type="hidden" class="selectedSeat" name="selectedSeat">
						<!-- 결제 정보 -->
						<input type="hidden" class="payMoney" name="payMoney">
						<input type="button" class="movePaymentButton" id="link_rpay" value="결제하기" onclick="location.href='moviePayment'">
					</form>
			</div>
		</div>
	</div>