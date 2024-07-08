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
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const quantityInput = document.querySelector(".quantity-input");
    const quantityDownBtn = document.querySelector(".quantity-down");
    const quantityUpBtn = document.querySelector(".quantity-up");
    const productPrice = document.querySelector(".product-price"); // 상품 가격 요소 선택
    const totalPriceSpan = document.querySelector(".showPrice span"); // 총 상품 금액 표시 요소 선택
    let totalPrice = parseInt(productPrice.textContent.replace(',', '')); // 초기 상품 가격 설정

    // 함수: 3단위 쉼표 추가
    function addCommas(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    quantityDownBtn.addEventListener("click", function() {
        const currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
            totalPrice -= parseInt(productPrice.textContent.replace(',', '')); // 가격 감소
            totalPriceSpan.textContent = addCommas(totalPrice); // 총 상품 금액 업데이트
        }
    });

    quantityUpBtn.addEventListener("click", function() {
        const currentValue = parseInt(quantityInput.value);
        quantityInput.value = currentValue + 1;
        totalPrice += parseInt(productPrice.textContent.replace(',', '')); // 가격 증가
        totalPriceSpan.textContent = addCommas(totalPrice); // 총 상품 금액 업데이트
    });
});
</script>
<!-- 벌스샵 디테일 끝-->
