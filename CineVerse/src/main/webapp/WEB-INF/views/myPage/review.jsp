<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 나의 별점 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">내가 쓴 평점</span>
	</div>
	<!-- 반복 -->
	<c:if test="${count == 0}"><div>작성한 리뷰가 없습니다</div></c:if>
	<c:if test="${count > 0}">
	<c:forEach var="rev" items="${list}">
	<div class="review_box">
		<div class="review_content">
			<div class="review_content_info">
				<div class="review_id">${rev.mem_id}</div>
				<div>${rev.mr_grade }</div>
				<div class="my_review">${rev.mr.content}</div>
			</div>
			<div class="review_delete_btn">
				<div>삭제</div>
			</div>
		</div>
		<div class="review_fav_date">
			<span>이미지</span> <span>3</span> | <span>2024.07.31</span>
		</div>
	</div>
	</c:forEach>
	</c:if>
	<!-- 반복 -->
	
	
	
	<div class="review_box">
		<div class="review_content">
			<div class="review_content_info">
				<div class="review_id">분모재</div>
				<div>별점 카운트</div>
				<div class="my_review">재밌었다</div>
			</div>
			<div class="review_delete_btn">
				<div>삭제</div>
			</div>
		</div>
		<div class="review_fav_date">
			<span>이미지</span> <span>3</span> | <span>2024.07.31</span>
		</div>
	</div>
	
	
	
	<div class="review_box">
		<div class="review_content">
			<div class="review_content_info">
				<div class="review_id">아이디</div>
				<div>별점 카운트</div>
				<div class="my_review">리뷰양에 따라서 박스 사이즈 늘어나나?리뷰양에 따라서 박스 사이즈 늘어나나?리뷰양에 따라서 박스 사이즈 늘어나나?리뷰양에 따라서 박스 사이즈 늘어나나?리뷰양에 따라서 박스 사이즈 늘어나나?리뷰양에 따라서 박스 사이즈 늘어나나?리뷰양에 따라서 박스 사이즈</div>
			</div>
			<div class="review_delete_btn">
				<div>삭제</div>
			</div>
		</div>
		<div class="review_fav_date">
			<span>이미지</span> <span>3</span> | <span>2024.07.31</span>
		</div>
	</div>
	
	
	
	
</div>
<!-- 나의 별점 끝 -->