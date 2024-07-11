<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 영화목록 시작 -->
<div class="page-container">

<div class="movie-page">
    
   <div class="movie-main">   
      <form action="shopSearch" id="shop_search">
    <div class="search-container">
    <!-- 상영작 체크 -->
      <div class="movie-list-title">
      <input type="checkbox">
      현재 상영작만 보기
      </div>
    <div class="select-wrapper">
            <select name="movieOrder" id="movieOrder">
                <option value="1" <c:if test="${param.movieOrder == 1 }">selected</c:if>>최신순</option>
                <option value="2" <c:if test="${param.movieOrder == 2 }">selected</c:if>>북마크순</option>
                <option value="3" <c:if test="${param.movieOrder == 3 }">selected</c:if>>인기순</option>
            </select>
        </div>
        <ul>
            <li>
            	<input type="hidden" name="keyfield" id="keyfield" value="1">
                <input type="search" name="keyword" id="keyword" placeholder="검색어를 입력하세요">
                <input type="submit" value="" style="background-image: url('${pageContext.request.contextPath}/images/search_icon.png');">
            </li>
        </ul>
        
    </div>
</form>
   </div>
   
   <!-- 목록 -->
   <div class="movie-list-page">
      <ul class="movie-list"> <!-- 데이터가 들어가면 변경해야될듯 -->
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
         <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/images/ksh/movie.jpg" onclick="location.href='movieDetail'">
            <p onclick="location.href='movieDetail'"><b>인사이드 아웃2</b></p>
            <div class="bookAopen">
            <div>예매율 34.1% | 개봉일 2024.06.12</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                <img alt="영화1" src="${pageContext.request.contextPath}/images/heart01.png">
                5.7K</div>
                <div class="movie-reservation-button-list">예매하기</div>
             </div>         
         </li>
      </ul>
   </div>
     <div class="load-more">
         <button id="loadMoreButton">더 보기</button>
      </div>  
   
</div>
<!-- 영화목록 끝 -->

</div>
