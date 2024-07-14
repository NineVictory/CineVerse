<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 영화관 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2 class="all-theater">전체 극장</h2>			
	<input type="button"  value="영화관 등록" class="cinema-write" onclick="location.href='cinemaWrite'">
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
						<ul class="place-list">
							<li class="branch-list"><a href="detail?c_num=${cinema.c_num}" class="button">${cinema.c_branch}</a></li>
						</ul>
					</c:forEach>
				</c:if>	
			</div>	
	</div>
	
<h2 class="theater-event">극장 이벤트</h2>
<input type="button" class="btn_more" value="더보기" onclick="location.href='${pageContext.request.contextPath}/event/event'">
<div id="main_content" class="event_list">	
	<div class="event_wrap">
		<div class="img_lst_wrap">
			<div class="img_w_01"><a href="#" title="화면이동"><img
					src="https://img.megabox.co.kr/SharedImg/event/2024/07/11/xokr1EWDMW4qyH5pL4kAvUlREdXO6FCY.jpg"
					alt=""></a></div>
			<div class="img_w_01"><a href="#" title="화면이동"><img
					src="https://img.megabox.co.kr/SharedImg/event/2024/07/10/CIO1jnh3YEnAez1infc4tVEiP7Quzqa7.jpg"
					alt=""></a></div>
		</div>
	</div>
</div>	


<h2 class="theater-pay">요금 안내</h2>
			<img class="pay-image" src="${pageContext.request.contextPath}/images/hjt/pay.png" alt="">
			<img class="payment-image" src="${pageContext.request.contextPath}/images/hjt/pay2.png" alt="">
<!-- <div class="pay-box">
	<div>2D</div>
	<div class="twodpay">
	<table>
		<tr>
			<th>요일</th><th>상영시간</th><th>일반</th><th>청소년</th>
		</tr>
		<tr>
			<td>1</td><td>2</td><td>3</td><td>4</td>
		</tr>
		<tr>
			<td>1</td><td>2</td><td>3</td><td>4</td>
		</tr>
	</table>
	</div>
</div>	 -->
</div>
<!-- 영화관 목록 끝 -->





