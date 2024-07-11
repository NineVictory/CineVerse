<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
                    <td class="button1"><input type="button" value="삭제" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</div>