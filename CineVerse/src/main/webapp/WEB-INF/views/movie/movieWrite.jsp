<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 영화등록 시작 -->
<div class="page-main">
    <h2>영화등록</h2>
    <form:form action="write" id="movie_register"
                enctype="multipart/form-data"
                modelAttribute="movieVO">
        <ul>
            <li>
                <form:label path="m_name">제목</form:label>
                <form:input path="m_name"/>
                <form:errors path="m_name" cssClass="error-color"/>
            </li>
            <li>
                <form:label path="m_opendate">개봉일</form:label>
                <form:input path="m_opendate" type="date"/>
                <form:errors path="m_opendate" cssClass="error-color"/>
            </li>
            <li>
                <form:label path="m_companys">제작사</form:label>
                <form:input path="m_companys"/>
                <form:errors path="m_companys" cssClass="error-color"/>
            </li>
             <li>
                <form:label path="m_status">상태</form:label>
                <form:input path="m_status"/>
                <form:errors path="m_status" cssClass="error-color"/>
            </li>
			<%-- <li>
			<form:label path="m_status">상태</form:label><br/> 
			<form:radiobutton
					path="m_status" value="1" label="미상영" /> <!-- 미상영 --> 
			<form:radiobutton
					path="m_status" value="2" label="상영" /> <!-- 상영 --> 
			<form:errors
					path="m_status" cssClass="error-color" />
			</li> --%>
			<li>
                <form:label path="m_filename">파일 이름</form:label>
                <form:input path="m_filename"/>
                <form:errors path="m_filename" cssClass="error-color"/>
            </li>
            <li>
                <form:label path="upload">파일 업로드</form:label>
                <input type="file" name="upload" id="upload">
            </li>
        </ul> 
        <div>
            <form:button class="movie-btn">전송</form:button>
            <input type="button" value="목록"
              class="movie-btn"
              onclick="location.href='${pageContext.request.contextPath}/movie/movieList'">
        </div>                           
    </form:form>
</div>
<!-- 영화등록 끝 -->
