<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
	function redirectToMovieModify(mt_num) {
		var userConfirmed = confirm("영화시간표를 수정하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
	    window.location.href = '/admin/adminMtModify?mt_num=' + mt_num; 
	}
	}
    function deleteTimeControll(mt_num) {
		var userConfirmed = confirm("영화시간표을 삭제하시겠습니까?");
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/deleteTimeControll",
            data: { mt_num: mt_num },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("영화시간표삭제");
                    location.reload(); // 예시로 페이지를 새로고침
                } else{
                    alert("삭제실패");
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
			<p id="title">영화 시간표 관리</p>
		</div>
		<form action="adminTimeControll" id="admin_search">
			<ul>
				<li><input type="hidden" name="keyfield"
					value="${param.keyfield != null ? param.keyfield : 'm_name'}">
					<!-- 기본값 설정 --> <input type="search" name="keyword" id="keyword"
					value="${param.keyword}" placeholder="영화 제목을 입력하세요"> <input
					type="submit" value="" class="search-button"
					style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
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
					<th>영화 제목</th>
					<th>지점명</th>
					<td></td>
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
						<td class="mem-data movieTimes">${movieTime.mt_start}</td>
						<td class="mem-data movieTimee">${movieTime.mt_end}</td>
						<td class="mem-data">${movieTime.m_name}</td>
						<td class="mem-data">${movieTime.c_branch}</td>
						<td class="button1"><input type="button" value="수정"
							onclick="redirectToMovieModify(${movieTime.mt_num})" /></td>
						<td class="button2"><input type="button" value="삭제"
							id="delete_btn" onclick="deleteTimeControll(${movieTime.mt_num})"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="page-div">${page}</div>
</div>

<script>
function formatTime(time) {
  if (time.length === 3) {
    time = '0' + time;
  }
  if (time.length === 4) {
    return time.slice(0, 2) + ':' + time.slice(2);
  }
  return time;
}

var startTimes = document.querySelectorAll('.movieTimes');
var endTimes = document.querySelectorAll('.movieTimee');

startTimes.forEach(function(element) {
  var startTimeText = element.textContent.trim();
  element.textContent = formatTime(startTimeText);
});

endTimes.forEach(function(element) {
  var endTimeText = element.textContent.trim();
  element.textContent = formatTime(endTimeText);
});

</script>