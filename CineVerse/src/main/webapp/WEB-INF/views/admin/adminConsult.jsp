<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<script>
    function redirectToAdminAnswer(consult_num) {
        // consultNum을 이용하여 원하는 동작을 수행하는 예시
        window.location.href = 'adminAnswer?consult_num=' + consult_num;
    }
</script>

<div class="page-container">	
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">문의관리</p>
	</div>
		<form action="adminConsult" id="admin_search">
			<ul>
				<li>
					<input type="hidden" name="keyfield" value="${param.keyfield != null ? param.keyfield : 'mem_num'}"> <!-- 기본값 설정 -->
           			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="회원명을 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>문의번호</th>
                <th>회원번호</th>
                <th>제목</th>
                <th>분류</th>
                <th>작성일</th>                
            </tr>
        </thead>
        <c:if test="${empty list}">
            <tr>
                <td colspan="7" class="mem-data">데이터가 없습니다.</td>
            </tr>
        </c:if>
        <tbody>
            <c:forEach var="consult" items="${list}">
                <tr onclick="redirectToAdminAnswer(${consult.consult_num})" id = "intoAnswer">
					<td class="mem-data">${consult.consult_num}</td>
                    <td class="mem-data">${consult.mem_num}</td>
                    <td class="mem-data">${consult.consult_title}</td>    
                    <c:if test = "${consult.consult_type == 'dissatisfaction'}">              
                    <td class="mem-data">불만사항</td>
                    </c:if>
                    <c:if test = "${consult.consult_type == 'exchange'}">              
                    <td class="mem-data">교환/환불</td>
                    </c:if>
                    <c:if test = "${consult.consult_type == 'proposal'}">              
                    <td class="mem-data">제안</td>
                    </c:if>
                    <c:if test = "${consult.consult_type == 'compliment'}">              
                    <td class="mem-data">칭찬</td>
                    </c:if>
                    <c:if test = "${consult.consult_type == 'inquiry'}">              
                    <td class="mem-data">문의</td>
                    </c:if>
                    <c:if test = "${consult.consult_type == 'missing'}">              
                    <td class="mem-data">분실</td>
                    </c:if>
                    <td class="mem-data">${consult.consult_reg_date}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
	<div class="page-div">${page}</div> 
</div>


