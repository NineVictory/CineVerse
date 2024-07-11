<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 영화등록 시작 -->
<div class="page-main">
	<h2>영화등록</h2>
	<form:form action="write" id="movie_register"
				enctype="multipart/form-data"
	                            modelAttribute="MovieVO">
		<ul>
			<li>
				<form:label path="movie-title">제목</form:label>
				<form:input path="movie-title"/>
				<form:errors path="movie-title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="movie-content">내용</form:label>
				<form:textarea path="movie-content"/>
				<form:errors path="movie-content" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="upload">파일 업로드</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul> 
		<div>
			<form:button class="movie-btn">전송</form:button>
			<input type="button" value="목록"
			  class="movie-btn"
			  onclick="location.href='${pageContext.request.contextPath}/admin/adminMain'">
		</div>                           
	</form:form>
</div>
<!-- 게시판 글쓰기 끝 -->
