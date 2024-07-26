<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 나의 별점 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">내가 쓴 평점</span>
	</div>
	<!-- 반복 -->
	<c:if test="${count == 0}"><div class="empty_position">작성한 리뷰가 없습니다</div></c:if>
	<c:if test="${count > 0}">
	<c:forEach var="rev" items="${list}">
	<div class="review_box">
		<div class="review_content">
			<div class="review_content_info">
				<div class="review_id">${rev.mem_id}</div>
				<div class="review_img">
				<c:choose>
				<c:when test="${rev.mr_grade == 1}">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
				</c:when>
				<c:when test="${rev.mr_grade == 2}">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
				</c:when>
				<c:when test="${rev.mr_grade == 3}">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
				</c:when>
				<c:when test="${rev.mr_grade == 4}">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
				</c:when>
				<c:when test="${rev.mr_grade == 5}">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
					<img src="${pageContext.request.contextPath}/images/cje/star_yes.png">
				</c:when>
				</c:choose>
				</div>
				
				
				<div class="my_review">${rev.mr_content}</div>
			</div>
			<div class="review_delete_btn">
				<input type="button" class="add_del_btn"  value="삭제">
			</div>
		</div>
		<div class="review_fav_date">
			<span class="favCount"><img src="${pageContext.request.contextPath}/images/like01.png"width="17"></span> <span>${rev.fav_cnt }</span> | <span>${rev.mr_regdate}</span>
		</div>
	</div>
	</c:forEach>
	</c:if>
	<!-- 반복 -->
	

	
</div>
<!-- 나의 별점 끝 -->

<style>
.review_img img{
width:15px;
height:15px;
}
</style>