<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="myPage_main">
	<div class="myPage_title">개인정보 변경</div>
	<form:form action="modifyUser" id="member_modify" modelAttribute="myPageVO">
		<div class="login_form_inputs">
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="mem_name" placeholder="이름을 입력해주세요"
						class="input_style" autocomplete="off" value="${member.mem_name }" />
				</div>
				<form:errors element="div" path="mem_name" cssClass="error-color" />
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="mem_id" placeholder="ID를 입력해주세요" class="input_style readonly-input" autocomplete="off" readonly="readonly"
						value="${member.mem_id }" />
				</div>
				<div id="message_id"></div>
				<form:errors element="div" path="mem_id" cssClass="error-color" />
			</div>
			<!-- 나머지 코드 동일 -->
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="mem_nickName" placeholder="닉네임을 입력해주세요"
						class="input_style" autocomplete="off"
						value="${member.mem_nickName }" />
				</div>
				<div id="message_nickName"></div>
				<form:errors element="div" path="mem_nickName"
					cssClass="error-color" />
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="mem_phone" placeholder="전화번호를 입력해주세요"
						class="input_style" value="${member.mem_phone }" />
				</div>
				<div id="message_phone"></div>
				<form:errors element="div" path="mem_phone" cssClass="error-color" />
			</div>
			<div class="login_form_all">
				<div class="login_form_inputs_id_passwd">
					<form:input path="mem_email" placeholder="이메일을 입력해주세요"
						class="input_style" value="${member.mem_email }" />
				</div>
				<div id="message_email"></div>
				<form:errors element="div" path="mem_email" cssClass="error-color" />
			</div>
			<div class="modify_btn_all">
				<input type="button" value="수정하기" class="user_modify_btn">
			</div>
		</div>
	</form:form>
</div>

<!-- 아이디 수정 불가 -->
<style>
.readonly-input {
	pointer-events: none; 
}
</style>
