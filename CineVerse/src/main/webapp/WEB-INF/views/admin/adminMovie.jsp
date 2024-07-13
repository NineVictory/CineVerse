<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<div class="page-container">

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">영화 관리</p>
	</div>
		<form action="adminSearch" id="admin_search">
			<ul>
				<li>
					<input type="search" name="search" placeholder="회원명을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>영화번호</th>
                <th>제목</th>
                <th>개봉일</th>
                <th>제작사</th>
                <th>맴버십</th>
                <th>포스터</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="movie" items="${adminList}">
                <tr>
                    <td class="mem-data">${movie.m_code}</td>
                    <td class="mem-data">${movie.m_name}</td>
                    <td class="mem-data">${movie.m_opendate}</td>
                    <td class="mem-data">${movie.m_companys}</td>
                    <td class="mem-data">${movie.m_status}</td>
                    <td class="mem-data">${movie.m_file_name}</td>
                    <td class="button2"><input type="button" value="삭제" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</div>

