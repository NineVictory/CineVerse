<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.login_form_inputs {
	margin: 38px 0 46px;
}

#member_modify {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.login_form_all {
	width: 380px;
	display: flex;
	flex-direction: column;
	margin-bottom: 10px;
}

.login_form_inputs_id_passwd {
	height: 50px;
	display: flex;
	align-items: center;
	column-gap: 8px;
	border-radius: 6px;
	background-color: #fff;
	border: 1px solid #eaeaea;
}

.input_style {
	font-size: 14px;
	line-height: 22.4px;
	font-weight: 400;
	word-break: keep-all;
	flex-grow: 1;
	display: flex;
	align-items: center;
	margin: 0;
	padding: 0 20px;
	color: #000;
	border: none;
	outline: none;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.user_modify_btn {
	margin-top: 15px;
	border-radius: 7px;
	color: #fff;
	background-color: var(--main-color-strong);
	width: 180px;
	height: 35px;
	border: none;
	cursor: pointer;
}

.modify_btn_all {
	display: flex;
	justify-content: center;
}

#member_modify .error-color{
	font-size: 12px;
	color:red;
}

</style>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="myPage_main">
	<div class="myPage_title">
		<h3>개인정보 변경</h3>
	</div>
	<form:form action="modifyUser" id="member_modify" modelAttribute="memberVO">
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_name" placeholder="이름을 입력해주세요" class="input_style" autocomplete="off"/>
                        </div>
                        <form:errors element="div" path="mem_name" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_id" placeholder="ID를 입력해주세요" class="input_style" autocomplete="off" disabled="disabled"/>
                        </div>
                        <div id="message_id"></div>
                        <form:errors element="div" path="mem_id" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:password path="mem_passwd" placeholder="비밀번호를 입력해주세요" class="input_style"/>
                        </div> 
                        <form:errors element="div" path="mem_passwd" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_phone" placeholder="전화번호를 입력해주세요" class="input_style"/>
                        </div>
                        <div id="message_phone"></div>
                        <form:errors element="div" path="mem_phone" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_email" placeholder="이메일을 입력해주세요" class="input_style"/>
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