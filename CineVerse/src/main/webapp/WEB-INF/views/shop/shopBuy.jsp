<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 벌스샵 결제 시작 -->
<div class="main_content">
	<div class="buy-main">
		<h2>결제하기</h2>
		<span>배송지 정보</span> 
		<div class="add-address">추가</div>
		<%-- <form:form action="shopPay" id="shop_pay" method="post">
		받는 사람  <form:input path="a_name"/>
		연락처 <form:input path="a_phone"/>
		우편번호 <form:input path="a_zipcode"/>
		주소 <form:input path="a_address1"/>
		상세 주소 <form:input path="a_address2"/>
		</form:form> --%>
		<%-- <form action="shopPay" id="shop_pay" method="post">
			<div class="address-form">
				<ul>
					<li>받는 사람  <input type="text" name="a_name"></li>
					<li>연락처 <input type="text" name="a_phone"></li>
					<li>우편번호 <input type="text" name="a_zipcode"></li>
					<li>주소 <input type="text" name="a_address1"></li>
					<li>상세 주소 <input type="text"  name="a_address2"></li>
				</ul>
			</div>
		</form> --%>
	<form action="shopPay" id="shop_pay" method="post">
	    <div class="select-address">
	    	<ul>
		        <li><input type="radio" name="address" value="a_num1" checked> <span>기본</span></li>
		        <li class="address-box">
		        	<div class="address-list">
			        	<span class="a_zipcode">(11223)</span>
			        	<p class="a_address1"> &nbsp;&nbsp;경기도 성남시 분당구 저쩌구</p> 
			        	<p class="a_address2"> &nbsp;&nbsp;308동 1803호</p>
		        	</div>
		        </li>
		        <li><input type="radio" name="address" value="a_num2"> <span>집</span></li>
		        <li class="address-box">
		        	<div class="address-list">
			        	<span class="a_zipcode">(11223)</span>
			        	<p class="a_address1"> &nbsp;&nbsp;경기도 성남시 분당구 저쩌구</p> 
			        	<p class="a_address2"> &nbsp;&nbsp;308동 1803호</p>
		        	</div>
		        </li>
		        <li><input type="radio" name="address" value="a_num3"><span>학교</span></li>
		        <li class="address-box">
		        	<div class="address-list">
			        	<span class="a_zipcode">(11223)</span>
			        	<p class="a_address1"> &nbsp;&nbsp;경기도 성남시 분당구 저쩌구</p> 
			        	<p class="a_address2"> &nbsp;&nbsp;308동 1803호</p>
		        	</div>
		        </li>
	        </ul>
	    </div>
	    <div class="order-product">
	    	<div class="order-header">
				<h3>주문 상품 <span class="order_quantity">1건</span></h3>
				<hr size="4px" color="black" width="53%">
			</div>	    
			<div class="order-body">
				 <span class="order-category"> MARVEL</span>
				<hr size="2px" color="#969696" width="53%">
				<div class="product-list">
					<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠" >
					<div class="product-name">
						<span>클래식 티셔츠(아이보리)</span>
						<p>클래식 티셔츠(아이보리)&nbsp; <span>1개</span></p>
					</div>
					<p>가격 <span>39,000원</span></p>
				</div>
				<hr size="4px" color="black" width="53%">	
			</div>
	    </div>
	    
	
 	<div class="pay_coupon">
 		<h2>할인 적용</h2>
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
 					<button class="point_charge">포인트 충전</button>
 			</div>
 		</div>
 		<p>결제 내용에 동의합니다. <input type="checkbox"></p>
 	</div>
 	
	</form>

</div>
	
</div>
<!-- 벌스샵 결제 끝-->
