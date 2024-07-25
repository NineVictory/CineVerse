<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<div class="page-container">
    <h2>쿠폰 수정</h2>
    <div class="insert_movie_time">
        <form:form action="modifyCoupon" id="insert_form" modelAttribute="couponVO" method="post">
			<input type="hidden" name="coupon_num" value="${couponVO.coupon_num}">

            <ul>
                <li>
                    <label for="coupon_name">쿠폰 이름</label>
                    <input type="text" name="coupon_name" id="coupon_name" class="input-check" placeholder="쿠폰 이름을 입력하세요" required value="${couponVO.coupon_name}">
                </li>
                <li>
                    <label for="coupon_content">쿠폰 내용</label>
                    <input type="text" name="coupon_content" id="coupon_content" class="input-check" placeholder="쿠폰 내용을 입력하세요" value="${couponVO.coupon_content}">
                </li>
                <li>
                    <label for="coupon_sale">할인 금액</label>
                    <input type="number" name="coupon_sale" id="coupon_sale" class="input-check" placeholder="할인 금액을 입력하세요" required value="${couponVO.coupon_sale}">
                </li>
                <li>
                    <label for="coupon_where">쿠폰 유형</label>
                    <select name="coupon_where" id="coupon_where" class="input-check" required>
                        <option value="" disabled>쿠폰 유형을 선택해주세요</option>
                        <option value="1" <c:if test="${couponVO.coupon_where==1}">selected</c:if>>영화 쿠폰</option>
                        <option value="2" <c:if test="${couponVO.coupon_where==2}">selected</c:if>>벌스샵 쿠폰</option>
                    </select>
                </li>
                <li>
                    <label for="coupon_min_amount">최소 금액</label>
                    <input type="number" name="coupon_min_amount" class="input-check" placeholder="쿠폰 사용 최소 금액 조건을 입력하세요 (필요시)" value="${couponVO.coupon_min_amount}">
                </li>
            </ul>
            <div class="btn_display_set">
                <input type="submit" value="수정" id="submit_btn">
            </div>
        </form:form>
    </div>
</div>
