<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<div class="page-container">
    <h2>쿠폰 지급</h2>
    <div class="insert_movie_time">
        
            <form action="couponSend" id="admin_search">
  	 	 <ul> 
        <li>
        	<input type="hidden" name="coupon_num" value="${coupon_num}">
        	<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mem_name'}"> <!-- 기본값 설정 -->
           	<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="이름을 입력하세요">
            <input type="submit" value="" class="search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
        </li>
    </ul>
</form>
<form:form action="couponSend" id="insert_form" modelAttribute="couponVO" method="post">
			<input type="hidden" name="coupon_num" value="${couponVO.coupon_num}">
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>등급</th>
                <th>이름</th>
                <th>지급하기</th>
                <th></th>
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="member" items="${list}">
                <tr>
                    <td class="mem-data">${member.mem_num}</td>
                    <td class="mem-data">${member.mem_id}</td>
                    
                    <td class="mem-data">
                    <c:choose>
                    	<c:when test="${member.mem_rank == 1}">BASIC</c:when>
                    	<c:when test="${member.mem_rank == 2}">MEMBER</c:when>
                    	<c:when test="${member.mem_rank == 3}">REGULAR</c:when>
                    	<c:when test="${member.mem_rank == 4}">VIP</c:when>
                    	<c:when test="${member.mem_rank == 5}">VVIP</c:when>
                    </c:choose>
                    </td>
                    <td class="mem-data">${member.mem_name}</td>
                    <td class="button1"><input type="button" value="지급" onclick="location.href='${pageContext.request.contextPath}/admin/couponSendMember?coupon_num=${coupon_num}&mem_num=${member.mem_num}'"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </form:form>
	</div>
	<div class="page-div">${page}</div> 
        
    </div>
