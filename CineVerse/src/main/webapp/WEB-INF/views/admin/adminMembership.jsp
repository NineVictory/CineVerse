<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function refundMembership(mem_num) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/refundMembership",
            data: { mem_num: mem_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("구독이 취소되었습니다.");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("구독 취소에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
</script>
<div class="page-container">

<div class="admin_member">
	<div class="firstTitle">
		<p id="title">멤버십관리</p>
	</div>
	<form action="adminMembership" id="admin_search">
		<ul>
			<li>
			<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mem_name'}"> <!-- 기본값 설정 -->
           	<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="회원명을 입력하세요">
			<input type="submit" value="" class="search-button"
				style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
			</li>
		</ul>
	</form>
	<table class="adminMember-table">
		<thead>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>등급</th>
				<th>멤버십</th>
				<th>이름</th>
				<th>가입일</th>
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
					<td class="mem-data">${member.mem_rank}</td>
					<td class="mem-data">구독중</td>
					<td class="mem-data">${member.mem_name}</td>
					<td class="mem-data">${member.mem_reg_date}</td>
					<td class="button2"><input type="button" value="구독취소" onclick="refundMembership(${member.mem_num})"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
	<div class="page-div">${page}</div> 
</div>
