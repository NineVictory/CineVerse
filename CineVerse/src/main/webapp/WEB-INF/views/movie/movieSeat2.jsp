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
                    <c:forEach var="movieInfo" items="${movieInfoList}">
                        <p>${movieInfo.m_name}<br></p>
                        <p>${movieInfo.mt_date}<br></p>
                        <p>${movieInfo.mt_start}<br></p>
                        <p>${movieInfo.mt_end}<br></p>
                        <p>${movieInfo.th_name}</p>
                        <!-- 필요시 추가 필드도 여기에 표시 -->
                    </c:forEach>
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
                            <button type="button" class="quantity-down">-</button>
                            <input type="number" min="1" value="0" max="4" readonly class="quantity-input" />
                            <button type="button" class="quantity-up">+</button>
                        </div>
                    </div>
                    <div class="select-seat">
                        <div class="select-seat-age">청소년</div>
                        <div class="quantity-controls">
                            <button type="button" class="quantity-down">-</button>
                            <input type="number" min="1" value="0" max="4" readonly class="quantity-input" />
                            <button type="button" class="quantity-up">+</button>
                        </div>
                    </div>
                    <div class="select-seat">
                        <div class="select-seat-age">경로</div>
                        <div class="quantity-controls">
                            <button type="button" class="quantity-down">-</button>
                            <input type="number" min="1" value="0" max="4" readonly class="quantity-input" />
                            <button type="button" class="quantity-up">+</button>
                        </div>
                    </div>
                    <div class="select-seat">
                        <div class="select-seat-age">우대</div>
                        <div class="quantity-controls">
                            <button type="button" class="quantity-down">-</button>
                            <input type="number" min="1" value="0" max="4" readonly class="quantity-input" />
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
                            <%-- <c:forEach var="seat" items="${seatList}">
                                <div>${seat.seat_row}${seat.seat_column}</div>
                            </c:forEach> --%>
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

        // 좌석 생성하는데 div, span으로 생성하도록 반복문 작성
        function createSeats(rows, cols) {
            const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            for (let i = 0; i < rows; i++) {
                const row = document.createElement('div');
                row.classList.add('row');
                for (let j = 0; j < cols; j++) {
                    const seat = document.createElement('span');
                    seat.classList.add('seat');
                    seat.dataset.snum = `${alphabet[i]}${j + 1}`; // data-snum 값 설정
                    seat.textContent = seat.dataset.snum; // 좌석 번호 표시
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
                alert(e.target.dataset.snum); // 클릭한 좌석의 data-snum 값 alert로 표시
            }
        });


    });
</script>
