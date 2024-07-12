<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
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

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">이벤트</p>
	</div>
		<form action="adminSearch" id="admin_search">
			<ul>
				<li>
					<input type="search" name="search" placeholder="제목을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<p id = "sub_title2">이벤트 관리</p>
		<div class = "body_table">
		<input type = "button" value = "이벤트 등록" class = "insert_button" onclick = "location.href ='${pageContext.request.contextPath}/admin/adminEventForm'"/>
		<table class="adminMember-table">
        <thead>
            <tr>
                <th>글 번호</th>
                <th>제목</th>
                <th>시작일</th>
                <th>마감일</th>
                <th>등록일</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="event" items="${adminList}">
                <tr>
                    <td class="mem-data">${event.event_num}</td>
                    <td class="mem-data">${event.event_name}</td>
                    <td class="mem-data">${event.event_start}</td>
                    <td class="mem-data">${event.event_end}</td>
                    <td class="mem-data">${event.event_reg_date}</td>
                    <td class="button2"><input type="button" value="삭제" onclick="deleteEvent(${event.event_num})"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>

</div>