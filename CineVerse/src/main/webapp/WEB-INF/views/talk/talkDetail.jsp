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
document.addEventListener('DOMContentLoaded', function() {
    const changeNameButton = document.getElementById('change_name');
    const chatroomName = document.getElementById('chatroom_name');
    
    let isEditing = false; // 상태 변수 추가

    changeNameButton.addEventListener('click', function() {
        if (!isEditing) {
            // 현재 채팅방 이름을 가져와서 입력 필드로 변환
            const currentName = chatroomName.textContent;
            const inputField = document.createElement('input');
            inputField.type = 'text';
            inputField.value = currentName;
            inputField.id = 'name_input';
            inputField.className = 'form-control';
            
            // 채팅방 이름 span을 입력 필드로 교체
            chatroomName.replaceWith(inputField);
            
            // 버튼 텍스트를 '저장'으로 변경
            changeNameButton.value = '저장';
            isEditing = true; // 상태 변경
        } else {
            // 입력 필드의 값을 채팅방 이름으로 변경
            const newName = document.getElementById('name_input').value;
            const newSpan = document.createElement('span');
            newSpan.id = 'chatroom_name';
            newSpan.textContent = newName;
            
            // 입력 필드를 span으로 교체
            document.getElementById('name_input').replaceWith(newSpan);
            
            // 버튼 텍스트를 '채팅방이름 변경'으로 변경
            changeNameButton.value = '채팅방이름 변경';
            isEditing = false; // 상태 변경
        }
    });
});


</script>
