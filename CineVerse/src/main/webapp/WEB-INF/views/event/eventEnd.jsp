<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<div class="page-container page-main">
	<div class="event-main">
		<div class="event">
			<h1>EVENT</h1>
			<%--<div class="event-type-btn">
				<input type="button" value="당첨자 발표" class="event_btn">
			</div> --%>
		</div>
		<div class="event-menu-all">
			<div class="event-menu2">
				<h4>종료된 이벤트</h4>
			</div>
		</div>

		<div class="event-list-main2">
			<c:if test="${count > 0}">
				<div class="event-infos">
					<c:forEach var="event" items="${list}">
					<table class="endEventTable">
						<tr class="endEvent-tr">
							<td class="endEvent-image">
								<a href="eventDetail?event_num=${event.event_num}">
									<img src="${pageContext.request.contextPath}/upload/${event.event_filename}" class="endEvent-img">
								</a>
							</td>
							<td class="endEvent-title">
								<div class="flexbox-p">
								<a href="eventDetail?event_num=${event.event_num}">
									<span class="event-type">
										<c:if test="${event.event_type == 1}">영화</c:if>
										<c:if test="${event.event_type == 2}">시사회/무대인사</c:if>
										<c:if test="${event.event_type == 3}">영화관</c:if>
										<c:if test="${event.ep_type == 2}">크라우드소싱</c:if>
									</span>
									<span>${event.event_name}</span>
								</a>	
								</div>
							</td>
							<td class="endEventP">기간: ${event.event_start} ~ ${event.event_end}</td>
						</tr>
					</table>	
					</c:forEach>
				</div>
			</c:if>
				<%--<ul class="event-list">
					<c:forEach var="event" items="${list}" varStatus="status">
						<li class="<c:if test="${(status.index + 1) % 4 == 0}">no-margin</c:if>">
							<a href="eventDetail?event_num=${event.event_num}" class="event-img">
								<img src="${pageContext.request.contextPath}/upload/${event.event_filename}" alt="이벤트 대표 사진" >
								<span class="event-title flexbox-p">
									<span style="font-size: 16px; font-weight: 600;">${event.event_name}</span>
									<span style="font-size: 13px">${event.event_start}~${event.event_end}<b class="event-dday">D-${event.t_rest}</b></span>
								</span>
							
							</a>
	
						</li>
					</c:forEach>
					
				</ul> --%>
			
			<c:if test="${count == 0}">
				<div class="noEvent">이벤트가 없습니다.</div>	
			</c:if>
		</div>
		<div class="align-center page-count">${page}</div>

	</div>
</div>
