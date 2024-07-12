<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 벌스샵 장바구니 시작 -->
<div class="main_content">
    <div class="buy-main">
        <h2>장바구니</h2>
        <form action="shopPay" id="shop_pay" method="post">
            <c:if test="${empty list}">
                <img src="${pageContext.request.contextPath}/images/cje/empty.png" width="500px" style="margin-left:150px; margin-top:50px; cursor: pointer;" onclick="location.href='shopDetail?p_num=${product.p_num}'">
            </c:if>
            <c:if test="${not empty list}">
            	<c:forEach var="product" items="${list}">
						<div class="order-product">
		                    <div class="order-header">
		                        <!-- <h3 class="order-category">
									

								</h3> -->
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
		                            <img src="${pageContext.request.contextPath}/upload/${product.p_filename}">
		                            <div class="product-name">
		                                <h3>${product.p_name}</h3>
		                            </div>
		                            <p>가격 <span>${product.p_price}원</span></p>
		                        </div>
		                        <div class="basket-result">
		                            <p >${product.p_name} - ${product.pb_quantity}개</span></p>
		                        </div>
		                        <!-- <hr size="4px" color="black" width="53%">	 -->
		                    </div>
		                </div>
                </c:forEach>
            </c:if>
        </form>
        <c:if test="${not empty list}">
        <div class="basket-price">
             <p>
                 <span>상품 금액 ${total}원</span> 
                 <span> + </span>
                 <span> 배송비
					<c:if test="${total>=50000}">0</c:if>
					<c:if test="${total<50000}">3000</c:if>
					원
				</span>
                 <span> + </span>
                 <span><c:if test="${total>=50000}">${total}원</c:if>
					<c:if test="${total<50000}">${total+3000}원</c:if></span>
            </p>
      	</div>
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
