<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function refundMovie(mem_num,mb_price,ph_payment,mb_num) {
		var userConfirmed = confirm("예매를 취소하시겠습니까?");
        
        // 사용자가 확인 버튼을 클릭한 경우에만 AJAX 요청을 보냄
        if (userConfirmed) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/refundMovie",
            data: { mem_num: mem_num, mb_price: mb_price , ph_payment: ph_payment , mb_num: mb_num},
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("예매 환불");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("예매 환불실패");
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
		<p id ="title">예매관리</p>
	</div>
		<form action="adminReservation" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'md_num'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="예매번호를 입력하세요">
        		    <input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<div class = "body_table">
		<table class="adminMember-table">
        <thead>
            <tr>
                <th>예매 번호</th>
                <th>회원 아이디</th>
                <th>예매일</th>
                <th>결제금액</th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="mr" items="${list}">
                <tr>
                    <td class="mem-data">${mr.md_num}</td>
                    <td class="mem-data">${mr.mem_id}</td>
                    <td class="mem-data">${mr.mb_date}</td>
                    <td class="mem-data">${mr.mb_price}</td>
					<td class="button2"><input type="button" value="예매취소" onclick="refundMovie(${mr.mem_num}, ${mr.mb_price}, '예매환불' ,${mr.mb_num})"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>
	<div class="page-div">${page}</div> 
</div>
