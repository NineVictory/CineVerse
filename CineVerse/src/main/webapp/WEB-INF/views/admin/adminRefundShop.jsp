<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<script>
    function refundOrder(mem_num,p_price,order_num,order_quantity,order_status,ph_payment) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/refundOrder",
            data: { mem_num: mem_num , p_price: p_price,order_num: order_num , order_quantity: order_quantity, order_status: order_status, ph_payment: ph_payment},
            success: function(response) {
                if (response === "success") {
                    // 업데이트 성공 시 페이지 리로드 혹은 메시지 표시 등의 동작 추가 가능
                    alert("상품 환불");
                    location.reload(); // 예시로 페이지를 새로고침
                } else {
                    alert("상품 환불실패");
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
		<p id ="title">상품환불</p>
	</div>
		<form action="adminRefundShop" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'order_num'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="주문번호를 입력하세요">
        		    <input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
		<div class = "body_table">
		<table class="adminMember-table">
        <thead>
            <tr>
                <th>주문내역번호</th>
                <th>주문번호</th>
                <th>상품명</th>
                <th>구매수량</th>
                <th>상품가격</th>
                <th>주문상태</th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="rs" items="${list}">
                <tr>
                    <td class="mem-data">${rs.od_num}</td>
                    <td class="mem-data">${rs.order_num}</td>
                    <td class="mem-data">${rs.p_name}</td>
                    <td class="mem-data">${rs.order_quantity}</td>
                    <td class="mem-data">${rs.p_price}</td>
                    <td class="mem-data">${rs.order_status}</td>
					<td class="button2"><input type="button" value="예매취소" onclick="refundOrder(${rs.mem_num},${rs.p_price * rs.order_quantity},${rs.order_num}, ${rs.order_quantity},${rs.order_status},'상품환불')"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>
	<div class="page-div">${page}</div> 
</div>
