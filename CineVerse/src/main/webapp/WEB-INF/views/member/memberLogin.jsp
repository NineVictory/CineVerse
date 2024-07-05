<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
        $(function(){
            $('#login_form').submit(function(){
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
			<form id="login_form">
				<div class="login_form_inputs">
					<div class="login_form_all">
						<div class="login_form_inputs_id_passwd">
							<input placeholder="ID를 입력해주세요" name="mem_id" id="mem_id" type="text" class="input_style">
						</div>
					</div>
					<div class="login_form_all">
						<div class="login_form_inputs_id_passwd">
							<input placeholder="비밀번호를 입력해주세요" type="password" name="mem_passwd" id="mem_passwd"
								class="input_style">
						</div>
					</div>
					<div class="find-password">
						<span>비밀번호를 잊으셨나요?</span> <a href="#">
							<button class="plain-button" type="button">비밀번호 재설정</button>
						</a>
					</div>
					<div class="auto_login">
						<input type="checkbox"> 자동 로그인
					</div>
				</div>
				<div class="login_button">
					<input class="round_button primary-round_button " type="submit" value="로그인"
						tabindex="3">
					<span class="find_link"> <a href="#">
							<button class="plain-button" type="button">아이디 찾기</button>
					</a> <span class="link_separation">|</span> <a href="${pageContext.request.contextPath}/member/register">
							<button class="plain-button" type="button">가입하기</button>
					</a>
					</span>
				</div>
			</form>
			<div
				style="display: flex; justify-content: center; margin-top: 30px;">
				<a id="kakao-login-btn" href="javascript:loginWithKakao()"> <img
					src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
					width="180" alt="카카오 로그인 버튼">
				</a>
				<p id="token-result"></p>
			</div>
		</div>
		<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
			integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4"
			crossorigin="anonymous"></script>
		<script>
  		Kakao.init('955f6631974929bbdb7f5e7e2a3cc510'); // 사용하려는 앱의 JavaScript 키 입력
		</script>



		<script>
 			function loginWithKakao() {
    				Kakao.Auth.authorize({
      							redirectUri: 'http://localhost:8000/main/main',
    				});
  				}

  			// 아래는 데모를 위한 UI 코드입니다.
  			displayToken()
  			function displayToken() {
    			var token = getCookie('authorize-access-token');

    				if(token) {
     					 Kakao.Auth.setAccessToken(token);
      					Kakao.Auth.getStatusInfo()
        						.then(function(res) {
         							 if (res.status === 'connected') {
            								document.getElementById('token-result').innerText
              									= 'login success, token: ' + Kakao.Auth.getAccessToken();
          									}
       									 })
        					.catch(function(err) {
        	 			 Kakao.Auth.setAccessToken(null);
        					});
    					}
 					 }

 					 function getCookie(name) {
   						 var parts = document.cookie.split(name + '=');
    							if (parts.length === 2) { return parts[1].split(';')[0]; }
  								}
		</script>
	</main>
</body>
</html>