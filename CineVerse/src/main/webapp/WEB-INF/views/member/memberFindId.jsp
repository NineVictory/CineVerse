<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
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
            <form:form action="findId" id="member_findId" modelAttribute="memberVO">
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_name" placeholder="이름을 입력해주세요" class="input_style" autocomplete="off"/>
                        </div>
                        <form:errors element="div" path="mem_name" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_phone" placeholder="전화번호를 입력해주세요" class="input_style"/>
                        </div>
                        <div id="message_phone"></div>
                        <form:errors element="div" path="mem_phone" cssClass="error-color"/>
                    </div>
                </div>
                <div class="login_button"><form:button
                        class="round_button primary-round_button " tabindex="3">아이디 찾기</form:button>
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
    </main>