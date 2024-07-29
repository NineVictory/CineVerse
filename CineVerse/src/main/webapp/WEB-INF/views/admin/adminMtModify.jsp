<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>


<div class="page-container">
<div class="movie_modify_form">
	<h2>영화시간표 수정</h2>
	<form:form action="adminMtModify" enctype="multipart/form-data" id="modifyMovie_form" modelAttribute="movieTimeVO">
	<input type="hidden" name="mt_num" value="${movieTimeVO.mt_num}">
	<ul>
		<li>
			<h2>${mt_num} 수정</h2>
		</li>
		<li>
			<label for="mt_date">날짜</label>
			<form:input path="mt_date" type = "date" class="input-check"/>
			<form:errors path="mt_date" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>	
			<label for="mt_start">시작 시간</label>
			<form:input path="mt_start" class="input-check"/>
			<form:errors path="mt_start" element="div" cssClass="error-message"></form:errors>
		</li>
		<li>	
			<label for="mt_end">종료 시간</label>
			<form:input path="mt_end" class="input-check"/>
			<form:errors path="mt_end" element="div" cssClass="error-message"></form:errors>
		</li>
		
		
	</ul>
	<div class="btn_display_set">
		<form:button id="submit_btn">등록하기</form:button>
	</div>
</form:form>
	
</div>
</div>

