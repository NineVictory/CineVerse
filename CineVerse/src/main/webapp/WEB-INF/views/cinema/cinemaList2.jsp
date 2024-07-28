<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 영화관 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<div class="theater_list_all">
		<div class="theater_title">
			<h2 class="all-theater">전체 극장</h2>	
		</div>
	<!-- 	<input type="button"  value="영화관 등록" class="cinema-write" onclick="location.href='cinemaWrite'"> -->
		<div class="theater-box">
			<div class="theater-location">
				<div class="theater_location_list">
					<a href="cinemaList2?c_location=1" class="button" >서울</a> 
				</div>
				<div class="theater_location_list">
				<a href="cinemaList2?c_location=2" class="button">경기</a>
				</div>
				<div class="theater_location_list">
					<a href="cinemaList2?c_location=3" class="button">인천</a>  
				</div>
						
				<div class="theater_location_list">
					<a href="cinemaList2?c_location=4" class="button">강원</a>
				</div>
						
				<div class="theater_location_list">
					<a href="cinemaList2?c_location=5" class="button">대전/충청</a> 
				</div>
						
				<div class="theater_location_list">
					<a href="cinemaList2?c_location=6" class="button">경상</a>
				</div>
						
				<div class="theater_location_list">
					<a href="cinemaList2?c_location=7" class="button">광주/전라</a>
				</div>
			</div>
				<div class="theater-place">
					<c:if test="${count == 0}">
						<div class="result-display">표시할 영화관이 없습니다.</div>
					</c:if>
					<c:if test="${count > 0}">
						<c:forEach var="cinema" items="${list}">
							<div class="place-list">
								<div class="branch-list"><a href="detail?c_num=${cinema.c_num}" class="button">${cinema.c_branch}</a></div>
							</div>
						</c:forEach>
					</c:if>	
				</div>	
		</div>
	</div>

		<div id="main_content" class="event_list">
			<div class="event_menu_all">
				<h2 class="theater-event">극장 이벤트</h2>
				<input type="button" class="btn_more" value="더보기" onclick="location.href='${pageContext.request.contextPath}/event/event'">
			</div>
			
			<div class="event_wrap">
				<div class="img_lst_wrap">
					<div class="img_w_01">
						<a href="#" title="화면이동">
							<img src="https://img.megabox.co.kr/SharedImg/event/2024/07/11/xokr1EWDMW4qyH5pL4kAvUlREdXO6FCY.jpg" alt="">
						</a>
					</div>
					<div class="img_w_01">
						<a href="#" title="화면이동">
							<img src="https://img.megabox.co.kr/SharedImg/event/2024/07/10/CIO1jnh3YEnAez1infc4tVEiP7Quzqa7.jpg" alt="">
						</a>
					</div>
					<div class="img_w_01">
						<a href="#" title="화면이동">
							<img src="https://img.megabox.co.kr/SharedImg/event/2024/07/24/DzQ35J735Ge18j4cFCuUIAfU0nl6oTXG.jpg" alt="">
						</a>
					</div>
					<div class="img_w_01">
						<a href="#" title="화면이동">
							<img src="https://img.megabox.co.kr/SharedImg/event/2024/07/17/Nz9KHkNBPEhhY6vLqdfsoOWHXQm1HWJA.jpg" alt="">
						</a>
					</div>
				</div>
			</div>
		</div>	

<!-- 
<h2 class="theater-pay">관람료</h2>
			
 <div class="pay-box">
 	<div class="pay-container">
	<div class="twod">2D</div>
	<div class="twodpay">
	<table class="pay-table">
		<tr class="pay-all">
			<th class="pay-thead">요일</th>
			<th class="pay-thead">상영시간</th>
			<th class="pay-thead">일반</th>
			<th class="pay-thead">청소년</th>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody" scope="row" rowspan="2">월~목</td>
			<td class="pay-tbody">조조 (06:00~)</td>
			<td class="pay-tbody">10,000</td>
			<td class="pay-tbody">8,000</td>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody">일반 (10:01~)</td>
			<td class="pay-tbody">14,000</td>
			<td class="pay-tbody">12,000</td>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody" scope="row" rowspan="2">금~일<br>공휴일</td>
			<td class="pay-tbody">조조 (06:00~)</td>
			<td class="pay-tbody">11,000</td>
			<td class="pay-tbody">9,000</td>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody">일반 (10:01~)</td>
			<td class="pay-tbody">15,000</td>
			<td class="pay-tbody">13,000</td>
		</tr>
	</table>
	</div>
	
	<div class="twod">3D</div>
	<div class="twodpay">
	<table class="pay-table">
		<tr class="pay-all">
			<th class="pay-thead">요일</th>
			<th class="pay-thead">상영시간</th>
			<th class="pay-thead">일반</th>
			<th class="pay-thead">청소년</th>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody" scope="row" rowspan="2">월~목</td>
			<td class="pay-tbody">조조 (06:00~)</td>
			<td class="pay-tbody">12,000</td>
			<td class="pay-tbody">10,000</td>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody">일반 (10:01~)</td>
			<td class="pay-tbody">16,000</td>
			<td class="pay-tbody">14,000</td>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody" scope="row" rowspan="2">금~일<br>공휴일</td>
			<td class="pay-tbody">조조 (06:00~)</td>
			<td class="pay-tbody">13,000</td>
			<td class="pay-tbody">11,000</td>
		</tr>
		<tr class="pay-all">
			<td class="pay-tbody">일반 (10:01~)</td>
			<td class="pay-tbody">17,000</td>
			<td class="pay-tbody">15,000</td>
		</tr>
	</table>
	</div>
	</div>
