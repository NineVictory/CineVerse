<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#login_form').submit(function() {
			if ($('#mem_id').val().trim() == '') {
				alert('아이디를 입력하세요');
				$('#mem_id').val('').focus();
				return false;
			}
			if ($('#mem_passwd').val().trim() == '') {
				alert('비밀번호를 입력하세요');
				$('#mem_passwd').val('').focus();
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
						<a href="${pageContext.request.contextPath}/main/main"> <img
							src="${pageContext.request.contextPath}/images/cmj/logo.png"
							width="210">
						</a>
					</div>
					<p class="login_logo_info">
						간편하고 빠르게 <span class="login_logo_info_bold"> 예매 </span>하고
					</p>
					<p class="login_logo_info">굿즈도 구매해보세요</p>

				</div>
			</div>
			<form:form action="login" id="login_form" modelAttribute="memberVO">
				<form:errors element="div"
					cssStyle="margin-top:10px; font-size:12px; color:red;" />
				<div class="login_form_inputs">
					<div class="login_form_all">
						<div class="login_form_inputs_id_passwd">
							<form:input path="mem_id" placeholder="ID를 입력해주세요"
								class="input_style" autocomplete="off" />
						</div>
						<form:errors element="div" path="mem_id" cssClass="error-color" />
					</div>
					<div class="login_form_all">
						<div class="login_form_inputs_id_passwd">
							<form:password path="mem_passwd" placeholder="비밀번호를 입력해주세요"
								class="input_style" />
						</div>
						<form:errors element="div" path="mem_passwd"
							cssClass="error-color" />
					</div>
					<div class="find-password">
						<span>비밀번호를 잊으셨나요?</span> <a
							href="${pageContext.request.contextPath}/member/findPasswd">
							<button class="plain-button" type="button">비밀번호 재설정</button>
						</a>
					</div>
					<div class="auto_login">
						<input type="checkbox"> 자동 로그인
					</div>
				</div>
				<div class="login_button">
					<form:button class="round_button primary-round_button" tabindex="3">로그인</form:button>
					<span class="find_link"> <a
						href="${pageContext.request.contextPath}/member/findId">
							<button class="plain-button" type="button">아이디 찾기</button>
					</a> <span class="link_separation">|</span> <a
						href="${pageContext.request.contextPath}/member/register">
							<button class="plain-button" type="button">가입하기</button>
					</a>
					</span>
				</div>
			</form:form>

			<a id="kakao-login-btn" href="javascript:loginWithKakao()"
				style="margin-top: 20px; display: flex; justify-content: flex-start;">
				<img
				src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
				width="185" alt="카카오 로그인 버튼" />
			</a>
			<p id="token-result"></p>
		</div>
	</main>
	
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script type="text/javascript">
	Kakao.init('955f6631974929bbdb7f5e7e2a3cc510');
	
	 // 카카오 로그인 함수
    function loginWithKakao() {
        Kakao.Auth.login({
            success: function(authObj) {
                console.log(authObj); // 로그인 성공 시 토큰 정보 출력
                Kakao.Auth.setAccessToken(authObj.access_token); // access 토큰 저장
                
                // 로그인 성공 후 추가 작업 (예: 회원 가입 확인 등)
                checkKakaoUser(authObj.access_token);
            },
            fail: function(err) {
                console.error(err); // 로그인 실패 시 에러 처리
            }
        });
    }
    
    // 카카오 사용자 확인 함수
    function checkKakaoUser(accessToken) {
        Kakao.API.request({
            url: '/v2/user/me',
            success: function(res) {
                console.log(res);
                var email = res.kakao_account.email; 
                var nickname = res.kakao_account.profile.nickname;
                var profile_image = res.kakao_account.profile.thumbnail_image_url;
				//var id = res.id;
				
                // 서버에 회원 정보 전송
                $.ajax({
                    url: '/member/kakaoRegister',
                    type: 'post',
                    data: {
                        mem_email: email,
                        mem_nickname: nickname,
                        social_kakao: accessToken,
                        profile_image: profile_image
                    },
                    dataType: 'json',
                    success: function(response) {
                        console.log(response);
                        if (response.result === 'success') {
                            alert('카카오 소셜 로그인되었습니다.');
                            window.location.href = '/main/main';
                        } else if (response.result == 'registerkakao'){
                        	var redirectUrl = '/member/kakaoRegisterForm' +
                            '?mem_email=' + encodeURIComponent(email) +
                            '&mem_nickname=' + encodeURIComponent(nickname)+
                            '&social_kakao='+encodeURIComponent(accessToken)+
                            '&profile_image=' + encodeURIComponent(profile_image);
         					 window.location.href = redirectUrl;
                        } else {
                            alert('회원 가입 및 로그인 실패');
                        }
                    },
                    error: function() {
                        alert('네트워크 오류가 발생했습니다.');
                    }
                });
            },
            fail: function(err) {
                console.error(err); // 사용자 정보 가져오기 실패 시 처리
            }
        });
    }
</script>
</body>
</html>