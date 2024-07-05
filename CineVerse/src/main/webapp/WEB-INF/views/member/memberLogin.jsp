<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<script type="text/javascript">
        $(function(){
            $('#login_form').submit(function(){
                if($('#id').val().trim()==''){
                    alert('아이디를 입력하세요');
                    $('#id').val('').focus();
                    return false;
                }
                if($('#passwd').val().trim()==''){
                    alert('비밀번호를 입력하세요');
                    $('#passwd').val('').focus();
                    return false;
                }
            })
        });
    </script>
</head>
<body>
<main class="flex items-center justify-center">
        <div class="login_main">
            <div class="login_logo">
                <div class="login_logo_wrapper">
                    <div class="login_logo_image">
                        <a href="${pageContext.request.contextPath}/main/main">
                            <img src="${pageContext.request.contextPath}/images/cmj/logo.png" width="210">
                        </a>
                    </div>
                    <p class="login_logo_info">간편하고 빠르게 <span class="login_logo_info_bold"> 예매 </span>하고</p>
                    <p class="login_logo_info">굿즈도 구매해보세요</p>
                    
                </div>
            </div>
            <form>
                <div class="login_form_inputs">
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="ID를 입력해주세요" type="text" class="input_style">
                        </div>
                    </div>
                    <div class="login_form_all">
                        <div class="login_form_inputs_id_passwd">
                            <input placeholder="비밀번호를 입력해주세요" type="password" class="input_style">
                        </div>
                    </div>
                    <div class="find-password"><span>비밀번호를 잊으셨나요?</span>
                        <a href="#">
                            <button class="plain-button" type="button">
                                비밀번호 재설정
                            </button>
                        </a>
                    </div>
                    <div class="auto_login">
                        <input type="checkbox" > 자동 로그인
                    </div>
                </div>
                <div class="login_button"><button
                        class="round_button primary-round_button " type="submit" tabindex="3">로그인</button>
                        <span class="find_link">
                            <a href="#">
                                <button class="plain-button" type="button">
                                    아이디 찾기
                                </button>
                            </a>
                                <span class="link_separation">|</span>
                                <a href="#">
                                    <button class="plain-button" type="button">가입하기</button>
                                </a>
                        </span>
                </div>
            </form>
        </div>
    </main>
</body>
</html>