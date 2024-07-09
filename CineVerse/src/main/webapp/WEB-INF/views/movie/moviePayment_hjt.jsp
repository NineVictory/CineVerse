<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-container">
  <div class="payment-page">	
    <!-- 결제 정보 시작 -->
    <h3>결제 정보</h3>
    <div class="content-box">
      <div class="payment-box">
      	<img alt="영화1" src="${pageContext.request.contextPath}/images/hjt/포스터1.jpg">
      </div>
    </div>
    <hr size="1" noshade="noshade" width="100%">
    <!-- 결제 정보 끝 -->
 
    <!-- 쿠폰 적용 시작 -->
    <h3>쿠폰 적용</h3>
    <div class="content-box">
      <div class="cuppon-box">
        <div class="cuppon-button">
          <input type="button" value="보유 쿠폰" onclick="">
        </div>
      </div>
    </div>
    <hr size="1" noshade="noshade" width="100%">
    <!-- 쿠폰 적용 끝 -->

    <!-- 결제 수단 시작 -->
    <h3>결제 수단</h3>
    <div class="content-box">
      <div class="point-box">
        <h4>포인트 결제</h4>
        <div class="point-button">
          <input type="button" value="충전하기" onclick="">
        </div>
      </div>
    </div>
    <hr size="1" noshade="noshade" width="100%">
    <!-- 결제 수단 끝 -->

    <!-- 최종 결제 금액 시작 -->
    <h3>최종 결제 금액</h3>
    <div class="content-box">
      <div class="finalpay-box">
      
      </div>
    </div>
    <div class="final-button">
    <input type="button" value="결제하기" onclick="">
    </div>
    <!-- 최종 결제 금액 끝 -->
  </div>
</div>
