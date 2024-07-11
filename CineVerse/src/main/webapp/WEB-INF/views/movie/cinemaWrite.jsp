<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 영화 등록 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2>영화등록</h2>
	<form:form action="write" id="cinema_write" enctype="multipart/form-data" modelAttribute="cinemaVO">
		<ul>
			<li>
				<form:label path="c_location">지역</form:label>
				<form:select path="c_location">
					<option disabled="disabled" selected>선택하세요</option>
						<form:option value="1">서울</form:option>
						<form:option value="2">경기</form:option>
						<form:option value="3">인천</form:option>
						<form:option value="4">강원</form:option>
						<form:option value="5">대전/충청</form:option>
						<form:option value="6">경상</form:option>
						<form:option value="7">광주/전라</form:option>
				</form:select>
				<form:errors path="c_location" cssClass="error-color"/>                             
			</li>
			<li>			
				<form:input path="c_branch" placeholder="지점명을 입력하세요"/>
				<form:errors path="c_branch" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="c_address" placeholder="주소를 입력하세요"/>
				<form:errors path="c_address" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="c_phone" placeholder="전화번호를 입력하세요"/>
				<form:errors path="c_phone" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="c_theater" placeholder="ㅅ를 입력하세요"/>
				<form:errors path="c_theater" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="c_seat" placeholder="주소를 입력하세요"/>
				<form:errors path="c_seat" cssClass="error-color"/>
			</li>
			<li>
				<form:input path="c_parkable" placeholder="주소를 입력하세요"/>
				<form:errors path="c_parkable" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="upload">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록" class="default-btn" onclick="location.href='list'">
		</div>                           
	</form:form>
</div>
<!-- 게시판 글쓰기 끝 -->