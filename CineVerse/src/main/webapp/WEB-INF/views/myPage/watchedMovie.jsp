<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
//서버 현재 날짜를 가져와 스크립트로 전달할 데이터
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String currentDate = sdf.format(new Date());
%>
<!--  내가 본 영화 시작 -->
<div class="myPage_main">

    <div class="myPage_title">내가 본 영화</div>
    <hr size="1" width="100%" class="wa_line">

    <div class="empty_position">내가 본 영화가 존재하지 않습니다</div>

    <c:if test="${resCnt > 0}">
        <c:forEach var="wat" items="${list}">
            <div class="wa_box_rep">
                <div class="wa_box" data-mt-date="${wat.mt_date}">
                    <div class="wa_photo">
                        <img alt="영화1" src="${fn:split(wat.m_filename, '|')[0]}"
                             onclick="location.href='${pageContext.request.contextPath}/movie/movieDetail?m_code=${wat.m_code}'"
                             class="expect_movie_poster" width="150" height="210">
                    </div>
                    <div class="wa_movie_info">
                        <div class="wa_info_name">${wat.m_name}</div>
                        <div class="wa_info_sub">
                            ${wat.mt_date} <span id="time-${wat.m_code}">${wat.mt_start}~${wat.mt_end}</span>
                        </div>
                        <div class="wa_info_sub">CINEVERSE ${wat.c_branch} ${wat.th_name}관/관람인원수</div>
                    </div>
                </div>
                <hr size="1" width="100%" class="wa_line">
            </div>
        </c:forEach>
    </c:if>

</div>
<!--  내가 본 영화 끝 -->

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        // 서버 측에서 전달된 현재 날짜
        var currentDate = new Date("<%= currentDate %>");
        var movieBoxReps = document.querySelectorAll(".wa_box_rep");
        var hasPastMovies = false;

        movieBoxReps.forEach(function(boxRep) {
            // data-mt-date 속성에서 영화의 상영 날짜 가져옴
            var box = boxRep.querySelector(".wa_box");
            var mtDate = new Date(box.getAttribute("data-mt-date"));
            // 상영 날짜가 현재 날짜보다 크거나 같으면 요소를 숨김
            if (mtDate >= currentDate) {
                boxRep.style.display = "none";
            } else {
                hasPastMovies = true;
            }
        });

        var emptyMessage = document.querySelector(".empty_position");
        if (hasPastMovies) {
            emptyMessage.style.display = "none";
        } else {
            emptyMessage.style.display = "block";
        }

        var times = document.querySelectorAll("[id^='time-']");
        times.forEach(function(timeDiv) {
            var timesText = timeDiv.textContent.split("~");
            var formattedTimes = timesText.map(function(time) {
                if (time.includes(":")) {
                    return time;
                }
                if (time === "0" || time === "0000") {
                    return "00:00";
                } else {
                    return time.slice(0, 2) + ":" + time.slice(2);
                }
            });
            timeDiv.textContent = formattedTimes.join("~");
        });
    });
</script>
