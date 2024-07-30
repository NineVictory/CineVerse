<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 나의 북마크 시작 -->

<style>
.member_form_message {
    font-size: 13px;
    width: 950px;
    display: flex;
    background-color: var(--gray-2);
    justify-content: center;
    padding: 5px;
}

.member_delete_form {
    margin-top: 30px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.memdel_form_all {
    gap: 30px;
    width: 490px;
    display: flex;
    flex-direction: row;
    margin-bottom: 10px;
    align-items: center;
    justify-content: center;
}

.memdel_form_all > label {
    width: 100px;
}

.delete_form_inputs {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 950px;
    padding: 38px 0px 46px;
    border-bottom: 1px solid var(--gray-3);
}

.delete_form_btn {
    display: flex;
    justify-content: center;
}

.delete_form_btn > button {
    border-radius: 5px;
    border: none;
    padding: 8px;
    width: 100px;
    background-color: var(--red-check-btn);
    color: #fff;
    font-size: 13px;
    font-weight: 600;
}

.del_error_color {
    margin-left: 65px;
    font-size: 13px;
    color: red;
}
</style>

<div class="myPage_main">
    <span class="myPage_title_re">회원 탈퇴</span>
    <div class="member_delete_form">
        <div class="member_form_message">
            <span>고객님의 개인정보 보호를 위한 절차이오니, CINEVERSE 로그인 시 사용하는 비밀번호를 입력해 주세요.</span>
        </div>
        
        <div class="delete_form">
            <div class="delete_memform">
                <form:form action="deleteMember" id="delete_member_form" modelAttribute="myPageVO">
                    <div class="delete_form_inputs login_form_inputs">
                        <div class="memdel_form_all">
                            <form:label path="mem_id">아이디</form:label>
                            <div class="login_form_inputs_id_passwd">
                                <form:input path="mem_id" value="${user.mem_id}" class="input_style" readonly="true"/>
                            </div>
                        </div>
                        <div class="memdel_form_all">
                            <form:label path="mem_passwd">비밀번호</form:label>
                            <div class="login_form_inputs_id_passwd">
                                <form:password path="mem_passwd" class="input_style" />
                            </div>
                        </div>
                        <div>
                            <form:errors element="div" path="mem_passwd" cssClass="del_error_color" />
                        </div>
                    </div>
                    <div class="delete_form_btn">
                        <form:button>탈퇴하기</form:button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
