<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- 영화목록 시작 -->
<div class="page-container">

<div class="movie-page">
    
   <div class="movie-main">   
      <form action="movieList" id="movie_search">
    <div class="search-container">
    <!-- 상영작 체크 -->
      <div class="movie-list-title">
      <input type="checkbox">
      현재 상영작만 보기
      </div>
    <div class="select-wrapper">
            <select name="movieorder" id="movieorder">
                <option value="1" <c:if test="${param.movieorder == 1 }">selected</c:if>>최신순</option>
                <option value="2" <c:if test="${param.movieorder == 2 }">selected</c:if>>북마크순</option>
                <option value="3" <c:if test="${param.movieorder == 3 }">selected</c:if>>인기순</option>
            </select>
            <script type="text/javascript">
				$('#movieorder').change(function(){
					location.href='list?keyfield='
								+$('#keyfield').val()
								+'&keyword='+$('#keyword').val()
								+'&movieorder='+$('#movieorder').val();
				});
			</script>
        </div>
        <ul>
            <li>
            	<input type="hidden" name="keyfield" id="keyfield" value="1">
            	<input type="hidden" name="m_status" value="${param.m_status}">
                <input type="search" name="keyword" id="keyword" placeholder="검색어를 입력하세요">
                <input type="submit" value="" style="background-image: url('${pageContext.request.contextPath}/images/search_icon.png');">
            </li>
        </ul>
        
    </div>
</form>
   </div>
   
   <!-- 목록 -->
   <div class="movie-list-page">
       <ul class="movie-list">
   <c:if test="${count <= 0}">
   		상영중인 영화가 없습니다.
   </c:if>
   <c:if test="${count > 0}">	
   		<c:forEach var="movie" items="${movielist}">

        <li class="movie">
            <img alt="영화1" src="${pageContext.request.contextPath}/upload/${movie.m_filename}" onclick="location.href='movieDetail?m_code=${movie.m_code}'">
            <p><a href="movieDetail?m_code=${movie.m_code}"><b>${movie.m_name}</b></a></p>
            <div class="bookAopen">
                <div>예매율 34.1% | 개봉일 ${movie.m_opendate}</div>
            </div>
            <div class="movie-button" onclick="location.href='/movie/'">
                <div class="movie-fav-button">
                    <img alt="북마크" src="${pageContext.request.contextPath}/images/heart01.png">
                    5.7K
                </div>
                <div class="movie-reservation-button-list">예매하기</div>
            </div>
        </li>
    

    
</c:forEach>
      
      </c:if>
      </ul>
   </div>
   <div class="page-movie">${page}</div>
   </div>
     <div class="load-more">
         <button id="loadMoreButton">더 보기</button>
      </div>  
   
</div>
<!-- 영화목록 끝 -->


