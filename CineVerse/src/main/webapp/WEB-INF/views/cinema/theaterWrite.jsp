<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상영관 등록 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2>상영관 등록</h2>
	<form:form action="theaterWrite" id="theater_write"  modelAttribute="theaterVO">
		<ul>
			<li>			
				<form:input path="th_name" placeholder="몇 관인지 입력하세요"/>
				<form:errors path="th_name" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="th_position" placeholder="위치를 입력하세요"/>
				<form:errors path="th_position" cssClass="error-color"/>
			</li>		
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">등록</form:button>
			<input type="button" value="목록" class="default-btn" onclick="location.href='cinemaList2'">
		</div>                           
	</form:form>

</div>
<!-- 상영관 등록 끝 -->