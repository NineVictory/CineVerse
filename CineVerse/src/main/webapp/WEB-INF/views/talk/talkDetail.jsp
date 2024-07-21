<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talkDetail.css" type="text/css">

<!-- 채팅 메시지 처리 시작 -->
<script src="${pageContext.request.contextPath}/js/talk.js"></script>
<div id="talkDetail" class="page-main">
<div id="chatHeader">
    <span id="chatroom_name">${room_name}</span>
    <input type="button" value="채팅방이름 변경" id="change_name" class="btn btn-secondary">
</div>

    <div class="align-right chat-actions">
        <input type="button" value="대화 종료" id="delete_talkroom" class="btn btn-danger">
    </div>
    <div id="chatting_message"></div>
    <form id="detail_form">
        <input type="hidden" name="talkroom_num" id="talkroom_num" value="${param.talkroom_num}">
        <textarea rows="5" cols="40" name="message" id="message"></textarea>
        <div id="message_btn">
            <input type="submit" value="전송" class="btn btn-send">
        </div>
    </form>
</div>

<!-- 채팅 메시지 처리 끝 -->

<script type="text/javascript">

</script>
