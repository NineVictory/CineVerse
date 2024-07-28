<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    
});
</script>
<div class="select-container">
    <form action="moviePayment" method="post" id="seatForm">
        <div class="select-wrapper">
            <div class="select-title">인원/좌석 선택</div>
            
            <div class="select-seat-container">
                <!-- 영화 상영 정보 -->
                <div class="select-seat-information">
                    <!-- <div class="selected-movie"></div> -->
                    <div class="select-seat-information-wrapper">
                        <c:forEach var="movieInfo" items="${movieInfoList}">
                           <input type="hidden" name="mt_num" id="mt_num" value="${movieInfo.mt_num}">
                           	<img alt="영화1" src="${fn:split(movieInfo.m_filename, '|')[0]}" width="80">
                           	<div class="movie_info_seat">
                           		<div class="movierating">
                           		<span class="ic_grade <c:choose><c:when test="${movieInfo.rating eq '12세관람가' }">gr_12</c:when>
						                    <c:when test="${movieInfo.rating eq '12세이상관람가' }">gr_12</c:when>
						                    <c:when test="${movieInfo.rating eq '전체관람가' }">gr_all</c:when>
						                    <c:when test="${movieInfo.rating eq '15세관람가' }">gr_15</c:when>
						                    <c:when test="${movieInfo.rating eq '15세이상관람가' }">gr_15</c:when>
						                    <c:when test="${movieInfo.rating eq '18세관람가(청소년관람불가)' }">gr_19</c:when>
						                    <c:when test="${movieInfo.rating eq '청소년관람불가' }">gr_19</c:when></c:choose>">
					            </span>
                           		<p class="moviename">${movieInfo.m_name}</p>
                           		</div>
                            	<p class="movietime">${movieInfo.mt_date} | ${movieInfo.mt_start} ~ ${movieInfo.mt_end}</p>
                            	<p class="movieplace">${movieInfo.c_branch}지점 ${movieInfo.th_name}</p>
                        </c:forEach>
                        		 <p>남은 좌석: ${availableSeats}석</p>
                        <div class="select-theater-date">
                       	 	<div class="selected-seats-wrapper">
                        		<span class="selected-seats-title">좌석번호</span>
                        		<span class="selectedSeats">선택한 좌석이 없습니다.</span>
                    		</div>
                        </div>
                        </div>
                    </div>
                </div>

                <!-- 인원 수 체크 -->
                <div class="select-seat-number-container">
                    <div class="select-seat-number-wrapper">
                        <div class="select-seat">
                            <div class="select-seat-age">성인</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down stylish-button"><span>-</span></button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input adult"/>
                                <button type="button" class="quantity-up stylish-button"><span>+</span></button>
                            </div>
                        </div>  
                        <div class="select-seat">
                            <div class="select-seat-age">청소년</div>
                            <div class="quantity-controls">
                                <button type="button" class="quantity-down stylish-button"><span>-</span></button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input youth"/>
                                <button type="button" class="quantity-up stylish-button"><span>+</span></button>
                            </div>
                        </div>
                        <div class="select-seat">
                            <div class="select-seat-age">경로</div>
                            <div class="quantity-controls">
                            <button type="button" class="quantity-down stylish-button"><span>-</span></button>
                                <input type="number" min="0" value="0" max="8" readonly class="quantity-input senior"/>
                                <button type="button" class="quantity-up stylish-button"><span>+</span></button>
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
                               <%--  <c:forEach var="i" begin="0" end="${fn:length(seatList) / 12}">
                                    <div class="row">
                                        <c:forEach var="j" begin="0" end="11">
                                            <c:if test="${i * 12 + j < fn:length(seatList)}">
                                                <span class="seat" data-seat-num="${seatList[i * 12 + j].seat_num}">
                                                    ${seatList[i * 12 + j].seat_row}${seatList[i * 12 + j].seat_column}
                                                </span>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </c:forEach> --%>
								<c:forEach var="i" begin="0" end="${fn:length(seatList) / 12}">
									<div class="row">
										<c:forEach var="j" begin="0" end="11">
											<c:if test="${i * 12 + j < fn:length(seatList)}">
												<c:set var="isBooked" value="false" />
												<c:forEach var="bookedSeat" items="${bookedSeats}">
													<c:if
														test="${bookedSeat.seat_num == seatList[i * 12 + j].seat_num}">
														<c:set var="isBooked" value="true" />
													</c:if>
												</c:forEach>

												<span class="seat ${isBooked ? 'booked' : ''}"
													data-seat-num="${seatList[i * 12 + j].seat_num}"
													${isBooked ? 'data-booked="true"' : ''}>
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
                <input type="hidden" id="hidden_adult" name="adultCount" />
				<input type="hidden" id="hidden_youth" name="youthCount" />
				<input type="hidden" id="hidden_senior" name="seniorCount" />
                <input type="hidden" id="seat_Num" name="seatNum">
                <!-- 결제 정보 -->
                <input type="hidden" id="pay_Money" name="payMoney">
                <div class="movie_reserve_btn">
                	<input type="submit" class="movePaymentButton" id="link_rpay" value="결제하기">
                </div>
            </div>
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
	alert('5분동안 미선택시 이전 화면으로 이동됩니다.\n이용에 참고부탁드립니다.');
	
    var movieTimeElement = document.querySelector('.movietime');
    if (movieTimeElement) {
        var textContent = movieTimeElement.textContent;

        var parts = textContent.split('|');
        if (parts.length === 2) {
            var datePart = parts[0].trim();
            var timePart = parts[1].trim();

           	var dateText = datePart.split(' ')[0];
            var dateParts = dateText.split("-");
            var date = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
            var days = ["(일)", "(월)", "(화)", "(수)", "(목)", "(금)", "(토)"];
            var dayOfWeek = days[date.getDay()];

            var timeParts = timePart.split('~');
            var formattedTimes = timeParts.map(function(time) {
                if (time.trim() === "0" || time.trim() === "0000") {
                    return "00:00";
                } else if (time.trim().length === 3){ 
                	return '0' + time.trim().slice(0, 1) + ':' + time.trim().slice(1);
                } else {
                    return time.trim().slice(0, 2) + ":" + time.trim().slice(2);
                }
            });

            var formattedText = dateText + ' ' + dayOfWeek + ' | ' + formattedTimes.join(' ~ ');

            movieTimeElement.textContent = formattedText;
        }
    }
	
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
        
        document.getElementById('hidden_adult').value = adults;
        document.getElementById('hidden_youth').value = youth;
        document.getElementById('hidden_senior').value = senior;
        
        totalPrice = (adults * 14000) + (youth * 12000) + (senior * 10000);
        updateTotalPrice();
    }

    //좌석을 클릭했을 때 실행되는 함수
    seatContainer.addEventListener('click', (e) => {
        if (e.target.classList.contains('seat')) {
        	
            // 예약된 좌석인지 확인
            if (e.target.classList.contains('booked')) {
                alert("이 좌석은 이미 예약되었습니다.");
                return;
            }
        	
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

let timeoutDuration = 2 * 60 * 1000; // 2분
let warningDuration = 1 * 60 * 1000; // 1분
let timeout, warningTimeout;
let hasExtended = false; // 연장을 했는지 여부를 확인

function startTimer() {
    clearTimeout(timeout);
    clearTimeout(warningTimeout);

    warningTimeout = setTimeout(function() {
        if (!hasExtended) {
            let extend = confirm("남은 시간이 1분 남았습니다. 시간을 연장하시겠습니까?\n연장은 한 번만 가능합니다.");
            if (!extend) {
                alert("시간이 초과되어 영화 선택 화면으로 돌아갑니다.");
                window.history.go(-1);
            } else {
                hasExtended = true;
                resetTimer();
            }
        }
    }, warningDuration);

    timeout = setTimeout(function() {
        if (!hasExtended) { // 연장을 하지 않은 경우에만 이동
            alert("시간이 초과되어 영화 선택 화면으로 돌아갑니다.");
            window.history.go(-1);
        }
    }, timeoutDuration);
}

function resetTimer() {
    clearTimeout(timeout);
    clearTimeout(warningTimeout);
    startTimer();
}

document.addEventListener('click', resetTimer);
document.addEventListener('DOMContentLoaded', startTimer);

</script>


<div id="banner_reserve_section" class="banner_reserve_wrap">
    <div class="bx_lft"><a
            href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_37&amp;adgroupid=adg_lottecinema_20240530_55&amp;adid=adi_lottecinema_20240530_65"
            target="_blank" title="새창열기"><img
                src="https://cf2.lottecinema.co.kr/lotte_image/2024/LotteCard/LotteCard_160300.png"></a></div>
    <div class="bx_rgt"><a
            href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_37&amp;adgroupid=adg_lottecinema_20230706_10&amp;adid=adi_lottecinema_20230706_10"
            target="_blank" title="새창열기"><img
                src="https://cf2.lottecinema.co.kr/lotte_image/2024/Hyundai_Insurance/Hyundai_Insurance_1603002.jpg"></a></div>
</div>

<div id="banner_section" class="banner_wrap">
    <div class="banner_01"><a
            href="${pageContext.request.contextPath}/movie/movieDetail?m_code=37"
            target="" title="화면이동"><img src="https://cf2.lottecinema.co.kr/lotte_image/2024/Pilot/Pilot_9801807.jpg"
                alt="올 여름 코미디의 정석이 이륙합니다 입소문 폭발 더위 탈출 코미디 파일럿 7월 31일 극장 대개봉"></a></div>
</div>

<style>
.banner_side_wrap {
        position: absolute;
        top: 220px;
        left: 50%;
        margin-left: -660px;
        z-index: 10;
    }

    .banner_wrap .banner_01 {
        margin-bottom: 50px;
    }

    .banner_wrap {
        padding-top: 70px;
        text-align: center;
    }

    .banner_wrap a {
        display: block;
        width: 980px;
        margin: 0 auto;
    }

    a,
    a:link,
    a:visited,
    a:active,
    a:hover {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .banner_reserve_wrap .bx_lft {
        left: 50%;
        margin-left: -820px;
    }

    .banner_reserve_wrap .bx_lft,
    .banner_reserve_wrap .bx_rgt {
        position: absolute;
        z-index: 10;
        top: 220px;
        width: 160px;
        height: 300px;
    }

    .banner_reserve_wrap .bx_rgt {
        right: 50%;
        margin-right: -820px;
    }

    .quick-reserve-ad-area {
        overflow: hidden;
        width: 1100px;
        height: 80px;
        margin-top: 10px;
    }

    iframe {
        display: inline-block;
        border: 0;
    }
</style>
