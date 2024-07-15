<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 좌석 등록 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2>좌석 등록</h2>
	<form:form action="seatWrite" id="seat_write" modelAttribute="seatVO">
		<ul>
			
			<li>
				<form:label path="seat_rank">좌석 등급</form:label>
				<form:select path="seat_rank">
					<option disabled="disabled" selected>선택하세요</option>
						<form:option value="1">일반석</form:option>
						<form:option value="2">VIP석</form:option>
						<form:option value="3">장애인석</form:option>
						<form:option value="4">커플석</form:option>
				</form:select>
				<form:errors path="seat_rank" cssClass="error-color"/>                             
			</li>
			<li>
				<form:input path="seat_row" placeholder="좌석 가로행을 입력하세요"/>
				<form:errors path="seat_row" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="seat_column" placeholder="좌석 세로열을 입력하세요"/>
				<form:errors path="seat_column" cssClass="error-color"/>
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">등록</form:button>
			<input type="button" value="목록" class="default-btn" onclick="location.href='seatWrite'">
		</div>                           
	</form:form>
</div>
<!-- 좌석 등록 끝 -->