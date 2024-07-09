<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-container">
<div class="movie_payments">
 <div class="movies_info">
 	<div class="movies_poster">
 		<img alt="영화1" src="${pageContext.request.contextPath}/images/hjt/포스터1.jpg" width="180">
 	</div>
 	<div>
 		<div class="movie_title">
		<strong class="tit_info"> 
			<span class="ic_grade gr_all">전체</span>인사이드아웃 2 (2D 자막)
		</strong> 
	</div>
		<div class="reserved_info">
 		<ul class="movie_reserve_info">
 			<li><b>일시</b></li>
 			<li style="margin-bottom: 4px;">2024-07-10(수) 12:00 ~ 13:56</li>
 			<li><b>영화관</b></li>
 			<li style="margin-bottom: 4px;">월드타워 10관 2D</li>
 			<li><b>인원</b></li>
 			<li>1명</li>
 		</ul>	
 	</div>
 	<div class="reserved_space">
 		좌석 <br>
 		<strong>H10</strong>
 	</div>
 	</div>
	
 </div>
 
 <div class="payments_all">
 	<h2>할인 적용</h2>
 	<div class="pay_coupon">
 		<h3>쿠폰</h3>
 		<div class="coupon_list">
 			<div class="coupon_detail">
 				<span class="coupon_name">영화 (2D) 할인권</span>
 				<span class="coupon_detail_all">14000원 이상 결제시 사용 가능</span>
 				<span class="coupon_detail_all">2024.06.09 ~ 2024.07.09 <span class="coupon_time">D - DAY</span></span> 
 			</div>
 			
 			<div class="coupon_detail">
 				<span class="coupon_name">영화 (2D) 할인권</span>
 				<span class="coupon_detail_all">14000원 이상 결제시 사용 가능</span>
 				<span class="coupon_detail_all">2024.06.09 ~ 2024.07.09 <span class="coupon_time">D - DAY</span></span> 
 			</div>
 			
 			
 		</div>
 	</div>
 	
 	<div class="pay_select">
 		<h2>최종 결제 수단</h2>
 		<div class="point_pay">
 			<h3>포인트 결제</h3>
 				<div class="point_charging">
 					<b><span class="point_detail">15,0000P</span></b>
 					<input type="button" value="포인트 충전" class="point_charge">
 			</div>
 		</div>
 	</div>
 	
 	<div class="pay_decision">
 		<div class="pay_origin">
 			<span>상품 금액</span>
 			<span><strong style="font-size: 1.15em;">14000</strong>원</span>
 		</div>
 		<div class="pay_discount">
 			<span>할인 금액</span>
 			<span>- <strong style="font-size: 1.15em;">5500</strong>원</span>
 		</div>
 		<div class="pay_total">
 			<span>결제 금액</span>
 			<span>총 <strong style="font-size: 1.15em;">8500</strong>원</span>
 		</div>
 		<div class="pay_button">
 			<input type="button" value="결제하기" class="pay_btn">
 		</div>
 	</div>
 </div>
</div>
</div>
