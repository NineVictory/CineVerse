<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>




<div class="page-container">
	<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">회원쿠폰관리</p>
	</div>
	<form id="admin_search">
				<ul>
					<li>
						<select name="keyfield">
							<option value="1">쿠폰이름</option>
							<option value="2">아이디</option>
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
                <th>회원이름</th>
                <th>보유 쿠폰 번호</th>
                <th>쿠폰 이름</th>
                <th>지급일</th>
                <th>상태</th>
                <th>삭제</th>
                <th></th>
            </tr>
        </thead>
		<c:if test="${count>0}">
        <tbody>
            <c:forEach var="c" items="${couponList}">
                <tr>
                    <td class="mem-data">${c.mem_num}</td>
                    <td class="mem-data">${c.mem_id}</td>
                    <td class="mem-data">${c.mem_name}</td>
                    <td class="mem-data">${c.mc_num}</td>
                    <td class="mem-data">${c.coupon_name}</td>
                    <td class="mem-data">${c.coupon_regdate}</td>
					<td class="mem-data">
						<c:if test="${c.coupon_use==1}">
							미사용
						</c:if>
						<c:if test="${c.coupon_use==2}">
							사용
						</c:if>
						<c:if test="${c.coupon_use==3}">
							만기						
						</c:if>
					</td>
						<c:if test="${c.coupon_use==1}">
							<td class="button1">
							    <input type="button" value="삭제 가능" onclick="confirmDelete(${c.mc_num})" />
							</td>
							
							<script>
							function confirmDelete(mc_num) {
							    if (confirm('정말로 삭제하시겠습니까?')) {
							        location.href = 'deleteMemberCoupon?mc_num=' + mc_num;
							    }
							}
							</script>
						</c:if>
						<c:if test="${c.coupon_use==2 || c.coupon_use==3}">
							<td class="button2"><input type="button" value="삭제 불가" /></td>
						</c:if>
                </tr>
            </c:forEach>
        </tbody>
		</c:if>
    </table>
	</div>
	<div class="page-div">${page}</div> 
</div>

