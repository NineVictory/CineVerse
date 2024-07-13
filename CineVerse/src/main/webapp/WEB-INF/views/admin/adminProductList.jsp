<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
ul .pcg{
    list-style-type: none;
}

ul .pcg li {
    display: inline-block;
    margin-right: 6px;
}

</style>
<div class="page-container">
	<div class="admin_member">
    <div class="firstTitle">
        <p id="title">상품관리</p>
    </div>
    	<form action="adminProductList" id="admin_productList" method="get">
        <ul>
            <li>
                <ul class="pcg">
                	<li>
                		 <a href="?p_category=">ALL</a> |
                	</li>
                	<li>
                		<a href="?p_category=1">MARVEL</a>  |
                	</li>
                	<li>
                		<a href="?p_category=2">DISNEY</a>  |
                	</li>
                	<li>
                		<a href="?p_category=3">DISNEY PRINCES</a>  |
                	</li>
                	<li>
                		<a href="?p_category=4">PIXAR</a>  |
                	</li>
                	<li>
                		<a href="?p_category=5">Studio GHIBLI</a>  |
                	</li>
                	<li>
                		<a href="?p_category=6">Warner Bros.</a>  |
                	</li>
                	<li>
                		<a href="?p_category=7">Universal Studio</a>  |
                	</li>
                	<li>
                		<a href="?p_category=8">ETC</a>
                	</li>
                </ul>
            </li>
     	</ul>
     	<div class="search_box_all">
     		<input type="hidden" name="p_category" value="${param.p_category}">
			<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="상품명을 입력하세요">
        	<input type="submit" value="" class="search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
     	</div>
     </form>
    
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>상품 번호</th>
                <th>상품 이미지</th>
                <th>상품 이름</th>
                <th>상품 카테고리</th>
                <th>상품 수량</th>
                <th>상품 가격</th>
                <th>상품 등록/수정일</th>
                <th>상품 표시 상태</th>
                <th>상품 수정</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${count == 0}">
                <tr>
                    <td colspan="9">해당 조건의 상품이 없습니다.</td>
                </tr>
            </c:if>
            <c:if test="${count > 0}">
                <c:forEach var="p" items="${productList}">
                    <tr>
                        <td class="mem-data">${p.p_num}</td>
                        <td class="mem-data"><img src="${pageContext.request.contextPath}/upload/${p.p_filename}" width="50px" height="50px"></td> <!-- 상품 이미지가 있는 속성으로 수정 필요 -->
                        <td class="mem-data"><a href="${pageContext.request.contextPath}/shop/shopDetail?p_num=${p.p_num}">${p.p_name}</a></td>
                        <td class="mem-data">${p.p_category}</td>
                        <td class="mem-data">${p.p_quantity}</td>
                        <td class="mem-data">${p.p_price}</td>
                        <td class="mem-data">
                            <c:if test="${not empty p.p_modify_date}">
                                ${p.p_modify_date}
                            </c:if>
                            <c:if test="${empty p.p_modify_date}">
                                ${p.p_reg_date}
                            </c:if>
                        </td>
                        <td class="mem-data">
                            <c:if test="${p.p_status == 1}">
                                미표시
                            </c:if>
                            <c:if test="${p.p_status == 2}">
                                표시
                            </c:if>
                        </td>
                        <td class="button2"><input type="button" value="수정" /></td>
                    </tr>
                </c:forEach>
				
            </c:if>
        </tbody>
    </table>
	<div class="page-div">${page}</div>
</div>
	
</div>
