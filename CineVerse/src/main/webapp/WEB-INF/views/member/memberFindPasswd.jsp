<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
    .loading-background {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 9998;
    }

    .loading {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 9999;
    }
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.findpw.js"></script>
 <main class="flex items-center justify-center">
        <div class="login_main">
            <div class="register_logo">
                <div class="login_logo_wrapper">
                    <div class="register_logo_image">
                        <a href="${pageContext.request.contextPath}/main/main">
                            <img src="${pageContext.request.contextPath}/images/cmj/logo.png" width="210">
                        </a>
                    </div>
                </div>
            </div>
            <form:form action="getPasswordInfo" id="member_findPasswd" modelAttribute="memberVO">
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_id" placeholder="ID를 입력해주세요" class="input_style" autocomplete="off"/>
                        </div>
                        <div id="message_id"></div>
                        <form:errors element="div" path="mem_id" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_phone" placeholder="전화번호를 입력해주세요" class="input_style"/>
                        </div>
                        <form:errors element="div" path="mem_phone" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_email" placeholder="이메일을 입력해주세요" class="input_style"/>
                        </div>
                        <form:errors element="div" path="mem_email" cssClass="error-color" />
                    </div>
                </div>
                <div class="login_button"><form:button
                        class="round_button primary-round_button " tabindex="3">비밀번호 찾기</form:button>
                        <span class="find_link">
                            <a href="${pageContext.request.contextPath}/member/login">
                                <button class="plain-button" type="button">
                                    로그인 돌아가기
                                </button>
                            </a>
                        </span>
                </div>
            </form:form>
        </div>
        <div class="loading-background"></div>
		<div class="loading">
    		<img src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." width="50" height="50">
		</div>
    </main>