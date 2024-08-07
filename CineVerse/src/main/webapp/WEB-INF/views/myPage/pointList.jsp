<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 나의 포인트 내역 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">나의 포인트 내역</span>
	</div>
	
	<div class="point_box_now">
		<div class="consult_content">
			<div class="my_consult">
				<div class="myPage_point_now">보유 포인트 </div>
				<div class="myPage_point_count">${member.point }P</div>
			</div>
		</div>
	</div>
	
	<c:forEach var="point" items="${list }">
		<div class="point_box_rep">
		<div class="consult_content">
			<div class="my_consult">
				<div class="my_point_date">${point.ph_date} </div>
				<div class="my_consult_title">
					<c:if test="${point.ph_payment == 'kakaopay' }">카카오페이</c:if>
					<c:if test="${point.ph_payment == 'tosspay' }">토스페이</c:if>
					<c:if test="${point.ph_payment == 'goods' }">굿즈 구매</c:if>
					<c:if test="${point.ph_payment == 'membership' }">멤버십 구독</c:if>
					<c:if test="${point.ph_payment == '구독권 환불' }">멤버십 구독취소</c:if>
					<c:if test="${point.ph_payment == '예매환불' }">예매 취소</c:if>
					<c:if test="${point.ph_payment == '영화 예약' }">영화 예매</c:if>
					<c:if test="${point.ph_payment == '상품환불' }">상품 환불</c:if>
				</div>
				<div class="my_point_now">
				<c:choose>
					<c:when test="${point.ph_type == 0}">환불</c:when>
					<c:when test="${point.ph_type == 1}">결제</c:when>
					<c:when test="${point.ph_type == 2}">충전</c:when>
					<c:when test="${point.ph_type == 4}">환불</c:when>
				</c:choose>
				</div>
			</div>
			<div class="my_point_count">
				<div>
				<c:choose>
					<c:when test="${point.ph_type == 0 }">+</c:when>
					<c:when test="${point.ph_type == 1 }">-</c:when>
					<c:when test="${point.ph_type == 2 }">+</c:when>
					<c:when test="${point.ph_type == 4 }">+</c:when>
				</c:choose>
				${point.ph_point}P</div>
			</div>
		</div>
	</div>
	<hr size="1" class="point_line">
	</c:forEach>
</div>
<!-- 나의 포인트 내역 끝 -->
