<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function refundPoint(ph_num,mem_num,ph_point,ph_payment) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/refundPoint",
            data: { ph_num:ph_num, mem_num: mem_num, ph_point: ph_point , ph_payment: ph_payment },
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("포인트 환불");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("포인트 환불실패");
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
		<p id ="title">포인트 관리</p>
	</div>
		<form action="adminPayment" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mem_num'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="회원번호를 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
	<table class="adminMember-table">
        <thead>
            <tr>
                <th>결제번호</th>
                <th>충전금액</th>
                <th>충전일</th>
                <th>회원번호</th>
                <th>결제수단</th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="point" items="${list}">
                <tr>
                    <td class="mem-data">${point.ph_num}</td>
                    <td class="mem-data">${point.ph_point}</td>
                    <td class="mem-data">${point.ph_date}</td>
                    <td class="mem-data">${point.mem_num}</td>
                    <td class="mem-data">${point.ph_payment}</td>
                    <td class="button2"><input type="button" value="결제취소" onclick="refundPoint(${point.ph_num}, ${point.mem_num}, ${point.ph_point}, '포인트 충전 환불')"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
	<div class="page-div">${page}</div> 
</div>
