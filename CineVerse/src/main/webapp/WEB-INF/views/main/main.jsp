<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

<style>

/* wrapper가 기본으로 overflow이기 때문에 넘치는 부분 숨겨주고 높이 설정시켜주기 */
.swiper-container {
	width: 100%;
	height: 674px;
	overflow: hidden;
	position: relative;
}

.swiper-slide {
	display: flex;
	justify-content: center;
	align-items: center;
}
/* 이미지 넓이 */
.swiper-slide img {
width: 100%;
    height: 774px;
}

/* 페이지네이션 위치 잡기 */
.swiper-pagination {
	position: absolute;
	bottom: 20px;
	left: 50%;
	z-index: 10;
	text-align: center;
}

/* 넘기는 버튼 스타일 */
.swiper-button-next, .swiper-button-prev {
	color: white;
	z-index: 10;
}

</style>

<div class="swiper-container">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<img
				src="https://cf2.lottecinema.co.kr/lotte_image/2024/Pilot/Pilot_1920774.jpg"
				alt="광고 이미지 1">
		</div>
		<div class="swiper-slide">
			<img
				src="https://cf2.lottecinema.co.kr/lotte_image/2024/BOL4/BOL4_1920774.jpg"
				alt="광고 이미지 2">
		</div>
		<div class="swiper-slide">
			<img
				src="https://cf2.lottecinema.co.kr/lotte_image/2024/TheBaton/TheBaton_1920774.jpg"
				alt="광고 이미지 3">
		</div>
	</div>
	<!-- 페이지 네이션 추가하기 -->
	<div class="swiper-pagination"></div>
	<!-- 넘기는 버튼 추가하기 -->
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
</div>

<!-- 모달 구조 -->
<div id="modal" class="modal" style="display: none;">
	<div class="modal-in">
		<div class="modal-content">
			<span class="close">&times;</span>
			<iframe width="750" height="415"
				src="https://www.youtube.com/embed/amI9ujTxtH4?si=BMlnca0-whqKnA1C"
				title="YouTube video player" frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
				referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
		</div>
	</div>
</div>

<div id="modal2" class="modal2" style="display: none;">
	<div class="modal-in">
		<div class="modal-content">
			<span class="close">&times;</span>
			<iframe width="750" height="415"
				src="https://www.youtube.com/embed/5U4Vadb359o?si=rGTjw7dUs7IhjTSy"
				title="YouTube video player" frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
				referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
		</div>
	</div>
</div>

<div id="modal3" class="modal3" style="display: none;">
	<div class="modal-in">
		<div class="modal-content">
			<span class="close">&times;</span>
			<iframe width="750" height="415"
				src="https://www.youtube.com/embed/6LFIGSyIOOE?si=mpAlNBUiTxSyx_Rh"
				title="YouTube video player" frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
				referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
		</div>
	</div>
</div>

<!-- Swiper JS 라이브러리 가져오기-->
<!-- 광고 부분 슬라이드 -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

<div class="movie_rank">
	<div class="contents">
		<div class="swiper-container ranks">
			<div class="swiper-wrapper movie-wrapper">
				<!-- 아이템들을 swiper-slide로 감싸기 -->
						<c:forEach var="detail" items="${movieRank}">
								<div class="swiper-slide">
						    <div class="item">
						        <div class="top_info">
						            <span class="poster_info">
						                <img class="poster_info_image" src="${fn:split(detail.m_filename, '|')[0]}" alt="${detail.m_name}">
						                <em class="num_info">${detail.movie_rank}</em>
						                <div class="overlay">
						                    <button class="btn-book" onclick="location.href='${pageContext.request.contextPath}/movie/movieTimeBYmovie?m_code=${detail.m_code}'">예매하기</button>
						                    <button class="btn-details" onclick="location.href='${pageContext.request.contextPath}/movie/movieDetail?m_code=${detail.m_code}'">상세보기</button>
						                </div>
						            </span>
						        </div>
						        <div class="btm_info">
						        	<div class="movie_infos_gt">
						        		<div class="movie_info_center">
						        		<strong class="tit_info">
						                <span class="ic_grade <c:choose><c:when test="${detail.rating eq '12세관람가' }">gr_12</c:when>
						                    <c:when test="${detail.rating eq '12세이상관람가' }">gr_12</c:when>
						                    <c:when test="${detail.rating eq '전체관람가' }">gr_all</c:when>
						                    <c:when test="${detail.rating eq '15세관람가' }">gr_15</c:when>
						                    <c:when test="${detail.rating eq '15세이상관람가' }">gr_15</c:when>
						                    <c:when test="${detail.rating eq '18세관람가(청소년관람불가)' }">gr_19</c:when>
						                    <c:when test="${detail.rating eq '청소년관람불가' }">gr_19</c:when></c:choose>">
						                </span>
						                <span class="em_title">${detail.m_name}</span>
						            </strong>
						            </div>
						        	</div>
						            
						            <span class="sub_info1">
						                <span class="rate_info">예매율 <em>
						                <%-- ${detail.reservation_rate }% --%>
						                 <c:choose>
					                            <c:when test="${detail.reservation_rate != null}">
					                                ${detail.reservation_rate}%
					                            </c:when>
					                            <c:otherwise>
					                                0%
					                            </c:otherwise>
					                        </c:choose>
						                </em></span>
						                <span class="star_info"><a class="star_move" href="${pageContext.request.contextPath}/movie/movieDetail?m_code=${detail.m_code}#movie-review-section">
						                <img src="${pageContext.request.contextPath}/images/cje/star_yes.png" class="star_photo">
						                <c:if test="${detail.average_grade == null }">
						                	0.0
						                </c:if>
						                <c:if test="${detail.average_grade != null }">
						                	${detail.average_grade}
						                </c:if>
						                </a>
						                </span>
						            </span>
						        </div>
						    </div>
						</div>
						</c:forEach>
			</div>
			<!-- 이전/다음 버튼 -->
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
	</div>
