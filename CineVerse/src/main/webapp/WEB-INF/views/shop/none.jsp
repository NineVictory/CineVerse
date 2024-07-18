<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 벌스샵 찜 메뉴 시작 -->
<c:if test="${not empty list}">
<div class="shop-pay-nav">
	<div class="rcNav">
		<div class="price-box">
			<span>추천 상품</span>
		</div>
		<div class="price-line">
			<hr size="3px" color="black" width="88%">
		</div>
		<div class="price-detail">
			<c:forEach var="rc" items="${recommand}">
				<div class="rc-box">
					<img src="${pageContext.request.contextPath}/upload/${rc.p_filename}" onclick="location.href='shopDetail?p_num=${rc.p_num}'" class="rc-img">
					${rc.p_name}
				</div>
			</c:forEach>
		</div>
	</div>
</div>
</c:if>

<!-- 벌스샵 찜 메뉴 끝 -->