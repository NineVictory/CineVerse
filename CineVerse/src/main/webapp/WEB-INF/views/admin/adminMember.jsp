<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function stopMember(mem_num) {
		var userConfirmed = confirm("회원을 정지하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/stopMember",
            data: { mem_num: mem_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("회원을 정지시켰습니다.");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("회원 정지에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
        }
    }
    function deleteMember(mem_num) {
		var userConfirmed = confirm("회원을 삭제하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteMember",
            data: { mem_num: mem_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("회원을 탈퇴시켰습니다.");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("회원 탈퇴에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
    }
    function recoverMember(mem_num) {
    	var userConfirmed = confirm("회원을 복구하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/recoverMember",
            data: { mem_num: mem_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("회원을 복구시켰습니다.");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("회원 복구에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
        }
    }
</script>

<div class="page-container">
	<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">회원관리</p>
	</div>
		<form action="adminMember" id="admin_search">
  	 	 <ul> 
        <li>
        	<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mem_name'}"> <!-- 기본값 설정 -->
           	<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="회원명을 입력하세요">
            <input type="submit" value="" class="search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
        </li>
    </ul>
</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>상태</th>
                <th>등급</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>가입일</th>
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
            <c:forEach var="member" items="${list}">
                <tr>
                    <td class="mem-data">${member.mem_num}</td>
                    <td class="mem-data">${member.mem_id}</td>
                    <td class="mem-data">
                     <c:choose>
                    	<c:when test="${member.mem_auth == 1}">탈퇴</c:when>
                    	<c:when test="${member.mem_auth == 2}">정지</c:when>
                    	<c:when test="${member.mem_auth == 3}">일반</c:when>
                    	<c:when test="${member.mem_auth == 9}">관리자</c:when>
                   	 </c:choose>
                    </td>
                    <td class="mem-data">
                    <c:choose>
                    	<c:when test="${member.mem_rank == 1}">BASIC</c:when>
                    	<c:when test="${member.mem_rank == 2}">MEMBER</c:when>
                    	<c:when test="${member.mem_rank == 3}">REGULAR</c:when>
                    	<c:when test="${member.mem_rank == 4}">VIP</c:when>
                    	<c:when test="${member.mem_rank == 5}">VVIP</c:when>
                    </c:choose>
                    </td>
                    <td class="mem-data">${member.mem_name}</td>
                    <td class="mem-data">${member.mem_phone}</td>
                    <td class="mem-data">${member.mem_email}</td>
                    <td class="mem-data">${member.mem_reg_date}</td>
                    <c:if test = "${member.mem_auth == 3}">
                    <td class="button1"><input type="button" value="정지" onclick="stopMember(${member.mem_num})" /></td>
                    </c:if>
                    <c:if test="${member.mem_auth == 2 || member.mem_auth == 1}">
                    <td class="button3"><input type="button" value="복구" onclick="recoverMember(${member.mem_num})" /></td>
                    </c:if>
                    <c:if test="${member.mem_auth ==9}">
                    <td class="button1"><input type="button" value="권한삭제" onclick="recoverMember(${member.mem_num})" /></td>
                    </c:if>                
                    <td class="button2"><input type="button" value="탈퇴" onclick="deleteMember(${member.mem_num})" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
	</div>
	<div class="page-div">${page}</div> 
</div>

