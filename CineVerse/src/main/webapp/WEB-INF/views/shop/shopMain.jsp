<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- 벌스샵 시작 -->
<div class="shop-page">
	<div class="shop-main">
		<form action="shopMain" id="shop_search" method="get">
			<ul>
				<li>
					<input type="hidden" name="p_category" value="${param.p_category}">
					<input type="hidden" name="keyfield" id="keyfield" value="1">
					<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
					<input type="submit" value="" style="background-image: url('${pageContext.request.contextPath}/images/search_icon.png');">
				</li>
			</ul>
		</form>
			<div class="select-wrapper">
			<select name="shopOrder" id="shopOrder">
				<option value="1" <c:if test="${param.shopOrder == 1 }">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.shopOrder == 2 }">selected</c:if>>구매순</option>
				<option value="3" <c:if test="${param.shopOrder == 3 }">selected</c:if>>후기순</option>
				<option value="4" <c:if test="${param.shopOrder == 4 }">selected</c:if>>평점순</option>
				<option value="5" <c:if test="${param.shopOrder == 5 }">selected</c:if>>관심상품순</option>
			</select>	
			</div>
			<script type="text/javascript">
			 	$('#shopOrder').change(function(){
			 		location.href='shopMain?p_category=${param.p_category}&keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&shopOrder='+$('#shopOrder').val()
			 	});
			</script>
	</div>
	<div class="shop-product-page">
		<div class="shop-product">
			<c:if test="${count==0}">
				등록된 상품 없음
			</c:if>
			<c:if test="${count > 0}">
				<c:forEach var="product" items="${productList}">
					<div class="product-item" onclick="window.location.href='shopDetail?p_num=${product.p_num}'">
						<img src="${pageContext.request.contextPath}/images/cje/product.png" alt="티셔츠">
						<h3>
							<c:if test="${product.p_category == 1}"> MARVEL </c:if>
							<c:if test="${product.p_category == 2}"> DISNEY </c:if>
							<c:if test="${product.p_category == 3}"> DISNEY PRINCESS </c:if>
							<c:if test="${product.p_category == 4}"> PIXAR </c:if>
							<c:if test="${product.p_category == 5}"> Studio GHIBLI </c:if>
							<c:if test="${product.p_category == 6}"> Warner Bros. </c:if>
							<c:if test="${product.p_category == 7}"> Universal Studio </c:if>
						</h3>
						<p>${product.p_name}</p>
						<p><span class="product-price">${product.p_price}</span>원</p>
					</div>
				</c:forEach>
			</c:if>
		</div>		
	</div>				
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 모든 제품의 가격 요소들을 가져와서 처리
        const productPrices = document.querySelectorAll(".product-price");

        productPrices.forEach(function(element) {
            let price = parseInt(element.textContent.replace(/[^0-9]/g, '')); // 숫자만 추출하여 정수로 변환
            element.textContent = addCommas(price); // 포맷팅된 가격으로 변경
        });

        // 함수: 3자리 단위 쉼표 추가
        function addCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    });
</script>

<!-- 벌스샵 끝-->