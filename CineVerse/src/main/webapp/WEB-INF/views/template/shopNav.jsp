<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="shopNav">
    <ul>
        <li><a href="?category=all"> ALL </a></li>
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
        if (currentCategory) {
            menuItems.forEach(function(item) {
                if (new URL(item.href).searchParams.get('category') === currentCategory) {
                    item.parentElement.style.background = '#D8D8D8';
					item.parentElement.style.borderRadius = '10px';
					item.parentElement.style.height="50px";
					item.parentElement.style.width="190px";
                }
            });
        }
    });
</script>
