<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="article article_seat">
	<div class="group_top">
		<h4 class="tit">인원/좌석 선택</h4>
	</div>
	<div class="inner">
		<div id="PersonSeatCount">
			<div class="select_num_people_wrap">
				<h5 class="hidden">인원선택</h5>
				<div class="movie_infor">
					<h6 class="hidden">예매 정보</h6>
					<span class="thm"><img width="100px;" height="100px;" src="https://cf.lottecinema.co.kr//Media/MovieFile/MovieImg/202406/20970_103_1.jpg"></span>
					<div class="group_infor">
						<div class="bx_tit">
							<span class="ic_grade gr_all">관람가</span><strong>인사이드 아웃
								2 </strong>
						</div>
						<dl>
							<dt>일시</dt>
							<dd class="sub_info1">
								24.07.12<em>(금)</em> <span class="time">09:00 ~ 10:46</span>
							</dd>
							<dt>영화관</dt>
							<dd class="sub_info1">강동 · 10관 · 자막</dd>
						</dl>
					</div>
				</div>
				<div class="count_people">
					<h6 class="hidden">인원선택</h6>
						<span>성인</span>
	                    <div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
	                    <span>청소년</span>
	                    <div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
	                    <span>경로</span>
	                    <div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
	                    <span>장애인</span>
	                    <div class="quantity-controls">
	                        <button type="button" class="quantity-down">-</button>
	                        <input type="number" min="1" value="0" max="4" readonly class="quantity-input"/>
	                        <button type="button" class="quantity-up">+</button>
	                    </div>
	                    
				</div>
			</div>
		</div>



		<div class="select_seat_wrap">
			<h5 class="hidden">좌석선택</h5>
			<div class="top_txt_info">
				<p id="ticketMessageInfo">인원을 선택하세요.</p>
			</div>
			<div id="PersonSeatSelect"></div>

			<div id="container" class="seat_wrap">
				<article class="mseat_wrap">
					<div class="mseat_inner">

						
								<div id="mCSB_1_container" class="mCSB_container">
									<div class="meat_door_pos" id="scrollWrap">
										<div class="mseat_hidden">

											<span class="title_screen1">SCREEN</span>

											<div class="showMap">
												<div class="floor_bx seatSet1">
													<div class="seat_area"
														style="margin-top: 30px; width: 500px; height: 300px;">
															<span
															class="seat_tit" style="left: -30px; top: 227.5px">O</span><a
															href="#" alt="좌석 번호:G5 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G5"   style="left: 165.769px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:G6 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G6"   style="left: 191.385px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:G7 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G7"   style="left: 217px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:G8 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G8"   style="left: 242.615px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:G9 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G9"   style="left: 268.231px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:G10 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G10"  style="left: 293.846px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:G11 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G11"  style="left: 319.462px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:G12 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G12"  style="left: 345.077px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:G13 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G13"  style="left: 370.692px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:G14 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum20" 
															data-seat="G14"  style="left: 396.308px; top: 227.5px;"><span
															class=" sweet_spot f1" style="top: 0px;">10</span></a> 
															
															<span
															class="seat_tit"
															style="left: -30px; top: 202.22222222222223px">I</span><a
															href="#" alt="좌석 번호:H5 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H5"   style="left: 165.769px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:H6 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H6"   style="left: 191.385px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:H7 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H7"   style="left: 217px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:H8 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H8"   style="left: 242.615px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:H9 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H9"   style="left: 268.231px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:H10 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H10"  style="left: 293.846px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:H11 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H11"  style="left: 319.462px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:H12 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H12"  style="left: 345.077px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:H13 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H13"  style="left: 370.692px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:H14 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum23" 
															data-seat="H14"  style="left: 396.308px; top: 202.222px;"><span
															class=" sweet_spot f1" style="top: 0px;">10</span></a> 
															
															<span
															class="seat_tit"
															style="left: -30px; top: 176.94444444444446px">H</span><a
															href="#" alt="좌석 번호:I5 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I5"  
															style="left: 165.769px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:I6 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I6"  
															style="left: 191.385px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:I7 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I7"  
															 style="left: 217px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:I8 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I8"  
															 style="left: 242.615px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:I9 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I9"  
															 style="left: 268.231px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:I10 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I10"  
															 style="left: 293.846px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:I11 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I11"  
															 style="left: 319.462px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:I12 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I12"  
															 style="left: 345.077px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:I13 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															data-seat="I13"  
															 style="left: 370.692px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:I14 일반석 SWEET SPOT"
															class="sel  sweet_spot p0 grNum26" 
															 style="left: 396.308px; top: 176.944px;"><span
															class=" sweet_spot f1" style="top: 0px;">10</span></a> 
															
															<span
															class="seat_tit"
															style="left: -30px; top: 151.66666666666666px">G</span><a
															href="#" alt="좌석 번호:J5 일반석"
															class="sel  p0 grNum29"  data-seat="J5"
															style="left: 165.769px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:J6 일반석"
															class="sel  p0 grNum29"  data-seat="J6"
															style="left: 191.385px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:J7 일반석"
															class="sel  p0 grNum29"  data-seat="J7"
															style="left: 217px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:J8 일반석"
															class="sel  p0 grNum29"  data-seat="J8"
															style="left: 242.615px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:J9 일반석"
															class="sel  p0 grNum29"  data-seat="J9"
															style="left: 268.231px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:J10 일반석"
															class="sel  p0 grNum29"  data-seat="J10"
															style="left: 293.846px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:J11 일반석"
															class="sel  p0 grNum29"  data-seat="J11"
															style="left: 319.462px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:J12 일반석"
															class="sel  p0 grNum29"  data-seat="J12"
															style="left: 345.077px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:J13 일반석"
															class="sel  p0 grNum29"  data-seat="J13"
															style="left: 370.692px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:J14 일반석"
															class="sel  p0 grNum29"  data-seat="J14"
															style="left: 396.308px; top: 151.667px;"><span
															class=" f1" style="top: 0px;">10</span></a>
															
															<span
															class="seat_tit"
															style="left: -30px; top: 126.38888888888889px">F</span><a
															href="#" alt="좌석 번호:K5 일반석"
															class="sel  p0 grNum32"  data-seat="K5"
															style="left: 165.769px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:K6 일반석"
															class="sel  p0 grNum32"  data-seat="K6"
															style="left: 191.385px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:K7 일반석"
															class="sel  p0 grNum32"  data-seat="K7"
															style="left: 217px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:K8 일반석"
															class="sel  p0 grNum32"  data-seat="K8"
															style="left: 242.615px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:K9 일반석"
															class="sel  p0 grNum32"  data-seat="K9"
															style="left: 268.231px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:K10 일반석"
															class="sel  p0 grNum32"  data-seat="K10"
															style="left: 293.846px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:K11 일반석"
															class="sel  p0 grNum32"  data-seat="K11"
															style="left: 319.462px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:K12 일반석"
															class="sel  p0 grNum32"  data-seat="K12"
															style="left: 345.077px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:K13 일반석"
															class="sel  p0 grNum32"  data-seat="K13"
															style="left: 370.692px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:K14 일반석"
															class="sel  p0 grNum32"  data-seat="K14"
															style="left: 396.308px; top: 126.389px;"><span
															class=" f1" style="top: 0px;">10</span></a>
															
															<span
															class="seat_tit"
															style="left: -30px; top: 101.11111111111111px">E</span><a
															href="#" alt="좌석 번호:L5 일반석"
															class="sel  p0 grNum35"  data-seat="L5"
															style="left: 165.769px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:L6 일반석"
															class="sel  p0 grNum35"  data-seat="L6"
															style="left: 191.385px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:L7 일반석"
															class="sel  p0 grNum35"  data-seat="L7"
															style="left: 217px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:L8 일반석"
															class="sel  p0 grNum35"  data-seat="L8"
															style="left: 242.615px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:L9 일반석"
															class="sel  p0 grNum35"  data-seat="L9"
															style="left: 268.231px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:L10 일반석"
															class="sel  p0 grNum35"  data-seat="L10"
															style="left: 293.846px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:L11 일반석"
															class="sel  p0 grNum35"  data-seat="L11"
															style="left: 319.462px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:L12 일반석"
															class="sel  p0 grNum35"  data-seat="L12"
															style="left: 345.077px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:L13 일반석"
															class="sel  p0 grNum35"  data-seat="L13"
															style="left: 370.692px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:L14 일반석"
															class="sel  p0 grNum35"  data-seat="L14"
															style="left: 396.308px; top: 101.111px;"><span
															class=" f1" style="top: 0px;">10</span></a>
															
															<span
															class="seat_tit"
															style="left: -30px; top: 75.83333333333333px">D</span><a
															href="#" alt="좌석 번호:M5 일반석"
															class="sel  p0 grNum38"  data-seat="M5"
															style="left: 165.769px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:M6 일반석"
															class="sel  p0 grNum38"  data-seat="M6"
															style="left: 191.385px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:M7 일반석"
															class="sel  p0 grNum38"  data-seat="M7"
															style="left: 217px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:M8 일반석"
															class="sel  p0 grNum38"  data-seat="M8"
															style="left: 242.615px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:M9 일반석"
															class="sel  p0 grNum38"  data-seat="M9"
															style="left: 268.231px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:M10 일반석"
															class="sel  p0 grNum38"  data-seat="M10"
															style="left: 293.846px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:M11 일반석"
															class="sel  p0 grNum38"  data-seat="M11"
															style="left: 319.462px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:M12 일반석"
															class="sel  p0 grNum38"  data-seat="M12"
															style="left: 345.077px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:M13 일반석"
															class="sel  p0 grNum38"  data-seat="M13"
															style="left: 370.692px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:M14 일반석"
															class="sel  p0 grNum38"  data-seat="M14"
															style="left: 396.308px; top: 75.8333px;"><span
															class=" f1" style="top: 0px;">10</span></a> 
															
															<span
															class="seat_tit"
															style="left: -30px; top: 50.55555555555556px">C</span><a
															href="#" alt="좌석 번호:N5 일반석"
															class="sel  p0 grNum41"  data-seat="N5"
															style="left: 165.769px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:N6 일반석"
															class="sel  p0 grNum41"  data-seat="N6"
															style="left: 191.385px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:N7 일반석"
															class="sel  p0 grNum41"  data-seat="N7"
															style="left: 217px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:N8 일반석"
															class="sel  p0 grNum41"  data-seat="N8"
															style="left: 242.615px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:N9 일반석"
															class="sel  p0 grNum41"  data-seat="N9"
															style="left: 268.231px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:N10 일반석"
															class="sel  p0 grNum41"  data-seat="N10"
															style="left: 293.846px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:N11 일반석"
															class="sel  p0 grNum41"  data-seat="N11"
															style="left: 319.462px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:N12 일반석"
															class="sel  p0 grNum41"  data-seat="N12"
															style="left: 345.077px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:N13 일반석"
															class="sel  p0 grNum41"  data-seat="N13"
															style="left: 370.692px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:N14 일반석"
															class="sel  p0 grNum41"  data-seat="N14"
															style="left: 396.308px; top: 50.5556px;"><span
															class=" f1" style="top: 0px;">10</span></a> 
															
															<span
															class="seat_tit"
															style="left: -30px; top: 25.27777777777778px">B</span><a
															href="#" alt="좌석 번호:O5 일반석"
															class="sel  p0 grNum44"  data-seat="O5"
															style="left: 165.769px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">1</span></a><a
															href="#" alt="좌석 번호:O6 일반석"
															class="sel  p0 grNum44"  data-seat="O6"
															style="left: 191.385px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">2</span></a><a
															href="#" alt="좌석 번호:O7 일반석"
															class="sel  p0 grNum44"  data-seat="O7"
															style="left: 217px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">3</span></a><a
															href="#" alt="좌석 번호:O8 일반석"
															class="sel  p0 grNum44"  data-seat="O8"
															style="left: 242.615px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">4</span></a><a
															href="#" alt="좌석 번호:O9 일반석"
															class="sel  p0 grNum44"  data-seat="O9"
															style="left: 268.231px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">5</span></a><a
															href="#" alt="좌석 번호:O10 일반석"
															class="sel  p0 grNum44"  data-seat="O10"
															style="left: 293.846px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">6</span></a><a
															href="#" alt="좌석 번호:O11 일반석"
															class="sel  p0 grNum44"  data-seat="O11"
															style="left: 319.462px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">7</span></a><a
															href="#" alt="좌석 번호:O12 일반석"
															class="sel  p0 grNum44"  data-seat="O12"
															style="left: 345.077px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">8</span></a><a
															href="#" alt="좌석 번호:O13 일반석"
															class="sel  p0 grNum44"  data-seat="O13"
															style="left: 370.692px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">9</span></a><a
															href="#" alt="좌석 번호:O14 일반석"
															class="sel  p0 grNum44"  data-seat="O14"
															style="left: 396.308px; top: 25.2778px;"><span
															class=" f1" style="top: 0px;">10</span></a> 
															
															<span
															class="seat_tit" style="left: -30px; top: 0px">A</span><a
															href="#" alt="좌석 번호:P5 일반석"
															class="sel  p0 grNum47"  data-seat="P5"
															style="left: 165.769px; top: 0px;"><span class=" f1"
															style="top: 0px;">1</span></a><a href="#"
															alt="좌석 번호:P6 일반석" class="sel  p0 grNum47"
															 data-seat="P6" 
															style="left: 191.385px; top: 0px;"><span class=" f1"
															style="top: 0px;">2</span></a><a href="#"
															alt="좌석 번호:P7 일반석" class="sel  p0 grNum47"
															 data-seat="P7" 
															style="left: 217px; top: 0px;"><span class=" f1"
															style="top: 0px;">3</span></a><a href="#"
															alt="좌석 번호:P8 일반석" class="sel  p0 grNum47"
															 data-seat="P8" 
															style="left: 242.615px; top: 0px;"><span class=" f1"
															style="top: 0px;">4</span></a><a href="#"
															alt="좌석 번호:P9 일반석" class="sel  p0 grNum47"
															 data-seat="P9" 
															style="left: 268.231px; top: 0px;"><span class=" f1"
															style="top: 0px;">5</span></a><a href="#"
															alt="좌석 번호:P10 일반석" class="sel  p0 grNum47"
															 data-seat="P10" 
															style="left: 293.846px; top: 0px;"><span class=" f1"
															style="top: 0px;">6</span></a><a href="#"
															alt="좌석 번호:P11 일반석" class="sel  p0 grNum47"
															 data-seat="P11" 
															style="left: 319.462px; top: 0px;"><span class=" f1"
															style="top: 0px;">7</span></a><a href="#"
															alt="좌석 번호:P12 일반석" class="sel  p0 grNum47"
															 data-seat="P12" 
															style="left: 345.077px; top: 0px;"><span class=" f1"
															style="top: 0px;">8</span></a><a href="#"
															alt="좌석 번호:P13 일반석" class="sel  p0 grNum47"
															 data-seat="P13" 
															style="left: 370.692px; top: 0px;"><span class=" f1"
															style="top: 0px;">9</span></a><a href="#"
															alt="좌석 번호:P14 일반석" class="sel  p0 grNum47"
															 data-seat="P14" 										
															style="left: 396.308px; top: 0px;"><span class=" f1"
															style="top: 0px;">10</span></a>
													</div>
												</div>
											</div>

										</div>
									</div>
						</div>
					</div>
					<div class="seat_btm_box">
						<div class="seat_type_box">
							<div class="top_info">
								<span class="seat_type1">선택</span> 
								<span class="seat_type3">예매완료</span>
								<span class="seat_type4">선택불가</span>
							</div>
						</div>

					</div>
				</article>
			</div>

		</div>
		<div id="PersonSeatSummery">
			<div class="select_seat_result">
				<div class="group_lft">
					<dl class="total_price">
						<dt>총 합계</dt>
						<dd>
							<strong>0</strong>원
						</dd>
					</dl>
				</div>
				<div class="group_rgt">
					<input type="button" class="btn_col1" id="link_rpay" value="결제하기" onclick="location.href='moviePayment'">
				</div>
			</div>
		</div>
	</div>
</div>