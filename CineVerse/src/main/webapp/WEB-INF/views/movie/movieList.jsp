<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 영화목록 시작 -->
<div class="page-container">

<div class="movie-page">
   <div class="movie-main">   
      <!-- 상영작 체크 -->
      <div class="movie-list-title">
      <input type="checkbox">
      현재 상영작만 보기
      </div>

      
      <form action="movieSearch" id="movie_search">
         <!-- 검색바 -->
         <input type="search" name="search" placeholder="영화명 검색">
         <input type="submit" value="검색">
         
         <!-- 분류 드롭다운 -->
         <div class="select-wrapper">
            <select name="movieSelect" id="movieSelect">
               <option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
               <option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>감독</option>
               <option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>영화배우</option>
            </select>
         </div>
      </form>
   </div>
   
   <!-- 목록 -->
   <div class="movie-list-page">
      <ul class="movie-list">
         <li class="movie">
            <div class="movie-info">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
            </div>
            
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
         
          <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
         
          <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
         
          <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
         
          <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg">
            <p>인사이드 아웃2</p>
            <div>예매율 | 개봉일</div>   
            <input type="button" value="예매하기" onclick="">
         </li>
      </ul>
   </div>
     <div class="load-more">
         <button id="loadMoreButton">더 보기</button>
      </div>  
   
</div>
<!-- 영화목록 끝 -->

</div>