<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 나의 쿠폰 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">나의 쿠폰 내역</span>
	</div>
	<div class="coupon_box">
		<div class="coupon_info">
			<div class="coupon_in">
				<div>쿠폰 이름</div>
			</div>
			<div class="coupon_in_2">
				<div>사용 기간</div>
			</div>
			<div class="coupon_in_2">
				<div>할인</div>
			</div>
			<div class="coupon_in">사용 조건</div>
		</div>
		<!-- 1:미사용 2:사용 3:만기 -->
		<!-- 쿠폰 반복 -->
		<c:if test="${member.coupon_cnt == 0 }">
		보유한 쿠폰이 없습니다.
		</c:if>
		<c:if test="${member.coupon_cnt > 0 }">
		<c:forEach  var="couponList" items="${couponList}">
			<div class="coupon_info_list">
			<div class="coupon_info_name">
				<div>${couponList.coupon_name }</div>
			</div>
			<div class="coupon_info_date">
				<div>${couponList.coupon_regdate } ~ ${couponList.coupon_enddate }</div>
			</div>
			<c:if test="${couponList.coupon_type == 1 }">
				<div class="coupon_info_date">
					<div>${couponList.coupon_sale}원</div>
				</div>
			</c:if>
			<c:if test="${couponList.coupon_type == 2} ">
				<div class="coupon_info_name">
					<div>${couponList.coupon_sale}%</div>
				</div>
			</c:if>
			<div class="coupon_info_content">
				<div>${couponList.coupon_content }</div>
			</div>
		</div>
		<hr size="1" class="coupon_line">
		</c:forEach>
		</c:if>
	
	</div>
</div>
<!-- 나의 쿠폰 끝 -->