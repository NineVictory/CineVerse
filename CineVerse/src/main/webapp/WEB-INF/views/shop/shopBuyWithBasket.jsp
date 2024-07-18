<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/product.pay.basket.js"></script>
<!-- 벌스샵 결제 시작 -->
<div class="main_content">
	<div class="buy-main">
		<!-- css 변경 필요 -->
		<c:if test="${addressCount==0}">
			배송지 없으면 주문이 불가합니다.
				    	<div class="add-address" onclick="location.href='${pageContext.request.contextPath}/myPage/addressList'">배송지 추가하러 가기</div>		
	    </c:if>
	    <c:if test="${addressCount>0}">
		<h2>결제하기</h2>
		<span>배송지 정보</span> 
		<div class="add-address" onclick="location.href='${pageContext.request.contextPath}/myPage/addressList'">추가</div>
	<form action="shopPay" id="shop_pay" method="post">
	    <div class="select-address">
	    	
	    	<ul>
	    		<c:forEach var="a" items="${address}">
	    			<c:if test="${a.a_default==1}">
		    			<li><input type="radio" name="a_num" value="${a.a_num}" checked> <span>${a.a_name}</span></li>
			        	<li class="address-box">
			        		<div class="address-list">
				        	<span class="a_zipcode">(${a.a_zipcode})</span>
				        	<p class="a_address1"> &nbsp;&nbsp;${a.a_address1}</p> 
				        	<p class="a_address2"> &nbsp;&nbsp;${a.a_address2}</p>
			        	</div>
			        	</li>
		        	</c:if>
		        	<c:if test="${a.a_default!=1}">
		        		<li><input type="radio" name="a_num" value="${a.a_num}"> <span>${a.a_name}</span></li>
			        	<li class="address-box">
			        		<div class="address-list">
				        	<span class="a_zipcode">(${a.a_zipcode})</span>
				        	<p class="a_address1"> &nbsp;&nbsp;${a.a_address1}</p> 
				        	<p class="a_address2"> &nbsp;&nbsp;${a.a_address2}</p>
			        	</div>
			        	</li>
		        	</c:if>
	    		</c:forEach>
	        </ul>
	    </div>
	    <div class="order-product">
	    	<div class="order-header">
				<h3>주문 상품 <span class="order_quantity">${count}건</span></h3>
				<hr size="4px" color="black" width="53%">
			</div>	    
			<c:forEach var="product" items="${basketList}">
				<div class="order-body">
					 <span class="order-category">
					 	<c:if test="${product.p_category == 1}"> MARVEL </c:if>
						<c:if test="${product.p_category == 2}"> DISNEY </c:if>
						<c:if test="${product.p_category == 3}"> DISNEY PRINCESS </c:if>
						<c:if test="${product.p_category == 4}"> PIXAR </c:if>
						<c:if test="${product.p_category == 5}"> Studio GHIBLI </c:if>
						<c:if test="${product.p_category == 6}"> Warner Bros. </c:if>
						<c:if test="${product.p_category == 7}"> Universal Studio </c:if>
					 </span>
					<hr size="2px" color="#969696" width="53%">
					<div class="product-list" data-pbnum="${product.pb_num}"> 
						<div class="pimg">
							<img src="${pageContext.request.contextPath}/upload/${product.p_filename}">
						</div>
						<div class="product-name">
			                <h3>${product.p_name} (${product.pb_quantity}개)</h3>
			             </div>
							<p>가격 <span>${product.pb_quantity*product.p_price}원</span></p>
					</div>
					<hr size="4px" color="black" width="53%">	
				</div>
			</c:forEach>
	    </div>
	    
	
 	<div class="pay_coupon">
 		<h2>할인 적용</h2>
 		<h3>쿠폰</h3>
 		
 		<div class="coupon_list">
	 		<c:if test="${member.coupon_cnt == 0 }">
				보유한 쿠폰이 없습니다.
			</c:if>			
			<c:if test="${member.coupon_cnt > 0 }">
				<c:forEach  var="couponList" items="${couponList}">
					<c:if test="${couponList.coupon_where==2}">
						<div style="margin-left:15px; margin-top:20px; margin-bottom:0;">
							<input type="checkbox" class="single-select" name="option" value="${couponList.mc_num}" data-num="${couponList.mc_num}" data-point="${couponList.coupon_sale}" data-nosaletotal="${total}">
						</div>
			 			<div class="coupon_detail" style="margin-top:0;" >
			 				<span class="coupon_name">${couponList.coupon_name}</span>
			 				<span class="coupon_detail_all">${couponList.coupon_content }</span>
			 				<span class="coupon_detail_all">${couponList.coupon_regdate } ~ ${couponList.coupon_enddate }<!-- <span class="coupon_time">D - DAY</span> --></span> 
			 			</div>
		 			</c:if>
					<c:if test="${couponList.coupon_where==1}">
						<div class="coupon_detail" style="background-color:#BDBDBD">
							<span class="coupon_name">(영화 전용 - 사용 불가) ${couponList.coupon_name}</span>
							<span class="coupon_detail_all">${couponList.coupon_content }</span>
							<span class="coupon_detail_all">${couponList.coupon_regdate } ~ ${couponList.coupon_enddate }<!-- <span class="coupon_time">D - DAY</span> --></span> 
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
 					<button class="point_charge" onclick ="location.href='${pageContext.request.contextPath}/member/pointCharge'">포인트 충전</button>
 			</div>
 		</div>
 		<p>결제 내용에 동의합니다. <input type="checkbox" name="agree"></p>
 	</div>
 	
	</form>
</c:if>
</div>
	
</div>

<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const prices = document.querySelectorAll(".product-list span, .basket-price span, .point_detail");
	    
	    for (let i = 0; i < prices.length; i++) {
	        let element = prices[i];
	        let priceText = element.textContent.trim();
	        let number = parseInt(priceText.replace(/[^0-9]/g, ''));
	        
	        if (!isNaN(number)) {
	            let formattedPrice = addCommas(number);
	            element.textContent = priceText.replace(number, formattedPrice);
	        }
	    }
	
	    function addCommas(number) {
	        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	});
	
	document.querySelectorAll('.single-select').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            if (this.checked) {
                document.querySelectorAll('.single-select').forEach(cb => {
                    if (cb !== this) cb.checked = false;
                });
            }
        });
    });
	
	 document.querySelector('.point_charge').addEventListener('click', function(event) {
         event.preventDefault(); 
     });
</script>

<!-- 벌스샵 결제 끝-->
