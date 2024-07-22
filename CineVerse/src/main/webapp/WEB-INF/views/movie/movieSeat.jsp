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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	 <div class="select-container">
        <div class="select-wrapper">
            <div class="select-title">인원/좌석 선택</div>
            <div class="select-seat-container">
                <!-- 영화 상영 정보 -->
                <div class="select-seat-information">
                    <div class="selected-movie"></div>
                    <div class="select-seat-information-wrapper">
                        <c:forEach var="movieInfo" items="${movieInfoList}">
                            <p>${movieInfo.m_name}<br></p>
                            <p>${movieInfo.mt_date}<br></p>
                            <p>${movieInfo.mt_start}<br></p>
                            <p>${movieInfo.mt_end}<br></p>
                            <p>${movieInfo.th_name}</p>
                        </c:forEach>
                    </div>
                    <div class="select-theater-date">
                        <div class="theater-date"></div>
                        <div class="theater-time"></div>
                    </div>
                    <div class="selected-seats-wrapper">
                        <span class="selected-seats-title">좌석번호</span>
                        <span class="selected-seats">선택한 좌석이 없습니다.</span>
                    </div>
                </div>

                <!-- 인원 수 체크 -->
                <div class="select-seat-number-container">
                    <div class="select-seat-number-wrapper">
                        <div class="select-seat">
                            <div class="select-seat-age">성인</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input adult"/>
                                <button type="button" class="quantity-up">+</button>
                            </div>
                        </div>
                        <div class="select-seat">
                            <div class="select-seat-age">청소년</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input youth"/>
                                <button type="button" class="quantity-up">+</button>
                            </div>
                        </div>
                        <div class="select-seat">
                            <div class="select-seat-age">경로</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input senior"/>
                                <button type="button" class="quantity-up">+</button>
                            </div>
                        </div>
                        <div class="select-seat">
                            <div class="select-seat-age">우대</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input special"/>
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
                                <c:forEach var="i" begin="0" end="${fn:length(seatList) / 12}">
                                    <div class="row">
                                        <c:forEach var="j" begin="0" end="11">
                                            <c:if test="${i * 12 + j < fn:length(seatList)}">
                                                <span class="seat">
                                                    ${seatList[i * 12 + j].seat_row}${seatList[i * 12 + j].seat_column}
                                                </span>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
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
                    <input type="hidden" class="movieAge" name="movieAge" value="">
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
        const quantityInputs = document.querySelectorAll('.quantity-input');
        let totalPrice = 0;
        let selectedSeats = [];

        function formatNumber(number) {
            return number.toLocaleString(); // 천 단위 구분 기호 추가
        }

        function updateTotalPrice() {
            document.querySelector('.ticket-price').innerText = formatNumber(totalPrice) + '원';
        }

        function countSelectedSeats() {
            const selectedSeatLabels = selectedSeats.map(seat => seat.innerText);
            document.querySelector('.selected-seats').innerText = selectedSeatLabels.join(', ') || '선택한 좌석이 없습니다.';
        }

        function validateTotalPeople() {
            const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);
            if (totalPeople > 8) { // 인원 수 제한
                alert("제한 인원은 8명까지입니다.");
                return false;
            }
            return true;
        }

        function updateSeatCountAndTotalPrice() {
            const adults = parseInt(document.querySelector('.quantity-input.adult').value) || 0;
            const youth = parseInt(document.querySelector('.quantity-input.youth').value) || 0;
            const senior = parseInt(document.querySelector('.quantity-input.senior').value) || 0;
            const special = parseInt(document.querySelector('.quantity-input.special').value) || 0;

            totalPrice = (adults * 14000) + (youth * 12000) + (senior * 10000) + (special * 10000);
            updateTotalPrice();
        }

        seatContainer.addEventListener('click', (e) => {
            if (e.target.classList.contains('seat')) {
                const selectedSeat = e.target;
                const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);
                const totalSelectedSeats = selectedSeats.length;

                if (totalPeople === 0) {
                    alert("인원 수를 선택해주세요.");
                    return;
                }

                if (selectedSeat.classList.contains('selectedSeat')) {
                    // 이미 선택된 좌석을 취소하는 경우
                    selectedSeat.classList.remove('selectedSeat');
                    selectedSeats = selectedSeats.filter(seat => seat !== selectedSeat);
                } else {
                    if (totalSelectedSeats < totalPeople) {
                        selectedSeat.classList.add('selectedSeat');
                        selectedSeats.push(selectedSeat);
                    } else {
                        alert("인원 수 만큼 좌석을 선택하였습니다.");
                    }
                }

                // 좌석 선택 시 금액 업데이트
                updateSeatCountAndTotalPrice();
                countSelectedSeats();
            }
        });

        document.querySelectorAll('.quantity-up').forEach(button => {
            button.addEventListener('click', () => {
                const input = button.previousElementSibling;
                const currentValue = parseInt(input.value);
                const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);

                if (totalPeople < 8) { // 총 인원수 제한
                    input.value = currentValue + 1;
                    validateTotalPeople();
                    updateSeatCountAndTotalPrice(); // 인원 수 증가 시 금액 업데이트
                } else {
                    alert("제한 인원은 8명까지입니다."); // 인원 수 초과 시 알림
                }
            });
        });

        document.querySelectorAll('.quantity-down').forEach(button => {
            button.addEventListener('click', () => {
                const input = button.nextElementSibling;
                if (input.value > 0) {
                    input.value = parseInt(input.value) - 1;
                    updateSeatCountAndTotalPrice(); // 인원 수 감소 시 금액 업데이트
                }
            });
        });

        quantityInputs.forEach(input => {
            input.addEventListener('input', () => {
                validateTotalPeople();
                updateSeatCountAndTotalPrice(); // 인원 수 변경 시 금액 업데이트
            });
        });

        // 초기 금액 업데이트
        updateSeatCountAndTotalPrice();
    });

    
    /* // 좌석 생성하는데 div, span으로 생성하도록 반복문 작성
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

    createSeats(9, 12); */
    </script>