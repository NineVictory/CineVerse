<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<div class="page-container page-main">
	<div class="event-main">
		<div class="제목 기간" style="width:100%">
			<hr size="1" width="100%;">
			<div>
				<div>
					<span>
						<c:if test="${event.event_type == 1}">영화</c:if>
						<c:if test="${event.event_type == 2}">시사회/무대인사</c:if>
						<c:if test="${event.event_type == 3}">제휴할인</c:if>
					</span>
					<span>${event.event_name}</span>
				</div>
				<span>기간 : ${event.event_start} ~ ${event.event_end}</span>
			</div>
			<hr size="1" width="100%;">
		</div>
		<div class="event-info-main">
			${event.event_content}
			<div>
				<input id="event_participate_btn" type="button" value="이벤트 참여하기" data-num="${event.event_num}">
			</div>
		</div>
		<div>
			<input type="button" value="목록">
		</div>
	</div>
</div>


