<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/deleteCboard.js"></script>
<!-- 나의 게시글 시작 -->
<div class="myPage_main">
    <div class="reservation_display">
        <span class="myPage_title_re">나의 게시글</span>
        <select class="myCoupon_option" onchange="location.href='/myPage/boardWrite?category=' + this.value;">
            <option value="0" <c:if test="${param.category == 0}">selected</c:if>>전체</option>
            <option value="1" <c:if test="${param.category == 1}">selected</c:if>>영화톡톡</option>
            <option value="2" <c:if test="${param.category == 2}">selected</c:if>>일상톡톡</option>
        </select>
    </div>
    <c:if test="${count == 0}"><div class="empty_position">작성한 게시글이 없습니다.</div></c:if>
    <c:if test="${count > 0}">
    <!-- 반복 -->
    <c:forEach var="board" items="${list}">
        <div class="bookMark_box">
            <div class="bk_content">
                <div class="my_board_bk">
                    <div class="my_board_type">
                        <c:choose>
                            <c:when test="${board.cb_type == 'dailyTalk'}">일상톡톡</c:when>
                            <c:when test="${board.cb_type == 'movieTalk'}">영화톡톡</c:when>
                            <c:otherwise>${board.cb_type}</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="my_boardWrite_bk" onclick="location.href='${pagecontext.request.contextPath}/board/detail?cb_num=${board.cb_num}'">${board.cb_title}</div>
                </div>
                <div class="bk_delete_btn">
                   <input type="button" class="add_del_btn" data-num="${board.cb_num}" data-mnum="${user.mem_num}" value="삭제">
                </div>
            </div>
            <div class="review_fav_date">
                 <span class="favCount"><img src="${pageContext.request.contextPath}/images/like01.png"width="17"></span> <span>${board.fav_cnt}</span> | 
                <span>
                    <c:choose>
                        <c:when test="${!empty board.cb_modify_date}">${board.cb_modify_date}</c:when>
                        <c:otherwise>${board.cb_reg_date}</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </c:forEach>
    <!-- 반복 끝 -->
    </c:if>
</div>
<!-- 나의 게시글 끝 -->
