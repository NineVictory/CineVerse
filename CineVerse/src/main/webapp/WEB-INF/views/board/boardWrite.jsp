<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="page-main">
	<h2>글쓰기</h2>
	<form:form action="write" id="board_register" enctype="multipart/form-data" modelAttribute="boardVO">
		<ul>
			<li>
				<form:label path="category">분류</form:label>
				<form:select path="cb_type">
					<option disabled="disabled">선택하세요</option>
					<form:option value="1">영화톡톡</form:option>
					<form:option value="2">양도/교환</form:option>
				</form:select>
				<form:errors path="cb_type" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="cb_title" placeholder="제목을 입력해주세요"/>
				<form:errors path="cb_title" cssClass="error-color"/>
			</li>
			<li>
				<form:textarea path="cb_content" placeholder="내용을 입력해주세요"/>
				<form:errors path="cb_content" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="upload">파일업로드</form:label>
				<input type="file" name="upload" id="upload"><%--반드시 upload로--%>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="default-btn">등록</form:button>
			<input type="button" value="목록" class="default-btn" onclick="location.href='list'">
		</div>
	</form:form>
</div>