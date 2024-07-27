<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 나의 문의 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">나의 이벤트 참여 내역</span>
		 <select class="myCoupon_option" onchange="location.href='/myPage/myEvent?category=' + this.value;">
            <option value="0" <c:if test="${param.category == 0}">selected</c:if>>전체</option>
            <option value="1" <c:if test="${param.category == 1}">selected</c:if>>이벤트</option>
            <option value="2" <c:if test="${param.category == 2}">selected</c:if>>클라우드소싱</option>
        </select>
	</div>
	<!-- 반복 -->
	<c:if test="${count == 0}"><div class="empty_position">참여한 이벤트 내역이 없습니다.</div></c:if>
	<c:if test="${count > 0}">
	<c:forEach var="event" items="${list}">
	<div class="consult_box">
		<div class="consult_content">
			<div class="my_consult">
				<div class="my_board_type">${event.event_start} ~ ${event.event_end} </div>
				<div class="my_consult_title" onclick="location.href='/event/eventDetail?event_num=${event.event_num}'">${event.event_name}</div>
			</div>
			<div class="my_consult_check">
				<div>당첨 확인</div>
			</div>
		</div>
	</div>
	</c:forEach>
	</c:if>
	<!-- 반복 -->
	
</div>
<!-- 나의 문의 끝 -->