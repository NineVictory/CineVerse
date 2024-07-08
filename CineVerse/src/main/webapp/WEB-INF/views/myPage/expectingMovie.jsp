<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.movie_list_all {
	display: flex;
	justify-content: center;
	width: 100%;
	overflow: hidden;
}

#expecting_movielist {
	margin-left: -70px;
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
	margin-bottom: 30px;
}

.liked_movie {
	width: calc(25% - 10px);
	margin: 0 5px 30px 5px;
	text-align: center;
}

.expect_movie .expect_movie_poster {
	width: 80%;
	max-width: 100%;
	height: auto;
}

.expect_movie {
	display: flex;
	color: #666;
	flex-direction: column;
	align-items: center;
}

.expect-movie-info {
	padding: 15px;
	display: flex;
}

.expect-movie-title {
	display: flex;
	align-items: center;
	width: 110px;
	justify-content: center;
}

.expect-movie-like {
	display: flex;
	width: 40px;
	align-items: center;
	justify-content: flex-end;
}
</style>
<!--  기대되는 영화 시작 -->
<div class="myPage_main">
	<div class="myPage_title">
		<h3>기대되는 영화</h3>
	</div>
	<div class="movie_list_all">
		<ul id="expecting_movielist">
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
			
		
			
		</ul>
	</div>
</div>
<!--  기대되는 영화 끝 -->