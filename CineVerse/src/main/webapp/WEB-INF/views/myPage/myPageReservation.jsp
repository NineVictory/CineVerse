<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 예매내역 시작 -->
<div class="myPage_main">

    <div class="reservation_display">
        <span class="myPage_title_re">예매내역</span>
        <span class="watched_movie">내가 본 영화</span>
    </div>
    <hr size="1" width="100%" class="wa_line">
    <div class="reservation_font">
        <div class="reservation_font1">
            현장에서 발권하실 경우 꼭 <span class="reservation_font_red">예매번호</span>를 확인하세요.
        </div>
        <div class="reservation_font2">티켓판매기에서 예매번호를 입력하면 티켓을 발급받을수 있습니다.</div>
    </div>

    <div class="reservation_rep">
        <div class="re_movie_number">
            <span class="mp_movie_number_1">예매번호</span><span
                class="mp_movie_number_2">${detail.user_mb_num }</span>
        </div>
        <div class="reserv_display">
            <div class="wa_photo">
                <img alt="영화1" src="${fn:split(detail.m_filename, '|')[0]}" onclick="location.href='${pagecontext.request.contextPath}/movie/movieDetail?m_code=${detail.m_code}'" class="expect_movie_poster" width="150" height="210">
            </div>
            <div class="reservation_info">
                <div class="reservation_movie_name">
                    ${detail.m_name }
                </div>
                <div class="reservation_infomation">
                    <div class="my_reserv_info_1">
                        <div>관람극장</div>
                        <div>관람일시</div>
                        <div>상영관</div>
                    </div>
                    <div class="my_reserv_info_2">
                        <div>CINEVERSE${detail.c_branch }</div>
                        <div id="formatted-date">${detail.mt_date} <span id="day-of-week"></span> ${detail.mt_start}</div>
                        <div>${detail.th_name }관</div>
                    </div>
                    <div class="my_reserv_info_3">
                        <div>관람인원</div>
                        <div>관람좌석</div>
                    </div>
                    <div class="my_reserv_info_4">
                        <div>${detail.booking_count }명</div>
                        
                        
                        <div>
    <c:forEach var="se" items="${seatList}" varStatus="status">
        ${se}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
</div>
                        
                        
                        
                    </div>
                </div>
                <hr size="1" width="100%" class="wa_line">
                <div class="reserv_pay_cancle">
                    <div>
                        <span class="m_pay">총 결제금액 </span><span class="my_blue_font">${detail.mb_price}원</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="payment_receipt">결제내역</div>
    <div class="pay_receipt_box">
        <div class="pay_receipt">
            <div class="reservation_pay">총 결제금액</div>
            <span class="reservation_pay_blue_font">${detail.mb_price}원</span>
        </div>
        <hr size="1" width="100%" class="wa_line">
        <div class="payment_way">
            <div class="pay_way">
                <div class="pay_point">포인트 결제</div>
                <div class="pay_coupon">쿠폰 결제</div>
            </div>
            <div class="pay_way_count">
                <div class="point_count">${detail.mb_price}원</div>
                <div class="coupon_count">
                    <c:if test="${not empty couponSale}">
                        ${couponSale}원
                    </c:if>
                    <c:if test="${empty couponSale}">
                        0원
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <%-- <div class="m_cancle" data-num="${detail.mb_num}" data-mnum="${user.mem_num}" data-price="${detail.mb_price}" data-payment="예매환불">예매취소</div> --%>
</div>
<!-- 예매내역 끝-->

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        var timeDiv = document.getElementById("formatted-date");
        if (timeDiv) {
            var timesText = "${detail.mt_start}".split("~");
            
            var formattedTimes = timesText.map(function(time) {
            	 if (time.trim() === "0" || time.trim() === "0000") {
                     return "00:00";
                 } else if (time.trim().length === 3){ 
                 	return '0' + time.trim().slice(0, 1) + ':' + time.trim().slice(1);
                 } else {
                     return time.trim().slice(0, 2) + ":" + time.trim().slice(2);
                 }
            });
            
            var dateText = "${detail.mt_date}";
            var dateParts = dateText.split("-");
            var date = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
            var days = ["(일)", "(월)", "(화)", "(수)", "(목)", "(금)", "(토)"];
            var dayOfWeek = days[date.getDay()];
            
            var dayOfWeekSpan = document.getElementById("day-of-week");
            if (dayOfWeekSpan) {
                dayOfWeekSpan.textContent = dayOfWeek;
            }

            timeDiv.innerHTML = dateText + " <span id='day-of-week'>" + dayOfWeek + "</span> " + formattedTimes.join("~");
        }
    });
</script>
