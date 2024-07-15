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
					<img src="${pageContext.request.contextPath}/images/cmj/user_setting.png" width="70" height="70">
					<span class="setting_name">회원</span>
					<div class="result_data">${memTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/post_setting.png" width="70" height="70">
					<span class="setting_name">커뮤니티</span>
					<div class="result_data">${boardTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/goods_setting.png" width="70" height="70">
					<span class="setting_name">벌스샵</span>
					<div class="result_data">${productTotal}</div>
				</div>
			</div>
			<div class="row2">
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/qa_setting.png" width="70" height="70">
					<span class="setting_name">문의</span>
					<div class="result_data">50</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/movie_setting.png" width="70" height="70">
					<span class="setting_name">영화</span>
					<div class="result_data">${movieTotal}</div>
				</div>
				<div class="section" class="col">
					<img src="${pageContext.request.contextPath}/images/cmj/cinema_setting.png" width="70" height="70">
					<span class="setting_name">영화관</span>
					<div class="result_data">${cinemaTotal}</div>
				</div>
			</div>
		</div>
		<div class="cloud_rank">
			<div class="cloud_rank_tit">
				크라우드 펀딩 신청 영화 수 순위
			</div>
			<div class="row1">
				<div class="cloud_main">
					<img src="https://i.namu.wiki/i/wyRZMZAvjXvMm8j-Q83iVbURBXumdu2hoSed8Yl2VhSnosWmD2a7N44G7M2PLmVce3bFVkrT7ZBJNsEUOu0XwJurKztV4qrDJND2zhe0tKDkwBwIe-IU4DCTwniLYT0LDOIWDh5yCAGM4wAdZG_j0Q.webp" width="200" alt="크라우드 통계">
					<span class="cloud_mranks">1위</span>
					<span class="cloud_mtitle">인사이드 아웃 1</span>
				</div>
				<div class="cloud_main">
					<img src="https://i.namu.wiki/i/noeVPcKtuNzBjpetkb5pAOMephmt7G4X832b6FnmnUWHkWlL8G4rNvE1bwMAwoYY2vBgMinX66JWFHmol7XGApmgP1PY3idzYza5T4UFxrmKbbMe4di5n84gNxHpKmsOqUPf7588its6CnOjI2Lg-Q.webp" width="200" alt="크라우드 통계">
					<span class="cloud_mranks">2위</span>
					<span class="cloud_mtitle">악마는 프라다를 입는다</span>
				</div>
				<div class="cloud_main">
					<img src="https://i.namu.wiki/i/O9ta3JJFwS8zHKwmDDAF4YscTBK3uv_3h_EvN2zRaF98wsTm252OmFJEQrVqXjofU5lYIQb5khtPDMvzgXgpfoNVhpE7QtCutLziN_EA2vaHMmzGMgyTMy-yliUKYdyoRZOTVcGIz7S2pY8Bobmi5g.webp" width="200" alt="크라우드 통계">
					<span class="cloud_mranks">3위</span>
					<span class="cloud_mtitle">이상한 나라의 앨리스</span>
				</div>
			</div>
		</div>
	</div>
</div>
