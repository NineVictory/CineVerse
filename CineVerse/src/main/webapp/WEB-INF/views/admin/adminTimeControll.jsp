<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-container">
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">영화 시간표 관리</p>
	</div>
		<form action="adminTimeControll" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mt_date'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="상영일을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>시간표 번호</th>
                <th>상영일</th>
                <th>시작 시간</th>
                <th>종료 시간</th>
                <th>영화 코드</th>
                <th>상영관 번호</th>
                <td></td>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="movieTime" items="${list}">
                <tr>
                    <td class="mem-data">${movieTime.mt_num}</td>
                    <td class="mem-data">${movieTime.mt_date}</td>
                    <td class="mem-data">${movieTime.mt_start}</td>
                    <td class="mem-data">${movieTime.mt_end}</td>
                    <td class="mem-data">${movieTime.m_code}</td>
                    <td class="mem-data">${movieTime.th_num}</td>    
                    <td class="button1"><input type="button" value="수정"	onclick="redirectToMovieModify(${movieTime.mt_num})"/>
                    <td class="button2"><input type="button" value="삭제" onclick="deleteMovie(${movieTime.mt_num})"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
	<div class="page-div">${page}</div> 
</div>

