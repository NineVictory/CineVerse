<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 벌스샵 메인 메뉴 시작 -->
<div class="shopNav">
    <ul>
        <li><a href="${pageContext.request.contextPath}/shop/shopMain"> ALL </a></li>
        <li><a href="?category=marvel"> MARVEL </a></li>
        <li><a href="?category=disney"> DISNEY </a></li>
        <li><a href="?category=disney_princess"> DISNEY PRINCESS </a></li>
        <li><a href="?category=pixar"> PIXAR </a></li>
        <li><a href="?category=studio_ghibli"> Studio GHIBLI </a></li>
        <li><a href="?category=warner_bros"> Warner Bros. </a></li>
        <li><a href="?category=universal_studio"> Universal Studio </a></li>
    </ul>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var menuItems = document.querySelectorAll('.shopNav ul li a');
        var currentCategory = new URL(window.location).searchParams.get('category');
        
        if (!currentCategory) {
            // 기본 경로일 경우 ALL에 배경 색상 적용
            menuItems[0].parentElement.style.background = '#D8D8D8';
        } else {
            menuItems.forEach(function(item) {
                if (new URL(item.href).searchParams.get('category') === currentCategory) {
                    item.parentElement.style.background = '#D8D8D8';
                }
            });
        }
    });
</script>
<!-- 벌스샵 메인 메뉴 끝 -->