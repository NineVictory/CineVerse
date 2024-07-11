<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="admin_member">
    <div class="firstTitle">
        <p id="title">상품관리</p>
    </div>
    <form action="adminProductList" id="admin_productList" method="get">
        <ul>
            <li>
                <select name="p_category">
                    <option value="" <c:if test="${param.p_category == ''}">selected</c:if>>ALL</option>
                    <option value="1" <c:if test="${param.p_category == '1'}">selected</c:if>>MARVEL</option>
                    <option value="2" <c:if test="${param.p_category == '2'}">selected</c:if>>DISNEY</option>
                    <option value="3" <c:if test="${param.p_category == '3'}">selected</c:if>>DISNEY PRINCES</option>
                    <option value="4" <c:if test="${param.p_category == '4'}">selected</c:if>>PIXAR</option>
                    <option value="5" <c:if test="${param.p_category == '5'}">selected</c:if>>Studio GHIBLI</option>
                    <option value="6" <c:if test="${param.p_category == '6'}">selected</c:if>>Warner Bros.</option>
                    <option value="7" <c:if test="${param.p_category == '7'}">selected</c:if>>Universal Studio</option>
                    <option value="8" <c:if test="${param.p_category == '8'}">selected</c:if>>ETC</option>
                </select>
            </li>
            <li>
                <input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="상품명을 입력하세요">
                <input type="submit" value="" class="search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
            </li>
        </ul>
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
                        <td class="button1"><input type="button" value="수정" /></td>
                    </tr>
                </c:forEach>
				
            </c:if>
        </tbody>
    </table>
	<div class="page-div">${page}</div>
</div>
