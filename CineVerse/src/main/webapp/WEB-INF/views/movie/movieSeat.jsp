<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags"%>
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
						<span class="selected-seats-title">좌석번호</span> <span class="selected-seats">선택한 좌석이 없습니다.</span>
					</div>					
				</div>
				
				<!-- 인원 수 체크 -->
				<div class="select-seat-number-container">
					<div class="select-seat-number-wrapper">
						<div class="select-seat">
							<div class="select-seat-age">성인</div>
							<div class="quantity-controls">
	                            <button type="button" class="quantity-down" data-type="adult">-</button>
	                            <input type="number" min="0" value="0" max="4" readonly class="quantity-input" data-type="adult"/>
	                            <button type="button" class="quantity-up" data-type="adult">+</button>
	                        </div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">청소년</div>
							<div class="quantity-controls">
	                            <button type="button" class="quantity-down" data-type="youth">-</button>
	                            <input type="number" min="0" value="0" max="4" readonly class="quantity-input" data-type="youth"/>
	                            <button type="button" class="quantity-up" data-type="youth">+</button>
	                        </div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">경로</div>
							<div class="quantity-controls">
	                            <button type="button" class="quantity-down" data-type="senior">-</button>
	                            <input type="number" min="0" value="0" max="4" readonly class="quantity-input" data-type="senior"/>
	                            <button type="button" class="quantity-up" data-type="senior">+</button>
	                        </div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">우대</div>
							<div class="quantity-controls">
	                            <button type="button" class="quantity-down" data-type="special">-</button>
	                            <input type="number" min="0" value="0" max="4" readonly class="quantity-input" data-type="special"/>
	                            <button type="button" class="quantity-up" data-type="special">+</button>
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
						<div id="container">
        					<div class="seatContainer" id="seatContainer">
            					<div class="screen"></div>
            					<!-- JavaScript로 생성된 좌석이 여기에 추가됩니다 -->
        					</div>
    					</div>
					</div>
				</div>
			</div>
			
			<!-- 총합계 및 결제하기 -->
			<div class="ticket-container">
				<div class="ticket-price-wrapper">
					<div class="ticket-price-title">총 합계</div>
					<div class="ticket-price">0원</div>
				</div>
				<form action="moviePayment" class="seatForm" method="post">
					<input type="hidden" class="title" name="title"> 
					<input type="hidden" class="selectedTheater" name="selectedTheater">
					<input type="hidden" class="reserveDate" name="movieDate">
					<input type="hidden" class="runningTime" name="runningTime">
					<input type="hidden" class="movieAge" name="movieAge" value="">
					<!-- 티켓의수(선택한 좌석) -->
					<input type="hidden" class="ticketNumber" name="ticketNumber">
					<input type="hidden" class="selectedSeat" name="selectedSeat">
					<!-- 결제 정보 -->
					<input type="hidden" class="payMoney" name="payMoney">
					<input type="submit" class="movePaymentButton" value="결제하기">
				</form>
			</div>
		</div>
	</div>
	
	<script>
        document.addEventListener('DOMContentLoaded', () => {
            const seatContainer = document.getElementById('seatContainer');
            const ticketPriceElement = document.querySelector('.ticket-price');
            const pricePerType = {
                adult: 14000,
                youth: 11000,
                senior: 7000,
                special: 5000
            };

            // 좌석 생성하는데 div, span으로 생성하도록 반복문 작성
            function createSeats(rows, cols) {
                for (let i = 0; i < rows; i++) {
                    const row = document.createElement('div');
                    row.classList.add('row');
                    for (let j = 0; j < cols; j++) {
                        const seat = document.createElement('span');
                        seat.classList.add('seat');
                        row.appendChild(seat);
                    }
                    seatContainer.appendChild(row);
                }
            }

            createSeats(9, 12);

            // 좌석 클릭 시 색 변경해주는 - 토글 형태
            seatContainer.addEventListener('click', (e) => {
                if (e.target.classList.contains('seat')) {
                    e.target.classList.toggle('selectedSeat');
                    countSelectedSeats();
                }
            });

            // 인원 수 조절 버튼 이벤트
            document.querySelectorAll('.quantity-controls button').forEach(button => {
                button.addEventListener('click', (e) => {
                    const input = e.target.parentElement.querySelector('input');
                    let value = parseInt(input.value);

                    if (e.target.classList.contains('quantity-up')) {
                        if (value < parseInt(input.max)) {
                            value++;
                        }
                    } else if (e.target.classList.contains('quantity-down')) {
                        if (value > parseInt(input.min)) {
                            value--;
                        }
                    }

                    input.value = value;
                    updateTotalPrice();
                });
            });

            // 총 합계 금액 업데이트
            function updateTotalPrice() {
                let totalPrice = 0;

                document.querySelectorAll('.quantity-input').forEach(input => {
                    const count = parseInt(input.value);
                    const type = input.getAttribute('data-type');
                    totalPrice += count * pricePerType[type];
                });

                ticketPriceElement.textContent = totalPrice.toLocaleString() + '원';
            }
        });
    </script>
 --%>
 
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
						<div id="container">
        					<div class="seatContainer" id="seatContainer">
            					<div class="screen"></div>
            					<!-- JavaScript로 생성된 좌석이 여기에 추가됩니다 -->
        					</div>
    					</div>
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
	
	<script>
        document.addEventListener('DOMContentLoaded', () => {

            const seatContainer = document.getElementById('seatContainer');

            // 좌석 생성하는데 div, span으로 생성하도록 반복문 작성
            function createSeats(rows, cols) {
                for (let i = 0; i < rows; i++) {
                    const row = document.createElement('div');
                    row.classList.add('row');
                    for (let j = 0; j < cols; j++) {
                        const seat = document.createElement('span');
                        seat.classList.add('seat');
                        row.appendChild(seat);
                    }
                    seatContainer.appendChild(row);
                }
            }

            createSeats(9,12);

            // 좌석 클릭 시 색 변경해주는 - 토글 형태
            seatContainer.addEventListener('click', (e) => {
                if (e.target.classList.contains('seat')) {
                    e.target.classList.toggle('selectedSeat');
                    countSelectedSeats();
                }
            });

        });
    </script>