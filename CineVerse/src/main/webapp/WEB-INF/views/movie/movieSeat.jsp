<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="select-container">
    <form action="moviePayment" method="post" id="seatForm">
        <div class="select-wrapper">
            <div class="select-title">인원/좌석 선택</div>
            <div class="select-seat-container">
                <!-- 영화 상영 정보 -->
                <div class="select-seat-information">
                    <div class="selected-movie"></div>
                    <div class="select-seat-information-wrapper">
                        <c:forEach var="movieInfo" items="${movieInfoList}">
                           <input type="hidden" name="mt_num" id="mt_num" value="${movieInfo.mt_num}">
                            <p class="moviename">${movieInfo.m_name}<br></p>
                            <p class="movietime">${movieInfo.mt_date} | ${movieInfo.mt_start} ~ ${movieInfo.mt_end}<br></p>
                            <p class="movieplace">${movieInfo.c_branch}지점 ${movieInfo.th_name}</p>
                        </c:forEach>
                    </div>
                    <div class="select-theater-date">
                        <div class="theater-date"></div>
                        <div class="theater-time"></div>
                    </div>
                    <div class="selected-seats-wrapper">
                        <span class="selected-seats-title">좌석번호</span>
                        <span class="selectedSeats">선택한 좌석이 없습니다.</span>
                    </div>
                </div>

                <!-- 인원 수 체크 -->
                <div class="select-seat-number-container">
                    <div class="select-seat-number-wrapper">
                        <div class="select-seat">
                            <div class="select-seat-age">성인</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down stylish-button">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input adult"/>
                                <button type="button" class="quantity-up stylish-button">+</button>
                            </div>
                        </div>  
                        <div class="select-seat">
                            <div class="select-seat-age">청소년</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down stylish-button">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input youth"/>
                                <button type="button" class="quantity-up stylish-button">+</button>
                            </div>
                        </div>
                        <div class="select-seat">
                            <div class="select-seat-age">경로</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down stylish-button">-</button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input senior"/>
                                <button type="button" class="quantity-up stylish-button">+</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 영화 좌석 선택 -->
            <div class="seat-container">
                <div class="seat-wrapper">
                    <div class="screen-view-wrapper">
                        <div id="container">
                            <div class="seatContainer" id="seatContainer">
                                <div class="screen"></div>
                                <!-- JavaScript로 생성된 좌석이 여기에 추가됩니다 -->
                                <c:forEach var="i" begin="0" end="${fn:length(seatList) / 12}">
                                    <div class="row">
                                        <c:forEach var="j" begin="0" end="11">
                                            <c:if test="${i * 12 + j < fn:length(seatList)}">
                                                <span class="seat" data-seat-num="${seatList[i * 12 + j].seat_num}">
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
                <input type="hidden" name="mt_num" id="mt_num">
                <!-- 티켓의수(선택한 좌석) -->
                <input type="hidden" id="ticket_Number" name="ticketNumber">
                <input type="hidden" id="selected_Seats" name="selectedSeats">
                <input type="hidden" id="seat_Num" name="seatNum">
                <!-- 결제 정보 -->
                <input type="hidden" id="pay_Money" name="payMoney">
                <input type="submit" class="movePaymentButton" id="link_rpay" value="결제하기">
            </div>
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const seatContainer = document.getElementById('seatContainer');
    const quantityInputs = document.querySelectorAll('.quantity-input');
    let totalPrice = 0;
    let selectedSeats = [];
    let selectedSeatNums = [];

    //숫자에 천 단위 구분 기호를 추가하는 함수
    function formatNumber(number) {
        return number.toLocaleString(); // 천 단위 구분 기호 추가
    }

    //총 합계 금액을 업데이트하는 함수
    function updateTotalPrice() {
        document.querySelector('.ticket-price').innerText = formatNumber(totalPrice) + '원';
        document.getElementById('pay_Money').value = totalPrice;
    }

    //선택된 좌석의 수를 세고, 화면에 표시하는 함수
    function countSelectedSeats() {
        const selectedSeatLabels = selectedSeats.map(seat => seat.innerText);
        const selectedSeatNumbers = selectedSeats.map(seat => seat.getAttribute('data-seat-num'));
        document.querySelector('.selectedSeats').innerText = selectedSeatLabels.join(', ') || '선택한 좌석이 없습니다.';
        document.getElementById('selected_Seats').value = selectedSeatLabels.join(', ');
        document.getElementById('ticket_Number').value = selectedSeats.length;
        document.getElementById('seat_Num').value = selectedSeatNumbers.join(',');
    }

    //총 인원수를 검증하는 함수(최대 8명 제한)
    function validateTotalPeople() {
        const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);
        if (totalPeople > 8) { // 인원 수 제한
            alert("제한 인원은 8명까지입니다.");
            return false;
        }
        return true;
    }

    //좌석 수와 총 합계 금액을 업데이트하는 함수
    function updateSeatCountAndTotalPrice() {
        const adults = parseInt(document.querySelector('.quantity-input.adult').value) || 0;
        const youth = parseInt(document.querySelector('.quantity-input.youth').value) || 0;
        const senior = parseInt(document.querySelector('.quantity-input.senior').value) || 0;
        
        totalPrice = (adults * 14000) + (youth * 12000) + (senior * 10000);
        updateTotalPrice();
    }

    //좌석을 클릭했을 때 실행되는 함수
    seatContainer.addEventListener('click', (e) => {
        if (e.target.classList.contains('seat')) {
            const selectedSeat = e.target;
            const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);
            const totalSelectedSeats = selectedSeats.length;

            // 여기서 data-seat-num 값을 콘솔에 출력
            console.log(selectedSeat.getAttribute('data-seat-num'));
            
            if (totalPeople === 0) {
                alert("인원 수를 선택해주세요.");
                return;
            }

            if (selectedSeat.classList.contains('selectedSeat')) {
                // 이미 선택된 좌석을 취소하는 경우
                selectedSeat.classList.remove('selectedSeat');
                selectedSeats = selectedSeats.filter(seat => seat !== selectedSeat);
                selectedSeatNums = selectedSeatNums.filter(seatNum => seatNum !== selectedSeat.getAttribute('data-seat-num'));
            } else {
                if (totalSelectedSeats < totalPeople) {
                    selectedSeat.classList.add('selectedSeat');
                    selectedSeats.push(selectedSeat);
                    selectedSeatNums.push(selectedSeat.getAttribute('data-seat-num'));
                } else {
                    alert("인원 수 만큼 좌석을 선택하였습니다.");
                }
            }

            // 좌석 선택 시 금액 업데이트
            updateSeatCountAndTotalPrice();
            countSelectedSeats();
        }
    });

    //인원 수 증가 버튼 클릭 시 실행되는 함수
    document.querySelectorAll('.quantity-up').forEach(button => {
        button.addEventListener('click', () => {
            const input = button.previousElementSibling;
            const currentValue = parseInt(input.value);
            const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);

            if (totalPeople < 8) { // 총 인원수 제한
                input.value = currentValue + 1;
                validateTotalPeople();
                resetSeats(); // 좌석 초기화
                updateSeatCountAndTotalPrice(); // 인원 수 증가 시 금액 업데이트
            } else {
                alert("제한 인원은 8명까지입니다."); // 인원 수 초과 시 알림
            }
        });
    });

    //인원 수 감소 버튼 클릭 시 실행되는 함수
    document.querySelectorAll('.quantity-down').forEach(button => {
        button.addEventListener('click', () => {
            const input = button.nextElementSibling;
            if (input.value > 0) {
                input.value = parseInt(input.value) - 1;
                resetSeats(); // 좌석 초기화
                updateSeatCountAndTotalPrice(); // 인원 수 감소 시 금액 업데이트
            }
        });
    });

    //인원 수 입력 필드 변경 시 실행되는 함수
    quantityInputs.forEach(input => {
        input.addEventListener('input', () => {
            validateTotalPeople();
            resetSeats(); // 좌석 초기화
            updateSeatCountAndTotalPrice(); // 인원 수 변경 시 금액 업데이트
        });
    });

    // 선택된 좌석을 초기화하는 함수
    function resetSeats() {
        selectedSeats.forEach(seat => seat.classList.remove('selectedSeat'));
        selectedSeats = [];
        selectedSeatNums = [];
        countSelectedSeats();
    }

    //결제하기 버튼 클릭 시 유효성 검사 함수
    document.querySelector('.movePaymentButton').addEventListener('click', (e) => {
        const totalPeople = Array.from(quantityInputs).reduce((sum, input) => sum + parseInt(input.value), 0);
        const totalSelectedSeats = selectedSeats.length;

        if (totalPeople === 0) {
            alert("인원 수를 선택해주세요.");
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        if (totalSelectedSeats !== totalPeople) {
            alert("선택한 인원수와 좌석수가 일치하지 않습니다.");
            e.preventDefault(); // 폼 제출 방지
            return;
        }
    });

    // 초기 금액 업데이트
    updateSeatCountAndTotalPrice();
});
</script>
