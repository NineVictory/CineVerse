<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--  기대되는 영화 시작 -->
<div class="myPage_main">
	<div class="myPage_title">
		<h3>기대되는 영화</h3>
	</div>
	<div class="movie_list_all">
		<ul id="expecting_movielist">
		<c:if test="${count == 0}">찜한 영화가 존재하지 않습니다.</c:if>
		<c:if test="${count > 0}">
		<c:forEach var="mov" items="${movie}">
			<li class="liked_movie">
				<div class="expect_movie">
				<div class="expect_movie_poster"> <img alt="영화1" src="${fn:split(mov.m_filename, '|')[0]}"  onclick="location.href='${pagecontext.request.contextPath}/movie/movieDetail?m_code=${mov.m_code}'"></div>
				
					
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>${mov.m_name}</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
		</c:forEach>
		</c:if>
			
			<%-- <li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
			<li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
			<li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
			<li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
			<li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
			<li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li>
			<li class="liked_movie">
				<div class="expect_movie">
					<img class="expect_movie_poster" src="https://i.namu.wiki/i/KQjVfyVuirhp94RyAvcVyIwCHXxRQwICdHx_3Q8pvmec3_SxGkYuY_Azm6eJtsE88lI4g7uy-agvBl1feWhXOQ.webp">
					<div class="expect-movie-info">
						<div class="expect-movie-title">
							<p>듄</p>
						</div>
					
						<div class="expect-movie-like">
							<img src="${pageContext.request.contextPath}/images/heart02.png" width="20">
						</div>
					</div>
				</div>
			</li> --%>
			
		
			
		</ul>
	</div>
</div>
<!--  기대되는 영화 끝 -->