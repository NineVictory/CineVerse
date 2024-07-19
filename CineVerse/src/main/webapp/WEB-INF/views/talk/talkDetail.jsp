<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 채팅 메시지 처리 시작 -->
<script src="${pageContext.request.contextPath}/js/talk.js"></script>
<div id="talkDetail" class="page-main">
	<div id="chatroom_title"><span id="chatroom_name">${room_name}</span> 채팅방
		<input type="button" value="채팅방이름 변경" id="change_name">
	</div> 
	<div class="align-right">
	    <input type="button" value="대화 종료" id="delete_talkroom">
	</div>    
	<p>
		채팅 멤버 : 
		<span id="chat_member">${chatMember}</span><span id="chat_mcount">(${chatCount}명)</span>
	</p>    
	<div id="chatting_message"></div>
	<form id="detail_form">
		<input type="hidden" name="talkroom_num" id="talkroom_num" value="${param.talkroom_num}">	
	    <textarea rows="5" cols="40" name="message" id="message"></textarea>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>
</div>
<!-- 채팅 메시지 처리 끝 -->

<style>

/* 채팅방 제목 */
#chatHeader {
    background-color: #007bff;
    color: #fff;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-radius: 8px 8px 0 0;
}

#chatroom_name {
    font-size: 1.5em;
}

/* 버튼 스타일 */
.btn {
    border: none;
    border-radius: 4px;
    padding: 8px 15px;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s ease;
}

.btn-primary {
    background-color: #007bff;
    color: #fff;
}

.btn-secondary {
    background-color: #6c757d;
    color: #fff;
}

.btn-danger {
    background-color: #dc3545;
    color: #fff;
}

.btn-outline {
    background-color: transparent;
    border: 1px solid #007bff;
    color: #007bff;
}

.btn-send {
    background-color: #28a745;
    color: #fff;
    width: 100%;
    padding: 10px;
}

/* 채팅방 액션 버튼 */
.chat-actions {
    margin: 15px 0;
    text-align: right;
}

/* 채팅 내용 */
#chatting_message {
    border: 1px solid black;
    width: 660px;
    height: 300px;
    margin: 0 auto;
    padding: 10px;
    overflow: auto;
    background-color: #f9f9f9; /* 배경 색상 추가로 메시지 확인하기 */
}

/* 날짜 및 메시지 스타일 */
.date-position {
    text-align: center;
}

.date-position span {
    display: inline-block;
    width: auto;
    padding: 5px 10px;
    border-radius: 15px;
    background-color: #e9ecef;
    margin: 5px;
}

/* 메시지 스타일 */
.from-position, .to-position {
    margin: 10px 0;
}

.from-position .item, .to-position .item {
    padding: 10px;
    border-radius: 20px;
    max-width: 60%;
    word-break: break-word;
}

.from-position .item {
    background-color: #e2e3e5;
    align-self: flex-start;
}

.to-position .item {
    background-color: #d4edda;
    align-self: flex-end;
}

/* 메시지 입력폼 */
form#detail_form {
    display: flex;
    flex-direction: column;
    margin-top: 10px;
}

#message {
    width: calc(100% - 20px);
    margin: 10px auto;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #ccc;
}

#message_btn {
    display: flex;
}

#message_btn .btn-send {
    margin-top: 10px;
}
</style>






