<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>




<div class="page-container">
	<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">쿠폰관리</p>
	</div>
	<form id="admin_search">
				<ul>
					<li>
						<input type="hidden" name="keyfield" value="1">
						<input type="search" name="keyword" placeholder="쿠폰 이름을 입력하세요">
						<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');" >
					</li>
				</ul>
			</form>    <table class="adminMember-table">
        <thead>
            <tr>
                <th>쿠폰번호</th>
                <th>쿠폰이름</th>
                <th>할인금액</th>
                <th>사용처</th>
                <th>쿠폰사용 최소금액</th>
                <th>수정</th>
				<th>지급</th>
            </tr>
        </thead>
		<c:if test="${count>0}">
        <tbody>
            <c:forEach var="c" items="${couponList}">
                <tr>
                    <td class="mem-data">${c.coupon_num}</td>
                    <td class="mem-data">${c.coupon_name}</td>
                    <td class="mem-data">${c.coupon_sale}원</td>
                    <td class="mem-data">
						<c:if test="${c.coupon_where==1}">
							영화
						</c:if>
						<c:if test="${c.coupon_where==2}">
													벌스샵
												</c:if>
					</td>
                    <td class="mem-data">
						<c:if test="${empty c.coupon_min_amount}">
													-
												</c:if>
												<c:if test="${!empty c.coupon_min_amount}">
																									${c.coupon_min_amount}원 이상
																								</c:if>
						
					</td>
					<td class="button1">
					    <input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/admin/modifyCoupon?coupon_num=${c.coupon_num}'" />
					</td>

						
					<td class="button2"><input type="button" value="지급" onclick="location.href='${pageContext.request.contextPath}/admin/couponSend?coupon_num=${c.coupon_num}'" /></td>
                </tr>
            </c:forEach>
        </tbody>
		</c:if>
    </table>
	</div>
	<div class="page-div">${page}</div> 
</div>

