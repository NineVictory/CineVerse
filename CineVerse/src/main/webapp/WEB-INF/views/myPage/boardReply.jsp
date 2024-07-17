<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 나의 댓글 시작 -->
<div class="myPage_main">
    <div class="reservation_display">
        <span class="myPage_title_re">나의 댓글</span>
        <select class="myCoupon_option" onchange="location.href='/myPage/boardReply?category=' + this.value;">
            <option value="0" <c:if test="${param.category == 0}">selected</c:if>>전체</option>
            <option value="1" <c:if test="${param.category == 1}">selected</c:if>>영화톡톡</option>
            <option value="2" <c:if test="${param.category == 2}">selected</c:if>>일상톡톡</option>
        </select>
    </div>
    
    <c:if test="${commentCount == 0 && responseCount == 0}">
        작성한 댓글이 없습니다.
    </c:if>
    <c:if test="${commentCount > 0 || responseCount > 0}">
        <!-- 댓글 목록 -->
        <c:forEach var="comment" items="${combinedList[0]}">
            <div class="bookMark_box" onclick="location.href='${pagecontext.request.contextPath}/board/detail?cb_num=${comment.cb_num}'">
                <div class="bk_content">
                    <div class="my_board_bk">
                        <div class="my_board_type">
                            <c:choose>
                                <c:when test="${comment.cb_type == 'dailyTalk'}">일상톡톡</c:when>
                                <c:when test="${comment.cb_type == 'movieTalk'}">영화톡톡</c:when>
                                <c:otherwise>${comment.cb_type}</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="my_boardWrite_bk">${comment.cc_content}</div>
                        <span class="my_board_reply">게시글 : ${comment.cb_title}</span>
                    </div>
                    <div class="bk_delete_btn">
                        <div>삭제</div>
                    </div>
                </div>
                <div class="review_fav_date">
                    <span>이미지</span> <span>${comment.fav_cnt}</span> | 
                    <span>
                        <c:choose>
                            <c:when test="${!empty comment.cc_modify_date}">${comment.cc_modify_date}</c:when>
                            <c:otherwise>${comment.cc_reg_date}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </c:forEach>
        
        <!-- 답글 목록 -->
        <c:forEach var="response" items="${combinedList[1]}">
            <div class="bookMark_box" onclick="location.href='${pagecontext.request.contextPath}/board/detail?cb_num=${response.cb_num}'">
                <div class="bk_content">
                    <div class="my_board_bk">
                        <div class="my_board_type">
                            <c:choose>
                                <c:when test="${response.cb_type == 'dailyTalk'}">일상톡톡</c:when>
                                <c:when test="${response.cb_type == 'movieTalk'}">영화톡톡</c:when>
                                <c:otherwise>${response.cb_type}</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="my_boardWrite_bk">${response.te_content}</div>
                        <span class="my_board_reply">게시글 : ${response.cb_title}</span>
                    </div>
                    <div class="bk_delete_btn">
                        <div>삭제</div>
                    </div>
                </div>
                <div class="review_fav_date">
                    <span>이미지</span> <span>${response.fav_cnt}</span> | 
                    <span>${response.te_date} </span>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>
<!-- 나의 댓글 끝 -->
