<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPage.chat.css" type="text/css">

<!-- 채팅 이력 시작 -->
<div class="myPage_main">
    <div class="reservation_display">
        <span class="myPage_title_re">채팅 이력</span>
    </div>
    
    <c:if test="${count == 0}">
        <div class="result-display">표시할 채팅방이 없습니다.</div>
    </c:if>
    <c:if test="${count > 0}">
        <c:forEach var="talk" items="${list}">
            <div class="chat-card">
                <div class="chat-card-content">
                    <a href="#" onclick="openInNewWindow('${pageContext.request.contextPath}/talk/talkDetail?talkroom_num=${talk.talkroom_num}'); return false;">
                        <div class="chat-card-title">${talk.talkMemberVO.room_name}</div>
                        <div class="chat-card-message">${fn:substring(talk.talkVO.message, 0, 45)}</div>
                    </a>
                </div>
                <div class="cnt_date_info">
                <div class="chat-card-date">
                    <c:if test="${!empty talk.talkVO.chat_date}">${talk.talkVO.chat_date}</c:if>
                    <c:if test="${empty talk.talkVO.chat_date}">${talk.talkroom_date}</c:if>
                </div>
                <c:if test="${talk.room_cnt > 0}">
                    <div class="unread-count">${talk.room_cnt}</div>
                </c:if>
                </div>
                
            </div>
        </c:forEach>
        <div class="align-center">${page}</div>
    </c:if>
</div>

<script>
    function openInNewWindow(url) {
        window.open(url, '_blank', 'width=850,height=680');
    }
</script>
<!-- 채팅 이력 끝 -->
