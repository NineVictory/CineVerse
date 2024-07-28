<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
	function redirectToEventParticipants(event_num) {
    	window.location.href = '/admin/eventParticipants?event_num=' + event_num;
	}
    function redirectToEventDetail(event_num) {
        window.location.href = '/event/eventDetail?event_num=' + event_num;
    }
    function redirectToEventModify(event_num) {
        window.location.href = '/admin/adminEventModify?event_num=' + event_num;
    }
    function deleteEvent(event_num) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteEvent",
            data: { event_num: event_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("이벤트 게시물 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("이벤트 게시물 삭제실패");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
</script>
<div class="page-container">
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">이벤트</p>
	</div>
		<form action="adminEvent" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'event_name'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="제목을 입력하세요">
        		    <input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<div class="insert_button_all">
			<input type = "button" value = "크라우드 소싱 등록" class = "insert_button" onclick = "location.href ='${pageContext.request.contextPath}/admin/adminCrowdForm'" style="margin-right: 10px;"/>
			<input type = "button" value = "이벤트 등록" class = "insert_button" onclick = "location.href ='${pageContext.request.contextPath}/admin/adminEventForm'"/>
		</div>
		<div class = "body_table">
		<table class="adminMember-table">
        <thead>
            <tr>
                <th>글 번호</th>
                <th>제목</th>
                <th>시작일</th>
                <th>마감일</th>
                <th>등록일</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="event" items="${list}">
                <tr>
                    <td class="mem-data">${event.event_num}</td>
                    <td class="mem-data" onclick="redirectToEventDetail(${event.event_num})" id = "intoEventDetail">${event.event_name}</td>
                    <td class="mem-data">${event.event_start}</td>
                    <td class="mem-data">${event.event_end}</td>
                    <td class="mem-data">${event.event_reg_date}</td>
                    <td class="button3">
                    <c:choose>
                    	<c:when test="${event.ep_type==1 }">
                    		<input type="button" value="이벤트 신청자" onclick="redirectToEventParticipants(${event.event_num})"/>
                    	</c:when>
                   		<c:when test="${event.ep_type==2 }"> 
                    		<input type="button" value="이벤트 신청자" onclick = "location.href ='${pageContext.request.contextPath}/admin/adminCrowdParticipants?event_num=${event.event_num}'"/> 
                    	</c:when> 
                    </c:choose></td>
                    <td class="button1">
                    <c:choose>
                    	<c:when test="${event.ep_type==1 }">
                    		<input type="button" value="수정" onclick="redirectToEventModify(${event.event_num})"/> 
                    	</c:when>
                   		<c:when test="${event.ep_type==2 }"> 
                    		<input type="button" value="수정" onclick=""/> 
                    	</c:when> 
                    </c:choose> </td>
                    <td class="button2"><input type="button" value="삭제" onclick="deleteEvent(${event.event_num})"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>
	<div class="page-div">${page}</div> 
</div>
