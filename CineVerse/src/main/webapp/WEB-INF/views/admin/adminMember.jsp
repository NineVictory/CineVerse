<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function stopMember(mem_num) {
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
    function deleteMember(mem_num) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/stopMember",
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
</script>

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">회원관리</p>
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
                <th>회원번호</th>
                <th>아이디</th>
                <th>상태</th>
                <th>등급</th>
                <th>맴버십</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>가입일</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${adminList}">
                <tr>
                    <td class="mem-data">${member.mem_num}</td>
                    <td class="mem-data">${member.mem_id}</td>
                    <td class="mem-data">${member.mem_auth}</td>
                    <td class="mem-data">${member.mem_rank}</td>
                    <td class="mem-data">${member.mem_membership}</td>
                    <td class="mem-data">${member.mem_name}</td>
                    <td class="mem-data">${member.mem_phone}</td>
                    <td class="mem-data">${member.mem_email}</td>
                    <td class="mem-data">${member.mem_reg_date}</td>
                    <td class="button1"><input type="button" value="정지" onclick="stopMember(${member.mem_num})" /></td>
                    <td class="button2"><input type="button" value="탈퇴" onclick="deleteMember(${member.mem_num})" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

