<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function deleteReply(cc_num) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteReply",
            data: { cc_num: cc_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("댓글 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("댓글 삭제실패");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
</script>

<script>
    function deleteCmt(te_num) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteCmt",
            data: { te_num: te_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("댓글 삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("댓글 삭제실패");
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
			<p id="title">게시판 댓글 관리</p>
		</div>
		<form action="adminReply" id="admin_search">
			<ul>
				<li><input type="hidden" name="keyfield"
					value="${param.keyfield != null ? param.keyfield : 'mem_id'}">
					<!-- 기본값 설정 --> 
					<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="회원 아이디를 입력하세요"> 
					<input type="submit" value="" class="search-button"
					style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<table class="adminMember-table">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>작성자</th>
					<th>내용</th>
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
			<c:forEach var="re" items="${list}">
				<!-- 댓글 -->
		        <c:if test="${re.data_type == 'reply'}">
		        <tr>
		        	<td class="mem-date">${re.cc_num}</td>
		            <td class="mem-data">${re.mem_id}</td>
		            <td class="mem-data">${re.cc_content}</td> 
		            <c:if test="${!empty re.cc_report}">
		                <td class="mem-data">${re.cc_report}</td>
		            </c:if>
		            <c:if test="${empty re.cc_report}">
		                <td class="mem-data">0</td>
		            </c:if>
	     			   <td class="button2"><input type="button" value="삭제" onclick="deleteReply(${re.cc_num})" /></td>
		       	</tr>
		        </c:if>
		        <!-- 대댓글 -->
		        <c:if test="${re.data_type == 'comment'}">
		        <tr>
		       		<td class="mem-date">${re.te_num}</td>
		            <td class="mem-data">${re.mem_num}</td>
		            <td class="mem-data">${re.te_content}</td> 
		            <c:if test="${!empty re.te_report}">
		                <td class="mem-data">${re.te_report}</td>
		            </c:if>
		            <c:if test="${empty re.te_report}">
		                <td class="mem-data">0</td>
		            </c:if>
	     			   <td class="button2"><input type="button" value="삭제" onclick="deleteCmt(${re.te_num})" /></td>
		       	</tr>
		        </c:if>
		</c:forEach>
			</tbody>
		</table>
		<div class="page-div">${page}</div>
	</div>
</div>