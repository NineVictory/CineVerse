<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
    
<div class="page-container">
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">크라우드 소싱 현황</p>
	</div>
		<div class="body_table">
		<table class="adminMember-table">
        <thead>
            <tr>
                <th>영화 제목</th>
                <th>신청 수</th> 
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
                <tr>
                    <td class="mem-data">${eventDetail.crowd_movie1}</td>
                    <td class="mem-data">${m1Count}</td>
                </tr>
				<tr>
				                    <td class="mem-data">${eventDetail.crowd_movie2}</td>
				                    <td class="mem-data">${m2Count}</td>
				                </tr>
								<tr>
								                    <td class="mem-data">${eventDetail.crowd_movie3}</td>
								                    <td class="mem-data">${m3Count}</td>
								                </tr>
												<tr>
												                    <td class="mem-data">${eventDetail.crowd_movie4}</td>
												                    <td class="mem-data">${m4Count}</td>
												                </tr>
        </tbody>
    </table>
    </div>
	<div class="body_table">
			<table class="adminMember-table">
	        <thead>
	            <tr>
	                <th>크라우드 소싱 번호</th>
	                <th>크라우드 소싱 제목</th>
	                <th>크라우드 소싱 참여 날짜</th>
	                <th>아이디</th>
	                <th>신청 영화</th> 
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
	                    <c:if test="${event.ep_content == 'crowd_movie1'}">${event.crowd_movie1}</c:if>
						<c:if test="${event.ep_content == 'crowd_movie2'}">${event.crowd_movie2}</c:if>
						<c:if test="${event.ep_content == 'crowd_movie3'}">${event.crowd_movie3}</c:if>
						<c:if test="${event.ep_content == 'crowd_movie4'}">${event.crowd_movie4}</c:if>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    </div>
</div>
</div>