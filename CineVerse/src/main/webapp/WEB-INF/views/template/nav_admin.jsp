<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.left-outer {
background-color: #EFF3FD;
    position: fixed;
    left: 0;
    top: 0;
    width: 12%;
    height: 100vh;
    overflow-y: auto; /* 스크롤바를 허용하는 속성 */
}

.left-outer::-webkit-scrollbar {
	width: 8px; /* 스크롤바 너비 */
}

.left-outer::-webkit-scrollbar-track {
	background: var(--main-light-color); /* 트랙 색상 */
	border-radius: 10px;
}

.left-outer::-webkit-scrollbar-thumb {
	background-color: var(--main-color); /* 스크롤바 색상 */
	border-radius: 10px;
}

.left-outer::-webkit-scrollbar-thumb:hover {
	background-color: var(--main-color); /* 스크롤바 호버 색상 */
}

.menu-bar {
	margin-top: 20px;
    width: 100%;
    padding-top: 5px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.menu-item {
	padding: 10px 30px;
	color: #333333;
	text-decoration: none;
	display: block;
	border-radius: 10px;
	transition: background-color 0.3s ease;
	width: 80%;
	font-weight: 800;
}

.menu-item:hover {
	color: var(--main-color-strong);
}

.sub_menus {
	display: none;
	width: 100%;
	padding: 0;
	margin: 0;
	list-style: none;
}

.sub_menus li a {
	font-weight: 500;
    display: flex;
    align-items: center;
    width: 100%;
    height: 50px;
    padding: 0 30px 0 45px;
    color: #333333;
    text-decoration: none;
    border-radius: 10px;
    transition: background-color 0.3s ease;
    text-align: center;
    font-size: 13px;
}

.sub_menus li a:hover {
	color: var(--main-color-strong);
}

.menu-active {
	background: var(--gray-3);
	color: var(--main-color-strong) !important;
	font-weight: 700;
}

.menu-logo {
padding-left: 20px;
}
</style>
<div class="left-outer">
	<div class="menu-bar">
		<div class="menu-logo">
			<img src="${pageContext.request.contextPath}/images/cmj/logo.png"
			onclick="location.href = '${pageContext.request.contextPath}/main/main'" width="130"/>
		</div>
		
		<a class="menu-item">회원</a>
		<ul class="sub_menus">
			<li><a
				href="${pageContext.request.contextPath}/admin/adminMember"
				class="menu-link">회원관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminMembership"
				class="menu-link">구독맴버십</a></li>

		</ul>
		<a class="menu-item">영화</a>
		<ul class="sub_menus">
			<li><a
				href="${pageContext.request.contextPath}/admin/adminMovieForm"
				class="menu-link">영화등록</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminMovieTime"
				class="menu-link">영화시간표등록</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminMovie"
				class="menu-link">영화</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminCinema"
				class="menu-link">영화관</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminReservation"
				class="menu-link">예매</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminReview"
				class="menu-link">리뷰관리</a></li>
		</ul>
		<a href="${pageContext.request.contextPath}/admin/adminNotice"
			class="menu-item">공지사항</a> <a
			href="${pageContext.request.contextPath}/admin/adminEvent"
			class="menu-item">이벤트</a> <a
			href="${pageContext.request.contextPath}/admin/adminPayment"
			class="menu-item">포인트</a> <a class="menu-item">게시판</a>
		<ul class="sub_menus">
			<li><a
				href="${pageContext.request.contextPath}/admin/adminCommunity"
				class="menu-link">통합게시판 관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminBoardReview"
				class="menu-link">게시판 댓글 관리</a></li>
		</ul>
		<a class="menu-item">벌스샵</a>
		<ul class="sub_menus">
			<li><a href="${pageContext.request.contextPath}/admin/adminShop"
				class="menu-link">상품등록</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminProductList"
				class="menu-link">상품목록</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminDelivery"
				class="menu-link">배송상태</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminAddress"
				class="menu-link">배송지</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminShopQna"
				class="menu-link">문의</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminShopReview"
				class="menu-link">후기</a></li>
		</ul>
		<a href="#" class="menu-item">쿠폰</a> <a href="#" class="menu-item">1:1
			문의</a>
	</div>
</div>



<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var menuItems = document.querySelectorAll('.menu-item');

    menuItems.forEach(function(item) {
        item.addEventListener('click', function() {
            var subMenu = this.nextElementSibling;
            if (subMenu && subMenu.classList.contains('sub_menus')) {
                subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
            }
        });
    });
});

var menuLinks = document.querySelectorAll('.menu-link');

function clickMenuHandler(){
    var activeMenu = document.querySelector('.menu-active');
    if (activeMenu){
        activeMenu.classList.remove('menu-active');
    }
    this.classList.add('menu-active');
}


for (var i = 0; i < menuLinks.length; i++){
    menuLinks[i].addEventListener('click', clickMenuHandler);
}

</script>