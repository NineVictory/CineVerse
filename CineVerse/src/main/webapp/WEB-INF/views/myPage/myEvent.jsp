<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- 나의 문의 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">나의 이벤트 참여 내역</span> <select
			class="myCoupon_option"
			onchange="location.href='/myPage/myEvent?category=' + this.value;">
			<option value="0" <c:if test="${param.category == 0}">selected</c:if>>전체</option>
			<option value="1" <c:if test="${param.category == 1}">selected</c:if>>이벤트</option>
			<option value="2" <c:if test="${param.category == 2}">selected</c:if>>클라우드소싱</option>
		</select>
	</div>
	<!-- 반복 -->
	<c:if test="${count == 0}">
		<div class="empty_position">참여한 이벤트 내역이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<c:forEach var="event" items="${list}">
			<c:if test="${event.ep_type ==1 }">
				<div class="consult_box">
					<div class="consult_content">
						<div class="my_consult">
							<div class="my_board_type">${event.event_start}~
								${event.event_end}</div>
							<div class="my_consult_title"
								onclick="location.href='/event/eventDetail?event_num=${event.event_num}'">${event.event_name}</div>
						</div>
						<div class="ep_result_btn">당첨 확인</div>
						<c:if test="${event.ep_result== 1 }">
							<script type="text/javascript">
							$('.ep_result_btn').click(function(){
								alert('미당첨입니다.\n다음에 한 번 더 도전해보세요!');
							})
							</script>
						</c:if>
						<c:if test="${event.ep_result== 2 }">
							<script type="text/javascript">
							$('.ep_result_btn').click(function(){
								alert('당첨입니다.\n축하드립니다!');
							})
							</script>
						</c:if>
					</div>
				</div>
			</c:if>
			<c:if test="${event.ep_type ==2 }">
				<div class="consult_box">
					<div class="consult_content2">
						<div class="my_consult2">
							<div class="my_board_type">${event.event_start}~
								${event.event_end}</div>
							<div class="my_consult_title"
								onclick="location.href='/event/eventDetail?event_num=${event.event_num}'">${event.event_name}</div>
						</div>
						<div class="my_consult_check2">
							<div>
							<c:choose>
								<c:when test="${event.ep_content == 'crowd_movie1'}">
									${event.crowd_movie1}
								</c:when>
								<c:when test="${event.ep_content == 'crowd_movie2'}">
									${event.crowd_movie2}
								</c:when>
								<c:when test="${event.ep_content == 'crowd_movie3'}">
									${event.crowd_movie3}
								</c:when>
								<c:when test="${event.ep_content == 'crowd_movie4'}">
									${event.crowd_movie4}
								</c:when>
							</c:choose>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</c:if>
	<!-- 반복 -->

</div>
<!-- 나의 문의 끝 -->