<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.register.js"></script>
<script type="text/javascript">
//페이지가 로드되었을 때 실행될 함수
window.onload = function() {
    // URL에서 쿼리 파라미터 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    
    // 가져온 쿼리 파라미터에서 필요한 값 추출
    const email = urlParams.get('email');
    const nickname = urlParams.get('nickname');
    const profile_image = urlParams.get('profile_image');

    // 가져온 값들을 폼의 각 입력 필드에 설정
    document.getElementById('mem_email').value = email;
    document.getElementById('mem_name').value = nickname;
};
</script>
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
            <form:form action="register" id="member_register" modelAttribute="memberVO">
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_name" placeholder="이름을 입력해주세요" class="input_style" autocomplete="off" value=""/>
                        </div>
                        <form:errors element="div" path="mem_name" cssClass="error-color"/>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <form:input path="mem_id" placeholder="ID를 입력해주세요" class="input_style" autocomplete="off"/>
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
                            <form:input path="mem_email" placeholder="이메일을 입력해주세요" class="input_style" value=""/>
                        </div>
                        <div id="message_email"></div>
                        <form:errors element="div" path="mem_email" cssClass="error-color" />
                    </div>

                </div>
                <div class="login_button"><form:button
                        class="round_button primary-round_button " tabindex="3">가입하기</form:button>
                        <span class="find_link">
                            <a href="${pageContext.request.contextPath}/member/login">
                                <button class="plain-button" type="button">
                                    로그인 하기
                                </button>
                            </a>
                        </span>
                </div>
            </form:form>
        </div>
    </main>