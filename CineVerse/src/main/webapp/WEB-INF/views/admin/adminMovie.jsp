<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
    function deleteMovie(m_code) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteMovie",
            data: { m_code: m_code },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("영화 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("영화 삭제실패");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
</script>
<div class="page-container">

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">영화 관리</p>
	</div>
		<form action="adminMovie" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'm_name'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="영화제목을 입력하세요">
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
                <th>상태</th>
                <th>포스터</th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="movie" items="${list}">
                <tr>
                    <td class="mem-data">${movie.m_code}</td>
                    <td class="mem-data">${movie.m_name}</td>
                    <td class="mem-data">${movie.m_opendate}</td>
                    <td class="mem-data">${movie.m_companys}</td>
                    <c:if test = "${movie.m_status == 2}"><td class="mem-data">미상영</td></c:if>
                    <c:if test = "${movie.m_status == 1}"><td class="mem-data">상영중</td></c:if>
                    <td class="mem-data"><img src="${pageContext.request.contextPath}/upload/${movie.m_filename}" width="50px" height="50px"></td> <!-- 상품 이미지가 있는 속성으로 수정 필요 -->
                    <td class="button2"><input type="button" value="삭제" onclick="deleteMovie(${movie.m_code})"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
	<div class="page-div">${page}</div> 
</div>

