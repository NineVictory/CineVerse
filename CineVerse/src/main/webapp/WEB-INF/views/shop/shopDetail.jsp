<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 벌스샵 디테일 시작 -->
<div class="product-main">
	<div class="product-img">
		<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
	</div>
	<div class="product-info">
		<h1>MARVEL</h1>
		<p>클래식 티셔츠(아이보리)</p>
		<p class="product-price">39,000</p>
	</div>
	<form action="shopBuy" id="shop_buy">
		<ul>
			<li>수량</li>
			<li></li>
		</ul>
	</form>
</div>
<!-- 벌스샵 디테일 끝-->