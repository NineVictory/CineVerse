<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/membership.js"></script>
<!-- 멤버십 구독 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_ship">멤버십 구독</span>
	</div>
		<div class="membership_box">
			<div class="monthly">Monthly</div>
            <div class="membership">MEMBERSHIP</div>
            
            <div class="price_box">
            <div class="price">10,000P</div><div class="month">/monthly</div>
            </div>
            
            <div class="check_box">
            
            <div class="coupon_ship1">
            <div class="check"><img src="${pageContext.request.contextPath}/images/like01.png"width="17"></div>
            <div class="membership_coupon">영화관 쿠폰</div>
            </div>
            
            <div class="coupon_ship1">
             <div class="check"><img src="${pageContext.request.contextPath}/images/like01.png"width="17"></div>
            <div class="membership_coupon">벌스샵 쿠폰</div>
            </div>
            
            <div class="coupon_ship1">
             <div class="check"><img src="${pageContext.request.contextPath}/images/like01.png"width="17"></div>
            <div class="membership_coupon">포토플레이 쿠폰</div>
            </div>
            
            </div>
            <div class="sub_left">
            <!-- mem_membership == 1:구독전 2:구독중-->
            <c:if test="${member.mem_membership==1}">
            	<input type="button" class="sub_btn" value="구독하기" data-mnum="${user.mem_num }">
            </c:if>
            <c:if test="${member.mem_membership==2}">
            	<input type="button" class="sub_btn_2" value="구독중">
            </c:if>
            
            </div>
        </div>
	
	
</div>
<!-- 멤버십 구독 끝 -->