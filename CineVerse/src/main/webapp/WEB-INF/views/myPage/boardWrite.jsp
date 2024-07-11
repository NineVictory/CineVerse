<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 나의 게시글 시작 -->
<div class="myPage_main">
    <div class="reservation_display">
        <span class="myPage_title_re">나의 게시글</span>
        <select class="myCoupon_option">
            <option>영화톡톡</option>
            <option>일상톡톡</option>
            <option>양도/교환</option>
        </select>
    </div>
    <c:if test="${empty boardData.list}">작성한 게시글이 없습니다.</c:if>
    <c:if test="${!empty boardData.list}">
    <!-- 반복 -->
    <c:forEach var="board" items="${boardData.list}">
        <div class="bookMark_box">
            <div class="bk_content">
                <div class="my_board_bk">
                    <div class="my_board_type">
                        <c:choose>
                            <c:when test="${board.cb_type == 'dailyTalk'}">일상톡톡</c:when>
                            <c:when test="${board.cb_type == 'movieTalk'}">무비톡톡</c:when>
                            <c:otherwise>${board.cb_type}</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="my_boardWrite_bk">${board.cb_title}</div>
                </div>
                <div class="bk_delete_btn">
                    <div>삭제</div>
                </div>
            </div>
            <div class="review_fav_date">
                <span>이미지</span> <span>${board.fav_cnt}</span> | 
                <span>
                    <c:choose>
                        <c:when test="${not empty board.cb_modify_date}">${board.cb_modify_date}</c:when>
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
