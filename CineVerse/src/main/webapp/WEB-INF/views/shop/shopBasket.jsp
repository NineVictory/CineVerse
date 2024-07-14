<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/product.my.basket.js"></script>
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
            		<c:if test="${product.pb_status==1}">
						<input type="checkbox" class="product-select" checked data-pnum="${product.p_num}" data-pprice="${product.p_price}" data-pbquantity="${product.pb_quantity}" data-mnum="${product.mem_num}">
						<div class="order-product">
		                    <div class="order-header">
		                        <hr size="4px" color="black" width="53%">
		                    </div>	    
		                    <div class="order-body">
								<div class="h-b">
			                        <span class="nn"> 
										<c:if test="${product.p_category == 1}"> MARVEL </c:if>
										<c:if test="${product.p_category == 2}"> DISNEY </c:if>
										<c:if test="${product.p_category == 3}"> DISNEY PRINCESS </c:if>
										<c:if test="${product.p_category == 4}"> PIXAR </c:if>
										<c:if test="${product.p_category == 5}"> Studio GHIBLI </c:if>
										<c:if test="${product.p_category == 6}"> Warner Bros. </c:if>
										<c:if test="${product.p_category == 7}"> Universal Studio </c:if>
									</span>
								</div>
		                        <hr size="2px" color="#969696" width="53%">
		                        <div class="product-list">
		                            <img src="${pageContext.request.contextPath}/upload/${product.p_filename}">
		                            <div class="product-name">
		                                <h3>${product.p_name}</h3>
		                            </div>
		                            <p>가격 <span>${product.p_price}원</span></p>
		                        </div>
		                        <div class="basket-result">
		                            <p >${product.p_name} - ${product.pb_quantity}개</p>
		                        </div>
								<div class="button-div">
									<div class="update-btn" data-num="${product.pb_num}" data-memnum="${product.mem_num}">장바구니 수량 변경</div>
									<div class="delete-btn" data-num="${product.pb_num}" data-memnum="${product.mem_num}">장바구니 삭제</div>
								</div>
		                        <!-- <hr size="4px" color="black" width="53%">	 -->
		                    </div>
		                </div>
					</c:if>
                </c:forEach >
            </c:if>
            
        </form>
        <c:forEach var="product" items="${list}">
        <c:if test="${product.pb_status==2}">
			<div class="noquantity">
						<div class="order-product">
		                    <div class="order-header">
								<hr size="4px" color="black" width="53%">
		                    </div>	    
		                    <div class="order-body" style="margin-left:30px;">
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
		                            <p style="text-decoration-line: line-through; color:#FF5151;">${product.p_name} - ${product.pb_quantity}개 재고부족</p>
		                        </div>
								<div class="button-div">
									<div class="update-btn" data-num="${product.pb_num}" data-memnum="${product.mem_num}">장바구니 수량 변경</div>
									<div class="delete-btn" data-num="${product.pb_num}">장바구니 삭제</div>
								</div>
		                    </div>
		                </div>
						</div>
		               </c:if>
					   
                </c:forEach >
				 <hr size="6px" color="black" width="83%" style="margin-right:180px;">
        <c:if test="${not empty list}">
        <div class="basket-price">
             <p>
                 <span class="ptt">상품 금액 ${total}원</span> 
                 <span> + </span>
                 <span class="pdd"> 배송비
					<c:if test="${total>=50000}">0</c:if>
					<c:if test="${total<50000}">3000</c:if>원
				</span>
                 <span> + </span>
                 <span class="ttt"><c:if test="${total>=50000}">${total}원</c:if>
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
