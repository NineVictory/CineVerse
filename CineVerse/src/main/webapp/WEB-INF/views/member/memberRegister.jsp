<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
        $(function(){
            $('#register_form').submit(function(){
            	if($('#mem_name').val().trim()==''){
                    alert('이름을 입력하세요');
                    $('#mem_name').val('').focus();
                    return false;
                }
                if($('#mem_id').val().trim()==''){
                    alert('아이디를 입력하세요');
                    $('#mem_id').val('').focus();
                    return false;
                }
                if($('#mem_passwd').val().trim()==''){
                    alert('비밀번호를 입력하세요');
                    $('#mem_passwd').val('').focus();
                    return false;
                }
                
                if($('#mem_phone').val().trim()==''){
                    alert('전화번호를 입력하세요');
                    $('#mem_phone').val('').focus();
                    return false;
                }
                if($('#mem_email').val().trim()==''){
                    alert('이메일을 입력하세요');
                    $('#mem_email').val('').focus();
                    return false;
                }
            })
        });
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
            <form id="register_form">
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="이름을 입력해주세요" id="mem_name" name="mem_name" type="text" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="ID를 입력해주세요" id="mem_id" name="mem_id" type="text" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="비밀번호를 입력해주세요" id="mem_passwd" name="mem_passwd" type="password" class="input_style">
                        </div> 
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="전화번호를 입력해주세요" id="mem_phone" name="mem_phone" type="tel" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="이메일을 입력해주세요" id="mem_email" name="mem_email" type="email" class="input_style">
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