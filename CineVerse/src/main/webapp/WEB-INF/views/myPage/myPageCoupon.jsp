<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 나의 쿠폰 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">나의 쿠폰 내역</span>
		 <select
			class="myCoupon_option">
			<option>사용가능</option>
			<option>사용완료</option>
			<option>기간만료</option>
		</select>
	</div>
	<div class="coupon_box">
		<div class="coupon_info">
			<div class="coupon_in">
				<div>쿠폰 이름</div>
			</div>
			<div class="coupon_in">
				<div>사용 기간</div>
			</div>
			<div class="coupon_in">사용 조건</div>
		</div>
		<!-- 1:미사용 2:사용 3:만기 -->
		<!-- 쿠폰 반복 -->
		<div class="coupon_info_list">
			<div class="coupon_info_name">
				<div>회원가입 쿠폰</div>
			</div>
			<div class="coupon_info_date">
				<div>2024-07-01 ~ 2024-12-31</div>
			</div>
			<div class="coupon_info_content">
				<div>10000원 이상 구매시 배송비 무료 쿠폰</div>
			</div>
		</div>
		<hr size="1" class="coupon_line">
		<!-- 쿠폰 반복 -->
	</div>
</div>
<!-- 나의 쿠폰 끝 -->