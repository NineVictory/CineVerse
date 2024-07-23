<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-container">
<div class="movie_payments">
 <div class="movies_info">
 	<div class="movies_poster">
 	<c:forEach var="movieInfo" items="${movieInfoList}">
       <img alt="영화1" src="${pageContext.request.contextPath}/upload/${movieInfo.m_filename}" width="180">
    </c:forEach>
 	</div>
 	<div>
 		<div class="movie_title">
		<strong class="tit_info"> 
			<!-- <span class="ic_grade gr_all">전체</span>인사이드아웃 2 (2D 자막) -->
		</strong> 
	</div>
		<div class="reserved_info">
 		<c:forEach var="movieInfo" items="${movieInfoList}">
        <p>영화 제목: ${movieInfo.m_name}</p>
        <p>극장: ${movieInfo.c_branch} ${movieInfo.th_name}</p>
        <p>예약 날짜: ${movieInfo.mt_date}</p>
        <p>상영 시간: ${movieInfo.mt_start} ~ ${movieInfo.mt_end}</p>
        <%-- ${movieInfo.m_code} --%>
    </c:forEach>
 	</div>
 	<div class="reserved_space">
 		<p>인원: ${ticketNumber}</p>
    	<p>선택한 좌석: ${selectedSeats}</p>
    	<p>티켓 금액: <span class="payMoney">${payMoney}</span>원</p>
    	<p>회원 이름: ${member.mem_name}</p>
    	<%-- 좌석식별자 번호:${seatNum} --%>
    	
 	</div>
 	</div>
 </div>
 <div class="payments_all">
 	<h2>할인 적용</h2>
 	<div class="pay_coupon">
 		<h3>쿠폰</h3>
 		<div class="coupon_list">
	 	<c:if test="${member.coupon_cnt == 0 }">
	               보유한 쿠폰이 없습니다.
	    </c:if>
	    <c:if test="${member.coupon_cnt > 0 }">	    
	    <c:forEach var="couponList" items="${couponList}">    
	    <c:if test="${couponList.coupon_where==1 && couponList.coupon_use==1}">
	    <input type="checkbox" class="coupon-select" name="pay-coupon" value="${couponList.mc_num}" data-coupon="${couponList.coupon_sale}">
 			<div class="coupon_detail">
 				<span class="coupon_name">${couponList.coupon_name}</span>
 				<span class="coupon_detail_all">${couponList.coupon_content}</span>
 				<span class="coupon_detail_all">${couponList.coupon_regdate} ~ ${couponList.coupon_enddate}<span class="coupon_time"></span></span> 
 			</div>
 		</c:if>
 		 <c:if test="${couponList.coupon_where==2 && couponList.coupon_use==1}">
          <div class="coupon_detail" style="background-color:#BDBDBD">
	      <span class="coupon_name">(벌스샵 전용 - 사용 불가) ${couponList.coupon_name}</span>
	       <span class="coupon_detail_all">${couponList.coupon_content}</span>
	       <span class="coupon_detail_all">${couponList.coupon_regdate} ~ ${couponList.coupon_enddate}</span>
	      </div>   
 		</c:if>
 		</c:forEach>	
 		</c:if>
 		</div> 
 	</div>
 	
 	<div class="pay_select">
 		<h2>최종 결제 수단</h2>
 		<div class="point_pay">
 			<h3>포인트 결제</h3>
 				<div class="point_charging">
 					<b><span class="point_detail">${member.point}P</span></b>
 					<button class="point_charge" onclick="location.href='${pageContext.request.contextPath}/member/pointCharge'">포인트 충전</button>
 			</div>
 		</div>
 	</div>
 	
 	<div class="pay_decision">
 		<div class="pay_origin">
 			<span>티켓 금액</span>
 			<span><strong class="payMoney" style="font-size: 1.15em;">${payMoney}</strong>원</span>
 		</div>
 		<div class="pay_discount">
 			<span>할인 금액</span>
 			<span>- <strong class="discount-amount" style="font-size: 1.15em;">0</strong>원</span>
 		</div>
 		<div class="pay_total">
 			<span>결제 금액</span>
 			<span>총 <strong class="final-amount" style="font-size: 1.15em;">${payMoney}</strong>원</span>
 		</div>
 		<div class="pay_button">
 		<form action="${pageContext.request.contextPath}/movie/confirmPayment" method="post" id="paymentForm">
 				<input type="hidden" name="mt_num" value="${movieInfoList[0].mt_num}">
 				<input type="hidden" name="ticketNumber" value="${ticketNumber}">
 				<input type="hidden" name="selectedSeats" value="${selectedSeats}">
 				<input type="hidden" id="seatNum" name="seatNum" value="${seatNum}">
 				<input type="hidden" id="m_code" name="m_code" value="${movieInfoList[0].m_code}">
 				<input type="hidden" id="mc_num" name="mc_num" value="">
				<input type="hidden" id="userPoints" name="userPoints" value="${member.point}">
 			<input type="hidden" id="finalAmountInput" name="finalAmount" value="${payMoney}">
 			<input type="button" value="결제하기" class="pay_btn">
 			</form>
 		</div>
 	</div>
 </div>
</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('.coupon-select').forEach(function(coupon) {
        coupon.addEventListener('change', function() {
            updateDiscount();
            document.getElementById('mc_num').value = coupon.value; // 쿠폰 번호 설정
        });
    });

    function updateDiscount() {
        let totalDiscount = 0;
        document.querySelectorAll('.coupon-select:checked').forEach(function(coupon) {
            totalDiscount += parseInt(coupon.getAttribute('data-coupon'));
        });

        let payMoney = parseInt(document.querySelector('.payMoney').textContent.replace(/[^0-9]/g, ''));
        let finalAmount = payMoney - totalDiscount;

        document.querySelector('.discount-amount').textContent = totalDiscount.toLocaleString();
        document.querySelector('.final-amount').textContent = finalAmount.toLocaleString();
        document.getElementById('finalAmountInput').value = finalAmount;
    }

    document.querySelector('.pay_btn').addEventListener('click', function(event) {
        event.preventDefault();
        let finalAmount = parseInt(document.getElementById('finalAmountInput').value);
        let userPoints = parseInt(document.querySelector('.point_detail').textContent.replace(/[^0-9]/g, ''));

        if (userPoints < finalAmount) {
            alert('포인트가 부족합니다.');
        } else {
            alert('결제가 완료되었습니다.');
            document.getElementById('paymentForm').submit();
        }
    });
});

</script>

