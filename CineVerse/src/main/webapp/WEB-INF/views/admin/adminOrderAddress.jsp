<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="page-container">

<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">주문 배송지 관리</p>
	</div>
		
		<div>
			주문번호 : ${order_num}
		</div>
		<form action="modifyOrderAddress" method="post">
		    <input type="hidden" name="order_num" value="${order_num}"/>
		    <ul>
		        <li>
		            <select name="aNum">
		                <c:forEach var="a" items="${addressList}">
		                    <option value="${a.a_num}" <c:if test="${a.a_num == address.a_num}">selected</c:if>>${a.a_name}</option>
		                </c:forEach>
		            </select>
		        </li>
		        <li>
		            <input type="submit" id="submit_btn" value="변경하기">
		        </li>
		    </ul>
		</form>

    	<table class="adminMember-table">
        <thead>
            <tr>
                <th>배송지 이름</th>
                <th>우편번호</th>
                <th>주소</th>
               	<th>전화번호</th>
            </tr>
        </thead>
        <tbody>
                <tr>
                	
                	
                    <td class="mem-data">${address.a_name}</td>
                    <td class="mem-data">${address.a_zipcode}</td>
                    <td class="mem-data">${address.a_address1} ${address.a_address2 }</td>
                    <td class="mem-data">${address.a_phone}</td>
                </tr>
        </tbody>
    </table>
    
</div>
<button class="button1" onclick="location.href='${pageContext.request.contextPath}/admin/adminDelivery'">목록</button>
</div>
