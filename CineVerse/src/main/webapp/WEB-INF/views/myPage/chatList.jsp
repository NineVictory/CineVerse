<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
#search_form {
    justify-content: center;
    align-items: center;
    display: flex;
}

.search {
padding:0;
	gap: 30px;
    display: flex;
    flex-direction: row;
}

input[type="search"] {
    width: 500px;
    height: 50px;
    padding: 20px 10px;
    font-size: 16px;
    background-color: #EBE9E9;
    border: none;
    border-radius: 10px;
    color: #8D8D8D;
    position: relative;
}

.result-display {
margin-top :10px;
display: flex;
    justify-content: center;
}
</style>

<!-- 채팅 이력 시작 -->
<div class="myPage_main">
	<div class="reservation_display">
		<span class="myPage_title_re">채팅 이력</span>
	</div>
	<div class="talk_list_all">
	<form action="talkList" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='chatList'">
			</li>
		</ul>
	</form>	
	</div>
	<c:if test="${count==0}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count>0}">
	<table class="striped-table">
		<c:forEach var="talk" items="${list}">
		<tr>
			<td style="text-align:left;">
				<a href="#" onclick="openInNewWindow('${pageContext.request.contextPath}/talk/talkDetail?talkroom_num=${talk.talkroom_num}'); return false;">
					<b>${talk.talkMemberVO.room_name}(${talk.room_cnt})</b>
					<br>	
					<span>${fn:substring(talk.talkVO.message,0,45)}</span>
				</a>
				</td>
			<td>
				<c:if test="${!empty talk.talkVO.chat_date}">${talk.talkVO.chat_date}</c:if>
				<c:if test="${empty talk.talkVO.chat_date}">${talk.talkroom_date}</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
	
</div>



<script>
			function openInNewWindow(url) {
    window.open(url, '_blank', 'width=800,height=600');
}
</script>
<!-- 채팅 이력 끝 -->