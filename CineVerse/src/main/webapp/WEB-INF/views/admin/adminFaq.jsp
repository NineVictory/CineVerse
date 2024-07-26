<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function deleteFaq(f_num) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteFaq",
            data: { f_num: f_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("FAQ 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("FAQ 삭제실패");
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
			<p id="title">FAQ</p>
		</div>
		<form action="adminFaq" id="admin_search">
			<ul>
				<li><input type="hidden" name="keyfield"
					value="${param.keyfield != null ? param.keyfield : 'f_title'}">
					<!-- 기본값 설정 --> <input type="search" name="keyword" id="keyword"
					value="${param.keyword}" placeholder="을 입력하세요"> <input
					type="submit" value="" class="search-button"
					style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<div class="insert_button_all">
			<input type="button" value="FAQ 등록" class="insert_button"
				onclick="location.href ='${pageContext.request.contextPath}/admin/adminFaqForm'" />
		</div>
		<div class="body_table">
			<table class="adminMember-table">
				<thead>
					<tr>
						<th>글 번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
						<th></th>
					</tr>
				</thead>
				<c:if test="${empty list}">
					<tr>
						<td colspan="7" class="mem-data">데이터가 없습니다.</td>
					</tr>
				</c:if>
				<tbody>
					<c:forEach var="faq" items="${list}">
						<tr>
							<td class="mem-data">${faq.f_num}</td>
							<td class="mem-data">${faq.f_title}</td>
							<td class="mem-data">${faq.f_reg_date}</td>
							<td class="mem-data">${faq.f_hit}</td>
							<td class="button2"><input type="button" value="삭제"
								onclick="deleteFaq(${faq.f_num})" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="page-div">${page}</div>
</div>