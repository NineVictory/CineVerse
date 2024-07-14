<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/myPage.password.js"></script>
<!-- 비밀번호 변경 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">비밀번호 변경</span>
	</div>
	<form:form action="passwdChange" id="member_modify"
		modelAttribute="myPageVO">

		<div class="login_form_inputs">

			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:password path="now_passwd"
						placeholder="현재 비밀번호 입력(영문,숫자만 4~12자)" class="input_style" />
				</div>
				<form:errors element="div" path="now_passwd" cssClass="error-color" />
			</div>

			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:password path="mem_passwd"
						placeholder="변경할 비밀번호 입력(영문,숫자만 4~12자)" class="input_style" />
				</div>
				<form:errors element="div" path="mem_passwd" cssClass="error-color" />
			</div>

			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<input type="password" id="confirm_passwd" placeholder="비밀번호 확인"
						class="input_style">
				</div>
				<div id="message_password" class="error-color"></div>
			</div>

			<div id="captcha_div">
				<img src="getCaptcha" id="captcha_img" width="200" height="90">
			</div>
			<input type="button" value="새로고침" id="reload_btn">
			<script type="text/javascript">
				$(function() {
					$('#reload_btn')
							.click(
									function() {
										$
												.ajax({
													url : 'getCaptcha',
													type : 'get',
													success : function() {
														$('#captcha_div')
																.load(
																		location.href
																				+ ' #captcha_div');
													},
													error : function() {
														alert('네트워크 오류 발생')
													}
												})
									});
				});
			</script>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="captcha_chars" placeholder="캡챠 문자 확인"
						class="input_style" />
				</div>
				<form:errors path="captcha_chars" cssClass="error-color" />

			</div>

			<div class="modify_btn_all">
				<form:button class="user_modify_btn">변경하기</form:button>
			</div>
		</div>
	</form:form>
</div>
