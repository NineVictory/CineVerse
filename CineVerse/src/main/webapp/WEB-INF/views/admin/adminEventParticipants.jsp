<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#randomselect').click(function() {
        // 이벤트 번호를 가져옴
        var eventNum = ${event_num}; 

        // Ajax 요청 보내기
        $.ajax({
            type: 'post',
            url: 'adminEventResult',
            data: { event_num: eventNum },
            dataType: 'json',
            success: function(param) {
            	if(param.result == 'success'){
            		alert('당첨자 발표가 완료되었습니다.')
            		window.location.reload();
            	} else if (param.result == 'participantsizelow'){
            		alert('이벤트 참여자가 당첨 가능한 숫자를 충족 시키지 못합니다.')
            	} else if (param.result == 'alreadydone'){
            		alert('당첨자 발표가 완료된 이벤트입니다.')
            	} else {
            		alert('당첨자 발표 중 오류가 발생하였습니다.')
            	}
            },
            error: function() {
				alert('네트워크 오류가 발생하였습니다.')
            }
        });
    });
});
</script>
    
    
<div class="page-container">
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">이벤트 참여 명단</p>
	</div>
		<div class="insert_button_all">
			<input type = "button" value = "당첨자 발표" class = "insert_button" id="randomselect" style="margin-right: 10px;"/>
<%-- 			<input type = "button" value = "이벤트 등록" class = "insert_button" onclick = "location.href ='${pageContext.request.contextPath}/admin/adminEventForm'"/>
 --%>		</div>
		<div class="body_table">
		<table class="adminMember-table">
        <thead>
            <tr>
                <th>이벤트 번호</th>
                <th>이벤트 제목</th>
                <th>이벤트 신청 날짜</th>
                <th>아이디</th>
                <th>결과</th> 
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
                    <td class="mem-data">${event.ep_date}</td>
                    <td class="mem-data">${event.mem_id}</td>
                    <td class="mem-data">
                    <c:if test="${event.ep_result == 1}">미당첨</c:if>
                    <c:if test="${event.ep_result == 2}">당첨</c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>
</div>