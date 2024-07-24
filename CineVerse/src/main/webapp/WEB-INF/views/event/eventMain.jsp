<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/event.list.js"></script>

<div class="page-container page-main">
	<div class="event-main">
		<div class="event">
			<h1>EVENT</h1>
		</div>
		<div class="event-menu-all">
			<div class="event-menu">
				<span><a href="event">ALL</a></span>
				<span><a href="event?event_type=1">영화</a></span>
				<span><a href="event?event_type=2">시사회/무대인사</a></span>
				<%-- <span><a href="event?event_type=3">제휴 할인</a></span> --%>
			</div>
			<div class="event-type-btn">
				<input type="button" value="당첨자 발표" class="event_btn">
				<input type="button" value="종료된 이벤트" class="event_btn">
			</div>
		</div>

		<div class="event-list-main">
			<c:if test="${count > 0}">
				<div class="event-infos">
				
				<ul class="event-list">
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
					<%-- <li>
						<a href="#" class="event-img">
							<img src="https://img.cgv.co.kr/WebApp/contents/eventV4/41106/17200776837670.jpg" alt="이벤트 대표 사진" >
							<span class="event-title">
								<span style="font-size: 16px; font-weight: 600;">[탈주] 디깅타임</span>
								<span style="font-size: 13px">2024.07.10~2024.07.21<b class="event-dday">D-6</b></span>
							</span>
						
						</a>

					</li> --%>
					
				</ul>
				</div>
			</c:if>
			<c:if test="${count == 0}">
				<div class="noEvent">이벤트가 없습니다.</div>	
			</c:if>
		</div>
		<button id="load-more">더보기</button>
	</div>
</div>
