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
    </c:forEach>
 	</div>
 	<div class="reserved_space">
 		<p>인원: ${ticketNumber}</p>
    	<p>선택한 좌석: ${selectedSeats}</p>
    	<p>티켓 금액: <span class="payMoney">${payMoney}</span>원</p>
    	<p>회원 이름: ${member.mem_name}</p>
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
 		<form action="${pageContext.request.contextPath}/movie/confirmPayment" method="post">
 				<input type="hidden" name="mt_num" value="${movieInfoList[0].mt_num}">
 				<input type="hidden" name="ticketNumber" value="${ticketNumber}">
 				<input type="hidden" name="selectedSeats" value="${selectedSeats}">
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
    // 페이지가 로드된 후 DOMContentLoaded 이벤트가 발생하면 실행되는 함수
    // 쿠폰 선택 시 할인 금액 반영
    document.querySelectorAll('.coupon-select').forEach(function(coupon) {
        // 모든 쿠폰 선택 체크박스에 대해 이벤트 리스너를 추가
        coupon.addEventListener('change', function() {
            // 체크박스의 상태가 변경될 때마다 updateDiscount 함수 호출
            updateDiscount();
        });
    });

    function updateDiscount() {
        let totalDiscount = 0; // 총 할인 금액을 저장할 변수 초기화

        // 선택된 (체크된) 모든 쿠폰 선택 체크박스를 순회
        document.querySelectorAll('.coupon-select:checked').forEach(function(coupon) {
            // 각 쿠폰의 할인 금액을 가져와서 정수로 변환 후 총 할인 금액에 더함
            totalDiscount += parseInt(coupon.getAttribute('data-coupon'));
        });

        // 결제 금액을 가져옴 (원 단위를 제외하고 숫자만 추출하여 정수로 변환)
        let payMoney = parseInt(document.querySelector('.payMoney').textContent.replace(/[^0-9]/g, ''));
        // 최종 결제 금액 계산 (결제 금액에서 총 할인 금액을 뺌)
        let finalAmount = payMoney - totalDiscount;

        // 총 할인 금액을 표시하는 요소의 텍스트 내용을 업데이트
        document.querySelector('.discount-amount').textContent = totalDiscount.toLocaleString();
        // 최종 결제 금액을 표시하는 요소의 텍스트 내용을 업데이트
        document.querySelector('.final-amount').textContent = finalAmount.toLocaleString();
        // 최종 결제 금액을 숨겨진 입력 필드에 저장 (서버로 전송될 수 있도록)
        document.getElementById('finalAmountInput').value = finalAmount;
    }
    // 결제 버튼 클릭 시 결제가 완료되었음을 알리는 알림창 표시
    document.querySelector('.pay_btn').addEventListener('click', function(event) {
        event.preventDefault(); // 기본 동작 중단
        alert('결제가 완료되었습니다.');
        document.getElementById('paymentForm').submit(); // 폼 제출
    });
});
</script>

