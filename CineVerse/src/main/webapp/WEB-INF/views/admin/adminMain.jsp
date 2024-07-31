<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="page-container">
	<div class="admin_main">
		<div class="admin-infos">
			<div class="page-member">
			<span>🙌 환영합니다, 관리자님</span>
			</div>
			<div class="admin_info">
				CINEVERSE의 통계를 보여드릴게요!<br>
				오늘도 좋은 하루 보내세요! 🍀
			</div>
		</div>
		
		<div class="cineverse_data_all">
			<div class="row1">
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/user_setting.png" id = "mainlink" width="70" height="70" onclick="location.href ='${pageContext.request.contextPath}/admin/adminMember'" >
					<span class="setting_name">회원</span>
					<div class="result_data">${memTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/post_setting.png" id = "mainlink" width="70" height="70" onclick="location.href ='${pageContext.request.contextPath}/admin/adminCommunity'">
					<span class="setting_name">커뮤니티</span>
					<div class="result_data">${boardTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/goods_setting.png" id = "mainlink" width="70" height="70" onclick="location.href ='${pageContext.request.contextPath}/admin/adminProductList'">
					<span class="setting_name">벌스샵</span>
					<div class="result_data">${productTotal}</div>
				</div>
			</div>
			<div class="row2">
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/qa_setting.png" id = "mainlink" width="70" height="70" onclick="location.href ='${pageContext.request.contextPath}/admin/adminConsult'">
					<span class="setting_name">문의</span>
					<div class="result_data">${consultTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/movie_setting.png" id = "mainlink" width="70" height="70" onclick="location.href ='${pageContext.request.contextPath}/admin/adminMovie'">
					<span class="setting_name">영화</span>
					<div class="result_data">${movieTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/cinema_setting.png" id = "mainlink" width="70" height="70" onclick="location.href ='${pageContext.request.contextPath}/admin/adminCinema'">
					<span class="setting_name">영화관</span>
					<div class="result_data">${cinemaTotal}</div>
				</div>
			</div>
		</div>
	</div>
</div>
