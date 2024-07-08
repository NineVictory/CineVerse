	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<!-- 벌스샵 디테일 시작 -->
	<div class="main_content">
	    <div class="product-main">
	        <div class="product-img">
	            <img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
	        </div>
	        <div class="product-info">
	            <h1>MARVEL</h1>
	            <p>클래식 티셔츠(아이보리)</p>
	            <p class="product-price">39,000원</p>
	            <div class="buy-form">
	                <form action="shopBuy" id="shop_buy">
	                    <span>수량</span>
	                    <div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="1" max="100" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
	                    <div class="showPrice">
	                        총 상품 금액 <span>39,000</span>원
	                    </div>
	                    <div class="shop-submit">
		                    <button>장바구니</button>
		                    <input type="submit" value="바로 구매하기">
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
	    
	    <div class="product-detail">
		     <ul>
	            <li>
	                <a href="?page=detail">
	                    <c:if test="${param.page == 'detail' || param.page == null}">
	                        <b style="color:black;">상세 정보</b>
	                    </c:if>
	                    <c:if test="${param.page != 'detail' && param.page != null}">
	                        상세 정보
	                    </c:if>
	                </a>
	            </li>
	            <li>
	                <a href="?page=review">
	                    <c:if test="${param.page == 'review'}">
	                        <b style="color:black;">리뷰</b>
	                    </c:if>
	                    <c:if test="${param.page != 'review'}">
	                        리뷰
	                    </c:if>
	                </a>
	            </li>
	            <li>
	                <a href="?page=info">
	                    <c:if test="${param.page == 'info'}">
	                        <b style="color:black;">반품/교환 정보</b>
	                    </c:if>
	                    <c:if test="${param.page != 'info'}">
	                        반품/교환 정보
	                    </c:if>
	                </a>
	            </li>
	        </ul>
	        <!-- 상세정보 -->
	        <c:if test="${param.page == 'detail' || param.page == null}">
		        <div class="deliver">
		        	<img src=${pageContext.request.contextPath}/images/cje/deli_pic.png>
		        </div>
		        <div class="product-detail-info">
		        <img src=${pageContext.request.contextPath}/images/cje/detail_pic.png>
		        </div>
	        </c:if>
	        <!-- 리뷰 -->
	        
	        <c:if test="${param.page == 'review'}">
	        	<div class="product-review">
	        		<div class="pReview">
	        			<br><span>사용자 총 평점</span>
	        			<div class="review-star">
	        				<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
	        				<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
	        				<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
	        				<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="reStar">
	        				<img src=${pageContext.request.contextPath}/images/cje/star_no.png class="reStar">
	        			</div>
	        		</div>
	        		<div class="review-container">
	        			<h2>리뷰</h2>
		        			<div class="review-item">
		        				<div class="profile-photo">
		        					<img src=${pageContext.request.contextPath}/images/pmj/myPage_photo.jpg class="review-profile">
		        					<img src=${pageContext.request.contextPath}/images/cje/star_yes.png class="user-star">
		        				</div>
		        			</div>
		        	</div>
	    		</div>
	        </c:if>
	        <!-- 반품 교환 정모 -->
	        <c:if test="${param.page == 'info'}">
	        	<div class="deliver">
	        		<img src=${pageContext.request.contextPath}/images/cje/info_pic.png>
	        	</div>
	        </c:if>
	    </div>
	    
	</div>
	
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const quantityInput = document.querySelector(".quantity-input");
	    const quantityDownBtn = document.querySelector(".quantity-down");
	    const quantityUpBtn = document.querySelector(".quantity-up");
	    const productPrice = document.querySelector(".product-price"); 
	    const totalPriceSpan = document.querySelector(".showPrice span"); 
	    let totalPrice = parseInt(productPrice.textContent.replace(',', '')); 
	
	    // 함수: 3단위 쉼표 추가
	    function addCommas(number) {
	        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	
	    quantityDownBtn.addEventListener("click", function() {
	        const currentValue = parseInt(quantityInput.value);
	        if (currentValue > 1) {
	            quantityInput.value = currentValue - 1;
	            totalPrice -= parseInt(productPrice.textContent.replace(',', '')); 
	            totalPriceSpan.textContent = addCommas(totalPrice); 
	        }
	    });
	
	    quantityUpBtn.addEventListener("click", function() {
	        const currentValue = parseInt(quantityInput.value);
	        quantityInput.value = currentValue + 1;
	        totalPrice += parseInt(productPrice.textContent.replace(',', '')); 
	        totalPriceSpan.textContent = addCommas(totalPrice); 
	    });
	});
	</script>
	<!-- 벌스샵 디테일 끝-->
