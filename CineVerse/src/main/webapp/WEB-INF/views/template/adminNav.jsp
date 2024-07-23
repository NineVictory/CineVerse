<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.nav.css" type="text/css">
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
				class="menu-link">구독멤버십</a></li>

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
				href="${pageContext.request.contextPath}/admin/adminReservation"
				class="menu-link">예매</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminReview"
				class="menu-link">리뷰관리</a></li>
		</ul>
		<a class="menu-item">영화관</a>
		<ul class="sub_menus">
			<li><a
				href="${pageContext.request.contextPath}/admin/adminCinema"
				class="menu-link">영화관</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminCinemaForm"
				class="menu-link">영화관등록</a></li>
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
				class="menu-link">자유게시판 관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminAssign"
				class="menu-link">양도/교환 관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/adminReply"
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
				href="${pageContext.request.contextPath}/admin/adminShopReview"
				class="menu-link">후기</a></li>
		</ul>
		<a href="#" class="menu-item">쿠폰</a> 
		<a href="${pageContext.request.contextPath}/admin/adminConsult" class="menu-item">1:1문의</a>
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