<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/movie.bookmark.js"></script>
<script src="${pageContext.request.contextPath}/js/movieListSchedule.js"></script>

    <div class="movie-page">
        <div class="movie-main">
            <form id="movie_search" method="get">
                <div class="search-container">
                    <div class="movie-list-title">
                    <div class="movie-list-title-in">
                    	<input type="checkbox" id="statusCheckbox" name="status" value="1" <c:if test="${param.status == 1}">checked</c:if>> 현재 상영작만 보기
                    </div>
                        
                        <div class="select-list-checkbox">
                        <label><input type="checkbox" name="movieorder" value="1" <c:if test="${param.movieorder == 1 || param.movieorder == null}">checked</c:if>> 최신순</label>
                        <label><input type="checkbox" name="movieorder" value="2" <c:if test="${param.movieorder == 2}">checked</c:if>> 북마크순</label>
                    </div>
                    </div>
                    
                    <div class="genre-checkboxes">
                        <c:forEach var="genre" items="${genres}" varStatus="status">
                            <label><input type="checkbox" name="genre" value="${genre}" class="genre-checkbox"> ${genre}</label>
                        </c:forEach>
                    </div>
                    <div class="select-wrapper">
                        <select name="keyfield" id="keyfield-select">
                            <option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>영화이름</option>
                            <option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>배우이름</option>
                        </select>
                         <ul class="ul-search">
                        <li class="li-search">
                            <input type="hidden" name="m_status" value="${param.m_status}">
                            <input type="hidden" name="m_code" value="${param.m_code}">
                            <input type="search" name="keyword" id="keyword" placeholder="검색어를 입력하세요" value="${param.keyword}">
                            <input type="submit" value="">
                        </li>
                    </ul>
                    </div>
                </div>
            </form>
        </div>

        <div id="movieListContainer" class="movie-list-page">
            <ul class="movie-list">
                <c:forEach var="movie" items="${movieListSchedule}" varStatus="status">
                    <c:if test="${param.status == 1 && movie.m_status == 1 || param.status != 1}">
                        <li class="movie">
                            <img alt="영화1" src="${fn:split(movie.m_filename, '|')[0]}" onclick="location.href='movieDetail?m_code=${movie.m_code}'">
                            
                            <div class="overlay">
                    			<button class="btn-book" onclick="location.href='${pageContext.request.contextPath}/movie/movieReserve'">예매하기</button>
                    			<button class="btn-details" onclick="location.href='movieDetail?m_code=${movie.m_code}'">상세보기</button>
                			</div>
                            <div class="movie_name_list">
                            	<div class="movie_list_grade">
                            		<div class="movie_list_gn">
                            			<span class="ic_grade <c:choose><c:when test="${movie.rating eq '12세관람가' }">gr_12</c:when>
						                    <c:when test="${movie.rating eq '12세이상관람가' }">gr_12</c:when>
						                    <c:when test="${movie.rating eq '전체관람가' }">gr_all</c:when>
						                    <c:when test="${movie.rating eq '15세관람가' }">gr_15</c:when>
						                    <c:when test="${movie.rating eq '15세이상관람가' }">gr_15</c:when>
						                    <c:when test="${movie.rating eq '18세관람가(청소년관람불가)' }">gr_19</c:when>
						                    <c:when test="${movie.rating eq '청소년관람불가' }">gr_19</c:when></c:choose>">
					                	</span>
                            			<span class="movie_name">
                            				<b>${movie.m_name}</b>
                            			</span>
                            		</div>
                            	</div>
                            </div>
                            <div class="bookAopen">
                            	<div>개봉일 ${movie.m_opendate}</div>
                                <div>예매율 0% </div>
                            </div>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
 <!--             <div class="more-button-container">
            <button id="loadMoreButton" class="load-more-btn">더보기</button>
        </div>     -->  
        </div>
    </div>
