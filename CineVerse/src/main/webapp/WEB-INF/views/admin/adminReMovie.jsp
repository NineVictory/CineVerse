<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function deleteMr(mr_num) {
		var userConfirmed = confirm("리뷰를 삭제하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteMr",
            data: { mr_num: mr_num},
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("영화리뷰 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("영화리뷰 삭제실패");
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
	<div class="admin_member">
		<div class="firstTitle">
			<p id="title">영화 리뷰관리</p>
		</div>
		<form action="adminReMovie" id="admin_search">
			<ul>
				<li><input type="hidden" name="keyfield"
					value="${param.keyfield != null ? param.keyfield : 'mr_content'}">
					<!-- 기본값 설정 --> <input type="search" name="keyword" id="keyword"
					value="${param.keyword}" placeholder="제목를 입력하세요"> <input
					type="submit" value="" class="search-button"
					style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<table class="adminMember-table">
			<thead>
				<tr>
					<th>영화번호</th>
					<th>리뷰번호</th>
					<th>내용</th>
					<th>등록일</th>
					<th>신고수</th>
					<th></th>
				</tr>
			</thead>
			<c:if test="${empty list}">
				<tr>
					<td colspan="7" class="mem-data">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<tbody>
				<c:forEach var="rm" items="${list}">
					<tr>
						<td class="mem-data">${rm.m_code}</td>
						<td class="mem-data">${rm.mr_num}</td>
						<td class="mem-data">${rm.mr_content}</td>
						<td class="mem-data">${rm.mr_regdate}</td>
						<td class="mem-data">${rm.review_count}</td>
						<td class="button2"><input type="button" value="삭제" onclick="deleteMr(${rm.mr_num})" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="page-div">${page}</div>
</div>
