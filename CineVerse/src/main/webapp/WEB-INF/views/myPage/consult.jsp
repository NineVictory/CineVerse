<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/deleteConsult.js"></script>
<!-- 나의 문의 시작 -->
<div class="myPage_main">
    <div class="reservation_display">
        <span class="myPage_title_re">나의 문의내역</span>
        <select class="myCoupon_option" onchange="location.href='/myPage/consult?category=' + this.value;">
            <option value="0" <c:if test="${param.category == 0}">selected</c:if>>전체</option>
            <option value="1" <c:if test="${param.category == 1}">selected</c:if>>문의</option>
            <option value="2" <c:if test="${param.category == 2}">selected</c:if>>불만</option>
            <option value="3" <c:if test="${param.category == 3}">selected</c:if>>칭찬</option>
            <option value="4" <c:if test="${param.category == 4}">selected</c:if>>제안</option>
            <option value="5" <c:if test="${param.category == 5}">selected</c:if>>분실물</option>
        	<option value="6" <c:if test="${param.category == 6}">selected</c:if>>교환/환불</option>
        </select>
    </div>
    <c:if test="${count == 0}">작성한 문의글이 없습니다.</c:if>
    <c:if test="${count > 0}">
    <!-- 반복 -->
    <c:forEach var="consult" items="${list}">
        <div class="bookMark_box">
            <div class="bk_content">
                <div class="my_board_bk">
                    <div class="my_board_type">
                        <c:choose>
                            <c:when test="${consult.consult_type == 'inquiry'}">[문의]</c:when>
                            <c:when test="${consult.consult_type == 'dissatisfaction'}">[불만]</c:when>
                            <c:when test="${consult.consult_type == 'compliment'}">[칭찬]</c:when>
                            <c:when test="${consult.consult_type == 'proposal'}">[제안]</c:when>
                            <c:when test="${consult.consult_type == 'missing'}">[분실물]</c:when>
                            <c:when test="${consult.consult_type == 'exchange'}">[교환/환불]</c:when>
                            <c:otherwise>${consult.consult_type}</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="my_boardWrite_bk"  onclick="location.href='${pagecontext.request.contextPath}/support/consultDetail?consult_num=${consult.consult_num}'">${consult.consult_title}</div>
                </div>
                <c:if test="${consult.consult_status == 1}">
					 <div class="conAnswer_btn">
                   <input type="button" class="consult_btn" data-num="${consult.consult_num}" data-mnum="${user.mem_num}" value="미답변">
                </div>
				</c:if>
                <c:if test="${consult.consult_status == 2}">
	                <div class="conAnswer_btn">
	                   <input type="button" class="consult_btn" data-num="${consult.consult_num}" data-mnum="${user.mem_num}" value="답변 완료">
	                </div>
                </c:if>
            </div>
            <div class="consult_date">
                <span>
                    <c:choose>
                        <c:when test="${!empty consult.consult_modify_date}">${consult.consult_modify_date}</c:when>
                        <c:otherwise>${consult.consult_reg_date}</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </c:forEach>
    <!-- 반복 끝 -->
    </c:if>
</div>
<!-- 나의 문의 끝 -->