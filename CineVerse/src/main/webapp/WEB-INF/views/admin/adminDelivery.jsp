<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<div class="page-container">

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">배송 관리</p>
	</div>
		<form id="admin_search">
			<ul>
				<li>
					<select name="keyfield">
						<option value="1">아이디</option>
						<option value="2">주문번호</option>
					</select>
					<input type="search" name="keyword">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>배송지</th>
                <th>주문번호</th>
                <th>주문날짜</th>
                <th>주문상태</th>
               	<th>주문변경</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orderList}">
                <tr>
                    <td class="mem-data">${order.mem_num}</td>
                    <td class="mem-data">${order.mem_id}</td>
                    <td class="mem-data"><a href="${pageContext.request.contextPath}/admin/adminOrderAddress?a_num=${order.a_num}&order_num=${order.order_num}">${order.a_num}</a></td>
                    <td class="mem-data"><a href="${pageContext.request.contextPath}/admin/adminOrderDetail?order_num=${order.order_num}">${order.order_num}</a></td>
                    <td class="mem-data">${order.order_date}</td>
                    <td class="mem-data">
	                    <c:if test="${order.order_status==1}">결제완료</c:if>
	                    <c:if test="${order.order_status==2}">배송준비중</c:if>
	                    <c:if test="${order.order_status==3}">배송중</c:if>
	                    <c:if test="${order.order_status==4}">배송완료</c:if>
	                    <c:if test="${order.order_status==5}">주문취소</c:if>
	                    <c:if test="${order.order_status==6}">주문확정</c:if>
                    </td>
                    <td class="button1"><input type="button" value="변경하기" onclick="location.href='${pageContext.request.contextPath}/admin/adminOrderDetail?order_num=${order.order_num}'"/></td>
                
                </tr>
            </c:forEach> 
        </tbody>
    </table>
</div>
</div>