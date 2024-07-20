<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<table class="qna-table">
    <tr>
        <td class="qna-table-num">번호</td>
        <td class="qna-table-title">제목</td>
        <td class="qna-table-writer">작성자</td>
        <td class="qna-table-rdate">작성일</td>
        <td class="qna-table-status">처리상태</td>
    </tr>
    <c:if test="${count == 0}">
        <tr>
            <td colspan="5">
                <div style="height:250px; display:flex; align-items:center; justify-content: center;">문의글이 존재하지 않습니다.</div>
            </td>
        </tr>
    </c:if>
    
    <c:if test="${count > 0}">
        <c:forEach var="consult" items="${list}">
        <tr>
            <td class="qna-table-num">${consult.consult_num}</td>
            <td class="qna-table-title">
             <c:choose>
                    <c:when test="${fn:length(consult.consult_title) > 30}">
                        <a href="consultDetail?consult_num=${consult.consult_num}">${fn:substring(consult.consult_title, 0, 30)}...</a>
                    </c:when>
                    <c:otherwise>
                        <a href="consultDetail?consult_num=${consult.consult_num}">${consult.consult_title}</a>
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="qna-table-writer">${consult.mem_id}</td>
            <td class="qna-table-rdate">${consult.consult_reg_date}</td>
            <td class="qna-table-status">
                <c:if test="${consult.consult_status == 1}">미답변</c:if>
                <c:if test="${consult.consult_status == 2}">답변완료</c:if>
            </td>
        </tr>
        </c:forEach>
    </c:if>    
</table>
<div class="align-center page-div">
    ${page}
</div>