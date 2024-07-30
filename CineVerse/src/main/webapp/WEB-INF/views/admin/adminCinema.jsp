<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
	function redirectToCinemaModify(c_num) {
		var userConfirmed = confirm("영화관을 수정하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
	    window.location.href = '/admin/adminCinemaModify?c_num=' + c_num;
	}
	}
    function deleteCinema(c_num) {
		var userConfirmed = confirm("영화관을 삭제하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteCinema",
            data: { c_num: c_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("영화관 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("영화관 삭제 실패");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }}
</script>

<div class="page-container">	
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">영화관관리</p>
	</div>
		<form action="adminCinema" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'c_branch'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="지점명을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>영화관번호</th>
                <th>지점명</th>
                <th>지역</th>
                <th>전화번호</th>
                <th>주차</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="cinema" items="${list}">
                <tr>
                    <td class="mem-data">${cinema.c_num}</td>
                    <td class="mem-data">${cinema.c_branch}</td>
                    <c:if test = "${cinema.c_location == 1}">
                    <td class="mem-data">서울</td>
                    </c:if>
                    <c:if test = "${cinema.c_location == 2}">
                    <td class="mem-data">경기</td>
                    </c:if>
                    <c:if test = "${cinema.c_location == 3}">
                    <td class="mem-data">인천</td>
                    </c:if>
                    <c:if test = "${cinema.c_location == 4}">
                    <td class="mem-data">강원</td>
                    </c:if>
                    <c:if test = "${cinema.c_location == 5}">
                    <td class="mem-data">대전/충청</td>
                    </c:if>
                    <c:if test = "${cinema.c_location == 6}">
                    <td class="mem-data">경상</td>
                    </c:if>
                    <c:if test = "${cinema.c_location == 7}">
                    <td class="mem-data">광주/전라</td>
                    </c:if>
                   
                    <td class="mem-data">${cinema.c_phone}</td>
                    <c:if test ="${cinema.c_parkable == 1}">
                    <td class="mem-data">가능</td>						
					</c:if>
					<c:if test ="${cinema.c_parkable == 0}">
                    <td class="mem-data">불가능</td>						
					</c:if>
                    <td class="button1"><input type="button" value="수정"
							onclick="redirectToCinemaModify(${cinema.c_num})"/>
                    <td class="button2"><input type="button" value="삭제" onclick="deleteCinema(${cinema.c_num})"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
	<div class="page-div">${page}</div> 
</div>


