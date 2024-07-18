<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/support.main.js"></script>

<!-- 고객센터 메인 -->
<div id="support_main" class="flexbox-p">
	<div class="flexbox-h main-upper-menu">
		<div class="flexbox-p fast-menu">
			<strong>자주 묻는 질문 빠른 검색</strong>
			<div id="search_box">
				<input type="text" class="faq-keyword">
				<button title="검색하기" class="faq-mbutton">검색</button>
			</div>
		</div>
		<div class="flexbox-p fast-menu">
			<strong>1:1 문의</strong>
			<span>24시간 365일 언제든지 문의해주세요</span>
			<a href="consult">문의하기</a>
		</div>
		<div class="flexbox-p fast-menu">
			<strong>내 상담 내역 확인</strong>
			<span>문의하신 내용을 확인하실 수 있습니다</span>
			<a href="${pageContext.request.contextPath}/myPage/consult" target="_blank" rel="noopener noreferrer">문의내역 조회</a>
		</div>
	</div>
	<div class="flexbox-h main-lower-menu flex-start">
		<div class="left-lower-menu">
			<h4>자주찾는 서비스</h4>
			<div class="imenu">
			 <c:if test="${empty user}">
		        <a href="${pageContext.request.contextPath}/member/findId">
		            <span>아이디/<br>비밀번호 찾기 ></span>
		        </a>
		    </c:if>
		    <c:if test="${!empty user}">
		        <a>
		            <span class="disabled">아이디/<br>비밀번호 찾기 ></span>
		        </a>
		    </c:if>
			<%--<a href="${pageContext.request.contextPath}/member/findId" data-user="${user}" class="loginCheck-findId"><span>아이디/<br>비밀번호 찾기 ></span></a>--%>
				<a href="${pageContext.request.contextPath}/myPage/reservation" target="_blank" rel="noopener noreferrer"><span>예매/<br>취소내역 확인 ></span></a>
				<a href="${pageContext.request.contextPath}/myPage/pointList" target="_blank" rel="noopener noreferrer"><span>멤버십 포인트<br> 내역 ></span></a>
				<a href="${pageContext.request.contextPath}/myPage/coupon" target="_blank" rel="noopener noreferrer"><span>관람권/<br>할인 쿠폰 ></span></a>
			</div>
		</div>
		<div class="right-lower-menu">
			<h4 style="display:inline-block;">공지/뉴스</h4> &nbsp;<a href="notice"><img src="">추가버튼</a>
			<table>
				<tr>
					<td><a href="#"><span>최신 공지 5개</span></a><span>등록일</span></td>
				</tr>
				<tr>
					<td><a href="#"><span>CINEVERSE 개인정보처리방침 개정 안내</span></a><span>24.07.11</span></td>
				</tr>
				<tr>
					<td><a href="#"><span>CINEVERSE 개인정보처리방침 개정 안내</span></a><span>24.07.11</span></td>
				</tr>
				<tr>
					<td><a href="#"><span>CINEVERSE 개인정보처리방침 개정 안내</span></a><span>24.07.11</span></td>
				</tr>
				<tr>
					<td><a href="#"><span>CINEVERSE 개인정보처리방침 개정 안내</span></a><span>24.07.11</span></td>
				</tr>
				
			</table>
		</div>
	</div>
</div>