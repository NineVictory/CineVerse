<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 영화관 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2 class="all-theater">전체 극장</h2>			
	<input type="button"  value="영화관 등록" onclick="location.href='cinemaWrite'">
	<div class="theater-box">
		<div class="theater-location">
			<ul>
				<li class="on">
					<a href="cinemaList2?c_location=1" class="button">서울</a> 
					<a href="cinemaList2?c_location=2" class="button">경기</a>
					<a href="cinemaList2?c_location=3" class="button">인천</a> 
					<a href="cinemaList2?c_location=4" class="button">강원</a>
					<a href="cinemaList2?c_location=5" class="button">대전/충청</a>
					<a href="cinemaList2?c_location=6" class="button">경상</a>
					<a href="cinemaList2?c_location=7" class="button">광주/전라</a>
				</li>	
			</ul>
			</div>
			<hr size="2" width="100%">
			<div class="theater-place">
				<c:if test="${count == 0}">
					<div class="result-display">표시할 영화관이 없습니다.</div>
				</c:if>
				<c:if test="${count > 0}">
					<c:forEach var="cinema" items="${list}">
						<ul>
							<li><a href="detail?c_num=${cinema.c_num}">${cinema.c_branch}</a></li>
						</ul>
					</c:forEach>
				</c:if>	
			</div>	
	</div>
<div>
	<h2 class="theater-event">극장 이벤트</h2>
</div>
	

<div>
	<h2 class="theater-pay">요금 안내</h2>
</div>	
</div>
<!-- 영화관 목록 끝 -->





