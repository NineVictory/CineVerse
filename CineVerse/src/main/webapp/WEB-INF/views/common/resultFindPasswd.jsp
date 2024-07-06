<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${accessTitle}</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	background-color: #f8f9fa;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.page-one {
	padding: 20px;
	background: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.result-display {
	margin-top: 20px;
}

h2 {
	color: #343a40;
	margin-bottom: 20px;
}

.align-center {
	width: 100%;
	min-width: 550px;
	margin: 0 auto;
}

.password-box {
	display: inline-block;
	padding: 10px 20px;
	color: #000;
	border-radius: 5px;
	font-size: 18px;
	margin-top: 10px;
	margin-bottom: 10px;
	font-weight: bold;
}

.btn-custom {
	display: inline-block;
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 15px;
	text-decoration: none;
	font-size: 16px;
	transition: transform 0.3s ease;
	cursor: pointer;
	margin-top: 20px;
}

.btn-custom:hover {
	transform: scale(1.05);
}
</style>
</head>
<body>
	<div class="page-one">
		<h2>${accessTitle}</h2>
		<div class="result-display">
			<div class="align-center">
				${accessMsg}<br>
				<div class="password-box">${new_passwd}</div>
				<br> 로그인 후 비밀번호를 변경해주세요.
				<p>
					<a href="${accessUrl}" class="btn-custom">${accessBtn}</a>
			</div>
		</div>
	</div>
</body>
</html>