</div>

<!-- Swiper.js JavaScript -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<!-- 영화 랭킹 슬라이드 구현 -->
<script>
    var swiper = new Swiper('.swiper-container.ranks', {
        slidesPerView: 5, // 한 화면에 보이는 슬라이드 수
        spaceBetween: 30, // 슬라이드 간의 간격
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
</script>

<div id="main_content" class="event_list">
	<div class="sec_tit">이벤트</div>
	<button type="button" class="btn_more"><a href="${pageContext.request.contextPath}/event/event">더보기</a></button>
	<div class="event_wrap">
		<ul class="img_lst_wrap">
			<li class="img_w_01"><a href="#" title="화면이동"><img
					src="https://cf.lottecinema.co.kr//Media/Event/2198630c3e4b454893ac47854ea48ace.jpg"
					alt=""></a></li>
			<li class="img_w_01"><a href="#" title="화면이동"><img
					src="https://cf.lottecinema.co.kr//Media/Event/36c47c625214444faee2a6ce0a8c55a4.jpg"
					alt=""></a></li>
			<li class="img_w_02"><a href="#" title="화면이동"><img
					src="https://cf.lottecinema.co.kr//Media/Event/dc51559b1cba43099f376ac6462b5722.jpg"
					alt=""></a></li>
			<li class="fl_r img_w_03"><a
				href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_43&amp;adgroupid=adg_lottecinema_20230227_86&amp;adid=adi_lottecinema_20230227_110"
				target="" title="화면이동"><img
					src="https://cf2.lottecinema.co.kr/lotte_image/2022/Hyundaicard/Hyundaicard_296511.jpg"
					alt="상시 영화티켓 장당 6,000M포인트 사용 자세히보기"></a></li>
			<li class="img_w_04"><a href="#" title="화면이동"><img
					src="https://cf.lottecinema.co.kr//Media/Event/5259baba05354a4096787b6d536385cb.jpg"
					alt=""></a></li>
			<li class="img_w_01"><a href="#" title="화면이동"><img
					src="https://cf.lottecinema.co.kr//Media/Event/c426fefc1b3c4dba9e6d5cd72712dcda.jpg"
					alt=""></a></li>
		</ul>
	</div>
</div>

<div class="mid_menu_wrap">
<%-- 	<a href="#none" class="mid_itm" title="화면이동"> <img
		src="https://cf.lottecinema.co.kr//Media/WebAdmin/3423e358b74d49d5b12867c7d9c6f6a8.png"
		alt="할인안내">
	</a> <a href="${pageContext.request.contextPath}/member/pointCharge"
		class="mid_itm" title="화면이동"> <img
		src="https://cf.lottecinema.co.kr//Media/WebAdmin/16b056e5e6a04c609b94a5c21e786d3b.png"
		alt="포인트">
	</a> <a href="#none" class="mid_itm" title="화면이동"> <img
		src="https://cf.lottecinema.co.kr//Media/WebAdmin/9fd4a77cd6a44a39aa35d07e5bb8a010.png"
		alt="멤버십">
	</a> <a href="#none" class="mid_itm" title="화면이동"> <img
		src="https://cf.lottecinema.co.kr//Media/WebAdmin/3633088df0644062b53cd88b34067895.png"
		alt="틴틴클럽">
	</a> <a href="#none" class="mid_itm" title="화면이동"> <img
		src="https://cf.lottecinema.co.kr//Media/WebAdmin/9c4e2721ecdd488d86df6d27e3c2a000.png"
		alt="bravo 브라보클럽">
	</a> --%>
</div>

<div class="noticeClient">
	<div class="contents_notice">
		<div class="noticeClient_container">
			<div class="noticeClient_content">
				<div class="notice_wrap">
					<strong>공지사항</strong>
					<a href="${pageContext.request.contextPath}/support/noticeDetail?nb_num=${notice.nb_num}" class="btn_link">
					${notice.nb_title }
					</a> 
					<a href="${pageContext.request.contextPath}/support/main" id="notice_more" class="btn_more">더보기</a>
				</div>
				<div class="client_wrap">
					<dl class="client_list">
						<dt>
							<strong>고객센터</strong>
						</dt>
						<dd>
							<strong>1544-1122</strong> <span>고객센터 운영시간 (평일
								09:00~18:00)
								<p>업무시간 외 자동응답 안내 가능합니다.</p>
							</span>
						</dd>
						<dd style="margin-left: 42%; margin-top: 1%;">
							<img src="${pageContext.request.contextPath}/images/cmj/info.png"
								width="70">
						</dd>
					</dl>
				</div>
			</div>
		</div>
		<div class="noticeClient_ad">
			<div>
				<img src="${pageContext.request.contextPath}/images/cmj/ad3.png"
					style="margin-left: 10px; border-radius: 10px;">
			</div>
		</div>

	</div>
</div>

<!-- 메인 끝 -->