<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 벌스샵 결제 시작 -->
<div class="main_content">
	<div class="buy-main">
		<h2>장바구니</h2>
	<form action="shopPay" id="shop_pay" method="post">
	    <div class="order-product">
	    	<div class="order-header">
				<h3 class="order-category">MARVEL</h3>
				<hr size="4px" color="black" width="53%">
			</div>	    
			<div class="order-body">
				 <span class="nn"> 시네벌스샵 배송</span>
				<hr size="2px" color="#969696" width="53%">
				<div class="product-list">
					<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠" >
					<div class="product-name">
						<span>클래식 티셔츠(아이보리)</span>
						<p>클래식 티셔츠(아이보리)&nbsp; <span>1개</span></p>
					</div>
					<p>가격 <span>39,000원</span></p>
				</div>
				<div class="basket-result">
		    		<p>클래식 티셔츠(아이보리) <span> 2개</span></p>
	    		</div>
	    		<%-- <!-- ----------------- -->
	    		<div class="product-list">
					<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠" >
					<div class="product-name">
						<span>클래식 티셔츠(아이보리)</span>
						<p>클래식 티셔츠(아이보리)&nbsp; <span>1개</span></p>
					</div>
					<p>가격 <span>39,000원</span></p>
				</div>
				<div class="basket-result">
		    		<p>클래식 티셔츠(아이보리) <span> 1개</span></p>
	    		</div> --%>
				<hr size="4px" color="black" width="53%">
				<div class="basket-price">
					<p>
						<span>상품 금액 78,000원</span> 
						<span> + </span>
						<span> 배송비 0원</span>
						<span> + </span>
						<span>주문 금액 78,000원</span>
					</p>
				</div>	
			</div>
	    </div>
	    </form>
	

</div>
	
</div>
<!-- 벌스샵 결제 끝-->
