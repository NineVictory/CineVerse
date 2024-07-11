<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 벌스샵 장바구니 시작 -->
<style>
	.pp{
		margin-left: 30px;
	}
</style>
<div class="main_content">
    <div class="buy-main">
        <h2>관심 상품</h2>
            <c:if test="${empty list}">
                <img src="${pageContext.request.contextPath}/images/cje/empty.png" width="500px" style="margin-left:150px; margin-top:50px; cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/shop/shopMain'">
            </c:if>
            <c:if test="${not empty list}">
            	<c:forEach var="product" items="${list}">
						<div class="order-product">
		                    <div class="order-header">
		                        <hr size="4px" color="black" width="53%">
		                    </div>	    
		                    <div class="order-body">
		                        <span class="nn"> 
									<c:if test="${product.p_category == 1}"> MARVEL </c:if>
									<c:if test="${product.p_category == 2}"> DISNEY </c:if>
									<c:if test="${product.p_category == 3}"> DISNEY PRINCESS </c:if>
									<c:if test="${product.p_category == 4}"> PIXAR </c:if>
									<c:if test="${product.p_category == 5}"> Studio GHIBLI </c:if>
									<c:if test="${product.p_category == 6}"> Warner Bros. </c:if>
									<c:if test="${product.p_category == 7}"> Universal Studio </c:if>
								</span>
		                        <hr size="2px" color="#969696" width="53%">
		                        <div class="product-list">
		                            <img src="${pageContext.request.contextPath}/upload/${product.p_filename}" onclick="location.href='shopDetail?p_num=${product.p_num}'">
		                            <div class="product-name">
		                                <span>${product.p_name}</span>
		                            </div>
		                            <p class="pp">가격 <span>${product.p_price}원</span></p>
		                        </div>
		                    </div>
		                </div>
                </c:forEach>
            </c:if>
    </div>
</div>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const prices = document.querySelectorAll(".product-list span, .basket-price span");
	    
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
<!-- 벌스샵 장바구니 끝-->
