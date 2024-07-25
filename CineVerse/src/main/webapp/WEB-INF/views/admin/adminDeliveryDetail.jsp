<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="page-container">

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">배송 관리</p>
	</div>
		
		<div>
			주문번호 : ${order_num}
		</div>
		<form:form action="modifyDelivery" method="post" modelAttribute="ordersVO" >
			<form:hidden path="order_num"/>
			<ul>
			<li>
             	<label for="order_status">주문 상태 변경 ::: </label>
                <form:radiobutton path="order_status" value="1"/> 결제완료
                <form:radiobutton path="order_status" value="2"/> 배송준비중
                <form:radiobutton path="order_status" value="3"/> 배송중
                <form:radiobutton path="order_status" value="4"/> 배송완료
                <form:radiobutton path="order_status" value="5"/> 주문취소
                <form:radiobutton path="order_status" value="6"/> 주문확정
                <form:errors path="order_status" element="div" cssClass="error"/>
            </li>
            <form:button id="submit_btn" class="button2">변경하기</form:button>
            </ul>
		</form:form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>회원번호</th>
                <th>주문내역번호</th>
                <th>상품이름</th>
               	<th>주문개수</th>
               	<th>리뷰상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orderDetailList}">
                <tr>
                    <td class="mem-data">${order.mem_num}</td>
                    <td class="mem-data">${order.od_num}</td>
                    <td class="mem-data">${order.p_name}</td>
                    <td class="mem-data">${order.order_quantity}</td>
                    <td class="mem-data">
                    	<c:if test="${order.od_review_status==1 }">
                    		리뷰 미작성
                    	</c:if>
                    	<c:if test="${order.od_review_status==2 }">
                    		리뷰 작성
                    	</c:if>
                    </td>
                </tr>
            </c:forEach> 
        </tbody>
    </table>
</div>
<button class="button1" onclick="location.href='${pageContext.request.contextPath}/admin/adminDelivery'">목록</button>
</div>
