<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <form>
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="이름을 입력해주세요" type="text" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="ID를 입력해주세요" type="password" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="비밀번호를 입력해주세요" type="password" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="전화번호를 입력해주세요" type="tel" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="이메일을 입력해주세요" type="email" class="input_style">
                        </div>
                    </div>

                </div>
                <div class="login_button"><button
                        class="round_button primary-round_button " type="submit" tabindex="3">가입하기</button>
                        <span class="find_link">
                            <a href="${pageContext.request.contextPath}/member/login">
                                <button class="plain-button" type="button">
                                    로그인 하기
                                </button>
                            </a>
                        </span>
                </div>
            </form>
        </div>
    </main>