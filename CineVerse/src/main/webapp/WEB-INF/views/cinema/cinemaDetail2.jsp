<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 영화관 상세 정보 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<div class="page-main">
	<h2>${cinema.c_branch}</h2>
	
			<div class="content-place-location">주소 : <b>${cinema.c_address}</b></div>
            <div class="content-place-tell">문의전화 : <b>${cinema.c_phone}</b></div>
            <div class="content-place-cinema">상영관수 : <b>${cinema.c_theater}, ${cinema.c_seat}</b></div>
            <div class="content-place-parking">주차정보 : <b>${cinema.c_parkable}</b></div>
	
	<hr size="1" width="100%">
	<div class="align-right">
		<input type="button" value="수정"  onclick="location.href='update?c_num=${cinema.c_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete?c_num=${cinema.c_num}');
				}
			};
		</script>   
		<input type="button" value="목록"  onclick="location.href='cinemaList2'">
	</div>
	<hr size="1" width="100%">
</div>
<!-- 영화관 상세 정보 시작 -->












