<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 벌스샵 결제 메뉴 시작 -->
<c:if test="${count>0}">
<div class="shop-pay-nav">
	<div class="shopNav">
		<div class="price-box">
			<span>최종 결제 금액</span>
		</div>
		<div class="price-line">
			<hr size="3px" color="black" width="88%">
		</div>
		<div class="price-detail">
			<div class="total_count">
			      <span>총 수량</span><span class="quantity cc">${total_count}개</span>
			  </div>
			  <div class="total_price">
			      <span>총 상품 금액</span><span class="tt">${total}원</span>
			  </div>
			<div class="coupon_discount">
				<span>쿠폰 할인</span><span class="cr">0원</span>
			</div>
			<div class="deliveryfee">
				<span>배송비</span><span>
					<c:if test="${total>=50000}">
						0원
					</c:if>
					<c:if test="${total<50000}">
						3000원
					</c:if>
				</span>
			</div>
		</div>
		<div class="price-line">
			<hr size="3px" color="black" width="88%">
		</div>
		<div class="price-result">
			<span>최종 결제 금액</span>
			<span class="ttt">
			<c:if test="${total>=50000}">
						${total}원
					</c:if>
					<c:if test="${total<50000}">
						${total+3000}원
					</c:if>
			</span>
		</div>
	</div>
	<div class="pay-box">
		<form class="bd">
			<input type="hidden" value="0" name="agree" id="hidden_agree">
			<input type="hidden" value="0" name="a_num" id="hidden_option">
		    <input type="hidden" value="0" name="mc_num">
		    <input type="hidden" name="count" id="hiddenCount">
			<input type="hidden" name="total_count" id="hiddenTotalCount">
			<input type="hidden" name="total" id="hiddenTotal">
		    <input type="submit" value="결제하기" class="realBuy">
		</form>
	</div>
</div>
</c:if>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const prices = document.querySelectorAll(".price-detail span, .price-result span");
	    
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
</script>
<!-- 벌스샵 결제 메뉴 끝 -->
