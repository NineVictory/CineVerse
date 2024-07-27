<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/event.participation.js"></script>

<div class="page-container page-main">
	<div class="event-main">
		<div class=" list-btn-container2" style="width:100%" onclick="location.href='event'" >
			<img src="${pageContext.request.contextPath}/images/kbm/arrow_left.png" width="23px;" height="21px;">
			<input type="button" value="목록" class="list-btn">
		</div>
		<div class="제목 기간" style="width:100%">
			<hr size="1" width="100%;">
			<div class="flexbox-h side event-detail-container">
				<div>
					<span class="event-type">
						<c:if test="${event.event_type == 1}">영화</c:if>
						<c:if test="${event.event_type == 2}">시사회/무대인사</c:if>
						<c:if test="${event.event_type == 3}">영화관</c:if>
						<c:if test="${event.ep_type == 2}">크라우드소싱</c:if>
					</span>
					<span>${event.event_name}</span>
				</div>
				<span>기간 : ${event.event_start} ~ ${event.event_end}</span>
			</div>
			<hr size="1" width="100%;">
		</div>
		<div class="event-info-main">
			${event.event_content}
		</div>
		<div class="align-right list-btn-container" style="width:100%" onclick="location.href='event'" >
			<img src="${pageContext.request.contextPath}/images/kbm/arrow_left.png" width="23px;" height="21px;">
			<input type="button" value="목록" class="list-btn">
		</div>
		<hr size="1" width="100%">
		<c:if test="${event.ep_type == 1}">
		<div class="align-center participate-btn-container" style="width:100%">
			<input id="event_participate_btn" type="button" value="이벤트 참여하기" data-num="${event.event_num}">
		</div>
		</c:if>
		
		<c:if test="${event.ep_type == 2}">
		<div class="align-center participate-btn-container" style="width:100%">
			<input id="event_participate_btn2" type="button" value="투표하기" data-num="${event.event_num}">
		</div>
		
		
		<div id="eventModal" class="event-modal">
	        <div class="event-modal-content">
	            <div class="modal-close-con"><span class="modal-close">&times;</span></div>
	            
	            <%-- <form:form action="" id="event_vote" method="post" modelAttribute="">
	            	<form:radiobutton path="" value="1"/>스파이더맨
	            	<form:radiobutton path="" value="2"/>토르
	            	<form:radiobutton path="" value="3"/>아이언맨
	            	<form:radiobutton path="" value="4"/>캡아
	            	<form:errors path="" cssClass="error-color"/>
	            	
	            	<div class="flexbox-h side btn-container">
						<form:button class="">투표하기</form:button>
						<input type="button" id="modal_cancel" value="취소" class="default-btn4">
					</div>
	            </form:form> --%>
	            
	            <form action="insertCrowd" id="event_vote" method="post">
	            	<input type="hidden" name="event_num" value="${event.event_num}">
	            	<div class="radio-container">
		            	<input type="radio" name="ep_content" value="crowd_movie1"> ${event.crowd_movie1}<br>
		            	<input type="radio" name="ep_content" value="crowd_movie2"> ${event.crowd_movie2}<br>
		            	<input type="radio" name="ep_content" value="crowd_movie3"> ${event.crowd_movie3}<br>
		            	<input type="radio" name="ep_content" value="crowd_movie4"> ${event.crowd_movie4}
	            	</div>
	            	<div class="modal-btn-con">
						<input type="submit" class="movie" value="투표하기">
						<input type="button" id="modal_cancel" value="취소" class="default-btn4">
					</div>
	            </form>
	        </div>
    	</div>
		
		</c:if>
		
	</div>
</div>