</div>	 

<h2 class="explain">요금제</h2>
	<div class="explain-box">
		<b class="bold-font">청소년 요금</b>  만7세~만18세 : 초등학생~고등학생(학생증, 교복, 청소년증, 의료보험증, 주민등록 등/초본, 그 외 청소년 확인 가능 서류)<br>
		<b class="bold-font">경로 요금</b> : 만65세 이상 본인에 한함(신분증 확인)<br>
		48개월 미만의 경우 증빙원(예 : 의료보험증, 주민등록 초/등본 등) 지참 시에만 무료 관람 가능
	</div>

 <h2 class="explain">우대적용</h2>
 	<div class="explain-box">
 		<b class="bold-font">국가유공자</b>  현장에서 국가유공자증을 소지한 본인 외 동반 1인까지 적용<br>
 		<b class="bold-font">장애인</b>  현장에서 복지카드를 소지한 장애인(1급~3급(중증)까지 동반 1인까지 적용 / 4급~6급(경증)은 본인에 한함)<br>
 		<b class="bold-font">미취학아동</b>  부모 동반한 만4세~ 만6세까지 본인(의료보험증, 주민등록 초/등본 확인)<br>
 		<b class="bold-font">소방종사자</b>  공무원증을 소지하거나 정복을 입은 소방관 본인
 	</div> -->
<%-- <img class="pay-image" src="${pageContext.request.contextPath}/images/hjt/pay.png" alt="">
	 <img class="payment-image" src="${pageContext.request.contextPath}/images/hjt/pay2.png" alt=""> --%>
</div>
<!-- 영화관 목록 끝 -->


<div id="banner_reserve_section" class="banner_reserve_wrap">
    <div class="bx_lft"><a
            href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_37&amp;adgroupid=adg_lottecinema_20240530_55&amp;adid=adi_lottecinema_20240530_65"
            target="_blank" title="새창열기"><img
                src="https://cf2.lottecinema.co.kr/lotte_image/2024/LotteCard/LotteCard_160300.png"></a></div>
    <div class="bx_rgt"><a
            href="https://nvapi.feeldmc.com:443/ad/p/in/v1_0/clk?slotid=stw_lottelotte_37&amp;adgroupid=adg_lottecinema_20230706_10&amp;adid=adi_lottecinema_20230706_10"
            target="_blank" title="새창열기"><img
                src="https://cf2.lottecinema.co.kr/lotte_image/2024/Hyundai_Insurance/Hyundai_Insurance_1603002.jpg"></a></div>
</div>
<style>
.banner_side_wrap {
        position: absolute;
        top: 220px;
        left: 50%;
        margin-left: -660px;
        z-index: 10;
    }

    .banner_wrap .banner_01 {
        margin-bottom: 50px;
    }

    .banner_wrap {
        padding-top: 70px;
        text-align: center;
    }

    .banner_wrap a {
        display: block;
        width: 980px;
        margin: 0 auto;
    }

    a,
    a:link,
    a:visited,
    a:active,
    a:hover {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .banner_reserve_wrap .bx_lft {
        left: 50%;
        margin-left: -820px;
    }

    .banner_reserve_wrap .bx_lft,
    .banner_reserve_wrap .bx_rgt {
        position: absolute;
        z-index: 10;
        top: 220px;
        width: 160px;
        height: 300px;
    }

    .banner_reserve_wrap .bx_rgt {
        right: 50%;
        margin-right: -820px;
    }

    .quick-reserve-ad-area {
        overflow: hidden;
        width: 1100px;
        height: 80px;
        margin-top: 10px;
    }

    iframe {
        display: inline-block;
        border: 0;
    }
</style>



