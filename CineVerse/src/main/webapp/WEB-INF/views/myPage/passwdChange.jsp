<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/myPage.password.js"></script> --%>
<div class="myPage_main">
	<div class="myPage_title">비밀번호 변경</div>
	<form:form action="modifyUser" id="member_modify" modelAttribute="myPageVO">
		<div class="login_form_inputs">
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:label path="mem_passwd">현재 비밀번호</form:label>
					<form:password path="mem_passwd" placeholder="현재 비밀번호를 입력해주세요" class="input_style" />
				</div>
				<form:errors element="div" path="mem_passwd" cssClass="error-color" />
			</div>
			
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:password path="mem_passwd" placeholder="새비밀번호를 입력해주세요" class="input_style" />
				</div>
				<form:errors element="div" path="mem_passwd" cssClass="error-color" />
			</div>
			
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:password path="mem_passwd" placeholder="비밀번호 확인"
						class="input_style" />
				</div>
				<form:errors element="div" path="mem_passwd" cssClass="error-color" />
			</div>
			
			
			<!-- 캡챠 확인 -->
			
			<div class="modify_btn_all">
				<input type="button" value="수정하기" class="user_modify_btn">
			</div>

		</div>

	</form:form>
</div>