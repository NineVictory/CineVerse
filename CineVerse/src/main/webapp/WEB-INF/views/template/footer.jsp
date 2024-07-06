<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 하단 시작 -->
<style>
* {
    font-family: "Noto Sans KR", sans-serif;
}

a {
	text-decoration: none;
}

ul li {
	list-style: none;
}

.footer {
	margin-top: 10%;
	bottom: 0;
	width: 100%;
	color: #000;
	padding: 10px 0;
	box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
}

.footer-content {
	width: 980px;
	height: 100%;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	font-size: 12px;
}

.footer .f_menu {
	margin-bottom: 15px;
}

.footer .f_menu li:first-child {
	padding-left: 0;
}

.footer .f_menu li {
	position: relative;
	float: left;
	margin-right: 10px;
	padding-left: 10px;
}

.footer .f_menu.type1 li a {
	color: #4d4d4d;
}

.footer .f_menu li a {
	display: block;
	font-size: 12px;
}

.footer-main-logo {
	margin-left: 25px;
}
</style>

<footer class="footer">
	<div class="footer-content">
		<div class="footer-main-logo">
			<a href="${pageContext.request.contextPath}/main/main">
			<img src="${pageContext.request.contextPath}/images/cmj/logo.png"
				width="160">
			</a>
			
		</div>
		<div class="footer-menu">
			<ul class="f_menu type1">
				<li><a href="#">메인 </a></li>
				<li><a href="#">마이페이지 </a></li>
				<li><a href="#">영화 목록 </a></li>
				<li><a href="#">영화 예매 </a></li>
				<li><a href="#">커뮤니티 </a></li>
				<li><a href="#">1:1 문의 </a></li>
				<li><a href="#">포인트충전 </a></li>
				<li><a href="#">쇼핑몰</a></li>
			</ul>
		</div>
		<div class="footer-company">
			<ul>
				<li>서울특별시 용산구 한강대로 23길 55, 아이파크몰 6층(한강로동)</li>
				<li>대표이사 : 분모재. 사업자등록번호 : 000-00-00000 통신판매업신고번호 :
					2017-서울용산-0662</li>
				<li>호스팅사업자 : CV쌍용네트웍스 개인정보보호 책임자 : 분모재 대표이메일 : cineverse@cv.net</li>
				<li>&copy; CV CINEVERSE. All Rights Reserved</li>
			</ul>
		</div>
	</div>

</footer>
<!-- 하단 끝 -->