--멤버 테이블
create table member (
    mem_num number not null,
    mem_id varchar2(12) not null,
    mem_auth number(1) default 3 not null,
    mem_rank number(1) default 1 not null,
    mem_membership number(1) default 1 not null,
    constraint member_pk primary key (mem_num)
);


--멤버 상세 테이블
create table member_detail (
    mem_num number not null,
    au_id varchar2(36) unique,	-- 자동 로그인에 사용되는 식별값
    mem_name varchar2(30) not null,
    mem_passwd varchar2(35) not null,
    mem_phone varchar2(15) not null,
    mem_email varchar2(50) not null,
    photo blob,
	photo_name varchar2(100),
    mem_reg_date date default sysdate not null,
    mem_modify_date date,
    social_kakao varchar2(400),
    mem_nickname varchar2(30),
    constraint member_detail_pk primary key (mem_num),
    constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);
create sequence member_seq;

-- 등급 변동 내역 테이블
CREATE TABLE rank_update (
	ru_num number NOT NULL ,
	mem_num number NOT NULL,
	ru_type number NOT NULL,
	ru_date date NOT NULL,
	CONSTRAINT PK_RANK_UPDATE PRIMARY KEY (ru_num),
	CONSTRAINT FK_member_TO_rank_update_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence rank_update_seq;



-- 멤버십 변동 내역 테이블
CREATE TABLE membership_update (
	mu_num NUMBER NOT NULL,
	mem_num NUMBER NOT NULL,
	mu_type NUMBER NOT NULL,
	mu_date DATE DEFAULT SYSDATE NOT NULL,
	CONSTRAINT PK_MEMBERSHIP_UPDATE PRIMARY KEY (mu_num),
	CONSTRAINT FK__membership_update_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence membership_update_seq;


-- 멤버십 혜택 사용 내역
CREATE TABLE membership_benefits (
	msb_num NUMBER NOT NULL,
	msb_benefit NUMBER(1) DEFAULT 3 NOT NULL,
	msb_date DATE DEFAULT SYSDATE  NOT NULL ,
	mem_num NUMBER NOT NULL,
	CONSTRAINT PK_MEMBERSHIP_BENEFITS PRIMARY KEY (msb_num),
	CONSTRAINT FK_membership_benefits_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence membership_benefits_seq;

-- 이벤트
CREATE TABLE event (
    event_num NUMBER NOT NULL,
    event_name VARCHAR2(150) NOT NULL,
    event_filename VARCHAR2(400) NULL,
    event_content CLOB NOT NULL,
    event_start VARCHAR2(50) NOT NULL,
    event_end VARCHAR2(50) NOT NULL,
    event_reg_date DATE DEFAULT SYSDATE NOT NULL,
    event_modify_date DATE NULL,
    CONSTRAINT PK_EVENT PRIMARY KEY (event_num)
);
create sequence event_seq;


-- 이벤트 참여 내역 	
CREATE TABLE event_participation (
    ep_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    event_num NUMBER NOT NULL,
    ep_date DATE DEFAULT SYSDATE NOT NULL,
    ep_content VARCHAR2(300),
    CONSTRAINT PK_EVENT_PARTICIPATION PRIMARY KEY (ep_num),
    CONSTRAINT FK_event_participation_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_event_participation_2 FOREIGN KEY (event_num) REFERENCES event (event_num)
);

create sequence event_participation_seq;

-- 포인트 내역
CREATE TABLE point_history (
    ph_num NUMBER NOT NULL,
    ph_point NUMBER NOT NULL,
    ph_date DATE DEFAULT SYSDATE NOT NULL ,
    mem_num NUMBER NOT NULL,
    ph_type NUMBER NOT NULL,		-- 1: 충전 0: 환불
    ph_payment VARCHAR2(100) NOT NULL,	-- kakaopay 또는 tosspay로 결정됨
    CONSTRAINT PK_POINT_HISTORY PRIMARY KEY (ph_num),
    CONSTRAINT FK_member_TO_point_history_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
create sequence point_history_seq;

-- 쿠폰 DB
CREATE TABLE coupon_db (
    coupon_num NUMBER NOT NULL,
    coupon_name VARCHAR2(150) NOT NULL,
    coupon_content VARCHAR2(200),
    coupon_type NUMBER NOT NULL,
    coupon_sale NUMBER NOT NULL,
    coupon_where NUMBER NOT NULL,
    CONSTRAINT PK_COUPON_DB PRIMARY KEY (coupon_num)
);

create sequence coupon_db_seq;

-- 회원 쿠폰
CREATE TABLE member_coupon (
    mc_num NUMBER NOT NULL,
    coupon_use NUMBER NOT NULL,
    coupon_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    CONSTRAINT PK_MEMBER_COUPON PRIMARY KEY (mc_num),
    CONSTRAINT FK_member_coupon_1 FOREIGN KEY (coupon_num) REFERENCES coupon_db (coupon_num),
    CONSTRAINT FK_member_coupon_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence member_coupon_seq;

-- 회원 쿠폰 사용 내역
CREATE TABLE mc_history (
    mh_num NUMBER NOT NULL,
    mh_type NUMBER NOT NULL,
    mh_date DATE DEFAULT SYSDATE NOT NULL ,
    mc_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    CONSTRAINT PK_MC_HISTORY PRIMARY KEY (mh_num),
    CONSTRAINT FK_mc_history_1 FOREIGN KEY (mc_num) REFERENCES member_coupon (mc_num),
    CONSTRAINT FK_mc_history_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence mc_history_seq;

-- 공지글
CREATE TABLE notice_board (
    nb_num NUMBER NOT NULL,
    nb_title VARCHAR2(150) NOT NULL,
    nb_content CLOB NOT NULL,
    nb_reg_date DATE DEFAULT SYSDATE NOT NULL ,
    nb_modify_date DATE,
    nb_filename VARCHAR2(400),
    nb_hit NUMBER(9),
    mem_num NUMBER NOT NULL,
    CONSTRAINT PK_NOTICE_BOARD PRIMARY KEY (nb_num),
    CONSTRAINT FK_member_TO_notice_board_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence notice_board_seq;



-- 양도 게시판 

CREATE TABLE assignment_board (
    ab_num NUMBER NOT NULL,
    ab_title VARCHAR2(150) NOT NULL,
    ab_content CLOB NOT NULL,
    ab_reg_date DATE DEFAULT SYSDATE NOT NULL,
    ab_modify_date DATE,
    ab_price NUMBER(9) NOT NULL,
    ab_hit NUMBER(9) NOT NULL,
    ab_status NUMBER(1) NOT NULL,
    ab_filename CLOB NOT NULL,
    mem_num NUMBER NOT NULL,
    ab_report NUMBER(2),
    CONSTRAINT PK_ASSIGNMENT_BOARD PRIMARY KEY (ab_num),
    CONSTRAINT FK_assignment_board_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
 	

create sequence assignment_board_seq;


-- 양도 게시판 북마크
CREATE TABLE ab_bookmark (
    mem_num NUMBER NOT NULL,
    ab_num NUMBER NOT NULL,
    CONSTRAINT PK_AB_BOOKMARK PRIMARY KEY (mem_num, ab_num),
    CONSTRAINT FK_ab_bookmark_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_ab_bookmark_2 FOREIGN KEY (ab_num) REFERENCES assignment_board (ab_num)
);


-- 양도 게시판 댓글
CREATE TABLE ab_comment (
    ac_num NUMBER NOT NULL,
    ac_content CLOB NOT NULL,
    ac_reg_date DATE NOT NULL,
    ac_modify_date DATE NOT NULL,
    ab_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    CONSTRAINT PK_AB_COMMENT PRIMARY KEY (ac_num),
    CONSTRAINT FK__ab_comment_1 FOREIGN KEY (ab_num) REFERENCES assignment_board (ab_num),
    CONSTRAINT FK_ab_comment_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence ab_comment_seq;
	

-- 채팅방
CREATE TABLE chat_room (
    cr_num NUMBER NOT NULL,
    cr_reg_date DATE DEFAULT SYSDATE NOT NULL,
    cr_activation NUMBER(1) NOT NULL,
    ab_num NUMBER NOT NULL,
    cr_receiver NUMBER NOT NULL,
    cr_sender NUMBER NOT NULL,
    CONSTRAINT PK_CHAT_ROOM PRIMARY KEY (cr_num),
    CONSTRAINT FK_chat_room_1 FOREIGN KEY (ab_num) REFERENCES assignment_board (ab_num),
    CONSTRAINT FK_chat_room_2 FOREIGN KEY (cr_receiver) REFERENCES member (mem_num),
    CONSTRAINT FK_chat_room_3 FOREIGN KEY (cr_sender) REFERENCES member (mem_num)
);

create sequence chat_room_seq;

-- 채팅 메시지
CREATE TABLE chat_message (
    cm_num NUMBER NOT NULL,
    cm_content VARCHAR2(500) NOT NULL,
    cm_read NUMBER(1) NOT NULL,
    cm_reg_date DATE NOT NULL,
    cm_sender NUMBER(1) NOT NULL,
    cr_num NUMBER NOT NULL,
    CONSTRAINT PK_CHAT_MESSAGE PRIMARY KEY (cm_num),
    CONSTRAINT FK_chat_message_1 FOREIGN KEY (cr_num) REFERENCES chat_room (cr_num)
);

create sequence chat_message_seq;


-- 커뮤니티
CREATE TABLE community_board (
    cb_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    cb_title VARCHAR2(150) NOT NULL,
    cb_content CLOB NOT NULL,
    cb_filename VARCHAR2(400) NOT NULL,
    cb_type NUMBER NOT NULL,
    cb_reg_date DATE DEFAULT SYSDATE NOT NULL ,
    cb_modify_date DATE,
    cb_report NUMBER(2) DEFAULT 0 NOT NULL ,
    CONSTRAINT PK_COMMUNITY_BOARD PRIMARY KEY (cb_num),
    CONSTRAINT FK_community_board_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence community_board_seq;


-- 커뮤니티 댓글
CREATE TABLE community_comment (
    cc_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    cb_num NUMBER NOT NULL,
    cc_content CLOB NOT NULL,
    cc_reg_date DATE DEFAULT SYSDATE  NOT NULL,
    cc_modify_date DATE,
    cc_report NUMBER(2) DEFAULT 0  NOT NULL,
    CONSTRAINT PK_COMMUNITY_COMMENT PRIMARY KEY (cc_num),
    CONSTRAINT FK_community_comment_1 FOREIGN KEY (cb_num) REFERENCES community_board (cb_num),
    CONSTRAINT FK_community_comment_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence community_comment_seq;

-- 커뮤니티 좋아요
CREATE TABLE community_fav (
    mem_num NUMBER NOT NULL,
    cb_num NUMBER NOT NULL,
    CONSTRAINT PK_COMMUNITY_FAV PRIMARY KEY (mem_num, cb_num),
    CONSTRAINT FK_community_fav_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_community_fav_2 FOREIGN KEY (cb_num) REFERENCES community_board (cb_num)
);

-- 커뮤니티 북마크
CREATE TABLE community_bookmark (
    cb_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    CONSTRAINT PK_COMMUNITY_BOOKMARK PRIMARY KEY (cb_num, mem_num),
    CONSTRAINT FK_community_bookmark_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_community_bookmark_2 FOREIGN KEY (cb_num) REFERENCES community_board (cb_num)
);


-- 자체 영화
CREATE TABLE movie (
    m_code NUMBER NOT NULL,
    m_name VARCHAR2(150) NOT NULL,
    m_openDate DATE NOT NULL,
    m_companys VARCHAR2(400) NOT NULL,
    m_status NUMBER NOT NULL,
    CONSTRAINT PK_MOVIE PRIMARY KEY (m_code)
);

create sequence movie_seq;


-- 자체 영화 장르
CREATE TABLE movie_genre (
    m_code NUMBER NOT NULL,
    genre VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_MOVIE_GENRE PRIMARY KEY (m_code, genre),
    CONSTRAINT FK_movie_genre_1 FOREIGN KEY (m_code) REFERENCES movie (m_code)
);


-- 자체 영화 감독
CREATE TABLE movie_director (
    m_code NUMBER NOT NULL,
    director VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_MOVIE_DIRECTOR PRIMARY KEY (m_code, director),
    CONSTRAINT FK_movie_director_1 FOREIGN KEY (m_code) REFERENCES movie (m_code)
);

-- 자체 영화 배우
CREATE TABLE movie_actor (
    m_code NUMBER NOT NULL,
    actor VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_MOVIE_ACTOR PRIMARY KEY (m_code, actor),
    CONSTRAINT FK_movie_actor_1 FOREIGN KEY (m_code) REFERENCES movie (m_code)
);

-- 자체 영화관
CREATE TABLE cinema (
    c_num NUMBER NOT NULL,
    c_branch VARCHAR2(15) NOT NULL,
    c_location VARCHAR2(10) NOT NULL,
    c_address VARCHAR2(150) NOT NULL,
    c_phone VARCHAR2(11) NOT NULL,
    c_theater NUMBER NOT NULL,
    c_seat NUMBER NOT NULL,
    c_parkable VARCHAR2(5), -- Oracle에서는 boolean 대신 VARCHAR2로 처리
    c_filename CLOB NULL,
    CONSTRAINT PK_CINEMA PRIMARY KEY (c_num)
);

create sequence cinema_num;

-- 자체 영화관 좌석
CREATE TABLE seat (
    seat_num NUMBER NOT NULL,
    seat_rank VARCHAR2(1) NOT NULL,
    seat_row VARCHAR2(1) NOT NULL,
    seat_column NUMBER NOT NULL,
    th_num NUMBER NOT NULL,
    CONSTRAINT PK_SEAT PRIMARY KEY (seat_num),
    CONSTRAINT FK_seat_1 FOREIGN KEY (th_num) REFERENCES theater (th_num)
);
create sequence seat_num_seq;

-- 자체 영화관 좌석 리뷰
CREATE TABLE seat_review (
    sr_num NUMBER NOT NULL,
    sr_content VARCHAR2(500) NOT NULL,
    md_num NUMBER NOT NULL,
    seat_num NUMBER NOT NULL,
    CONSTRAINT PK_SEAT_REVIEW PRIMARY KEY (sr_num),
    CONSTRAINT FK_seat_review_1 FOREIGN KEY (seat_num) REFERENCES seat (seat_num)
);
create sequence seat_review_seq;

-- 자체 영화 시간표
CREATE TABLE movie_time (
    mt_num NUMBER NOT NULL,
    mt_date DATE NOT NULL,
    mt_start VARCHAR2(7) NOT NULL,
    mt_end VARCHAR2(7) NOT NULL,
    m_code NUMBER NOT NULL,
    th_num NUMBER NOT NULL,
    CONSTRAINT PK_MOVIE_TIME PRIMARY KEY (mt_num),
    CONSTRAINT FK_movie_time_1 FOREIGN KEY (m_code) REFERENCES movie (m_code),
    CONSTRAINT FK_movie_time_2 FOREIGN KEY (th_num) REFERENCES theater (th_num)
);
create sequence movie_time_seq;


-- 자체 영화 북마크
CREATE TABLE movie_bookmark (
    mem_num NUMBER NOT NULL,
    m_code NUMBER NOT NULL,
    CONSTRAINT PK_MOVIE_BOOKMARK PRIMARY KEY (mem_num, m_code),
    CONSTRAINT FK_movie_bookmark_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_movie_bookmark_2 FOREIGN KEY (m_code) REFERENCES movie (m_code)
);


-- 자체 영화 예매
CREATE TABLE movie_booking (
    mb_num NUMBER NOT NULL,
    mb_date DATE DEFAULT SYSDATE NOT NULL ,
    mb_price NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    mt_num NUMBER NOT NULL,
    CONSTRAINT PK_MOVIE_BOOKING PRIMARY KEY (mb_num),
    CONSTRAINT FK_movie_booking_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_movie_booking_2 FOREIGN KEY (mt_num) REFERENCES movie_time (mt_num)
);
create sequence movie_booking_seq;


-- 자체 영화 상세
CREATE TABLE mb_detail (
    md_num NUMBER NOT NULL,
    md_type NUMBER(1) NOT NULL,
    mb_num NUMBER NOT NULL,
    seat_num NUMBER NOT NULL,
    CONSTRAINT PK_MB_DETAIL PRIMARY KEY (md_num),
    CONSTRAINT FK_mb_detail_1 FOREIGN KEY (mb_num) REFERENCES movie_booking (mb_num),
    CONSTRAINT FK_mb_detail_2 FOREIGN KEY (seat_num) REFERENCES seat (seat_num)
);

create sequence mb_detail_seq;

-- 영화 리뷰
CREATE TABLE movie_review (
    mr_num NUMBER NOT NULL,
    mr_content CLOB NOT NULL,
    mr_regdate DATE DEFAULT SYSDATE NOT NULL ,
    mr_spoiler NUMBER DEFAULT 1  NOT NULL ,
    mr_grade NUMBER NOT NULL,
    md_num NUMBER NOT NULL,
    m_code NUMBER NOT NULL,
    CONSTRAINT PK_MOVIE_REVIEW PRIMARY KEY (mr_num),
    CONSTRAINT FK_movie_review_1 FOREIGN KEY (m_code) REFERENCES movie (m_code)
);

create sequence movie_review_seq;
--영화 리뷰 좋아요
CREATE TABLE mr_fav (
    mr_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    CONSTRAINT review_fav_fk1 FOREIGN KEY (mr_num) REFERENCES movie_review (mr_num),
    CONSTRAINT review_fav_fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
-- 상품
CREATE TABLE product (
    p_num NUMBER NOT NULL,
    p_name varchar2(30) NOT NULL,
    p_category varchar2(20) NOT NULL,
    p_content clob NOT NULL,
    p_quantity number(10) NOT NULL,
    p_price number(20) NOT NULL,
    p_reg_date date DEFAULT SYSDATE NOT NULL ,
    p_modify_date date NULL,
    p_filename clob NULL,
    CONSTRAINT PK_PRODUCT PRIMARY KEY (p_num)
);

create sequence product_seq;

-- 장바구니
CREATE TABLE p_basket (
    pb_num NUMBER NOT NULL,
    pb_quantity number(10) NOT NULL,
    p_reg_date date DEFAULT SYSDATE  NOT NULL,
    p_num NUMBER NOT NULL,
    mem_num number NOT NULL,
    CONSTRAINT PK_P_BASKET PRIMARY KEY (pb_num),
    CONSTRAINT FK_p_basket_1 FOREIGN KEY (p_num) REFERENCES product (p_num),
    CONSTRAINT FK_p_basket_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence p_basket_seq;

-- 주소지
CREATE TABLE address (
    a_num number NOT NULL,
    a_name varchar2(150) NOT NULL,
    a_zipcode varchar2(5) NOT NULL,
    a_address1 varchar2(90) NOT NULL,
    a_address2 varchar2(90) NOT NULL,
    a_default number(1) DEFAULT 2  NOT NULL,
    a_phone varchar2(15) NOT NULL,
    mem_num number NOT NULL,
    CONSTRAINT PK_ADDRESS PRIMARY KEY (a_num),
    CONSTRAINT FK_address_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence address_seq;

-- 주문
CREATE TABLE orders (
    order_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    order_date DATE DEFAULT SYSDATE NOT NULL,
    order_status NUMBER(1) DEFAULT 1 NOT NULL,
    a_num NUMBER NOT NULL,
    CONSTRAINT PK_ORDER PRIMARY KEY (order_num),
    CONSTRAINT FK_order_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_order_2 FOREIGN KEY (a_num) REFERENCES address (a_num)
);

create sequence orders_seq;

-- 주문 내역
CREATE TABLE order_detail (
    od_num number NOT NULL,
    order_quantity number(3) NOT NULL,
    order_num number NOT NULL,
od_review_status NUMBER(1) DEFAULT 1 NOT NULL,
    p_num NUMBER NOT NULL,
    CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (od_num),
    CONSTRAINT FK_order_detail_1 FOREIGN KEY (order_num) REFERENCES orders (order_num),
    CONSTRAINT FK_order_detail_2 FOREIGN KEY (p_num) REFERENCES product (p_num)
);

create sequence order_detail_seq;

-- 주문 교환반품
CREATE TABLE order_change (
    oc_num number NULL,
    oc_type number NOT NULL,
    oc_content clob NOT NULL,
    oc_reg_date date DEFAULT sysdate NOT NULL,
    oc_confirm number DEFAULT 0 NOT NULL,
    oc_filename clob NOT NULL,
    order_num number NOT NULL,
    CONSTRAINT PK_ORDER_CHANGE PRIMARY KEY (oc_num),
    CONSTRAINT FK_order_change_1 FOREIGN KEY (order_num) REFERENCES orders (order_num)
);

create sequence order_change_seq;

-- 상품 리뷰
CREATE TABLE product_review (
    pr_num number NOT NULL,
    pr_content clob NOT NULL,
    pr_reg_date date DEFAULT sysdate NOT NULL,
    pr_filename clob NULL,
    od_num number NOT NULL,
    p_num NUMBER NOT NULL,
    pr_grade NUMBER(1) NOT NULL,
    CONSTRAINT PK_PRODUCT_REVIEW PRIMARY KEY (pr_num),
    CONSTRAINT FK_product_review_1 FOREIGN KEY (od_num) REFERENCES order_detail (od_num),
    CONSTRAINT FK_product_review_2 FOREIGN KEY (p_num) REFERENCES product (p_num)
);

create sequence product_review_seq;

CREATE TABLE fav_product (
    mem_num number NOT NULL,
    p_num NUMBER NOT NULL,
    CONSTRAINT PK_FAV_PRODUCT PRIMARY KEY (mem_num, p_num),
    CONSTRAINT FK_fav_product_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT FK_fav_product_2 FOREIGN KEY (p_num) REFERENCES product (p_num)
);



-- 영화 재개봉 (회원이 제안)
CREATE TABLE re_movie (
    rm_num number NOT NULL,
    rm_name varchar2(100) NOT NULL,
    rm_date varchar2(100) NOT NULL,
    rm_place varchar2(300) NOT NULL,
    rm_status number DEFAULT 1 NULL,
    mem_num number NOT NULL,
    CONSTRAINT PK_RE_MOVIE PRIMARY KEY (rm_num),
    CONSTRAINT FK_re_movie_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence re_movie_seq;

-- 영화 재개봉 (제안 수락 관리자가 폼 개시)
CREATE TABLE rm_form (
    rf_num number NOT NULL,
    rf_content clob NOT NULL,
    rf_status number(1) DEFAULT 1 NOT NULL ,
    rm_num number NOT NULL,
    rf_reg_date date DEFAULT SYSDATE NOT NULL ,
    rf_modify_date date NULL,
    mem_num number NOT NULL,
    CONSTRAINT PK_RM_FORM PRIMARY KEY (rf_num),
    CONSTRAINT FK_rm_form_1 FOREIGN KEY (rm_num) REFERENCES re_movie (rm_num),
    CONSTRAINT FK_rm_form_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence rm_form_seq;

-- 영화 재개봉 (위 폼에 사전예약 제출)
CREATE TABLE rm_application (
    ra_num number NOT NULL,
    ra_reg_date date DEFAULT sysdate  NULL,
    mem_num number NOT NULL,
    rf_num number NOT NULL,
    CONSTRAINT PK_RM_APPLICATION PRIMARY KEY (ra_num),
    CONSTRAINT FK_rm_application_1 FOREIGN KEY (rf_num) REFERENCES re_movie (rm_num),
    CONSTRAINT FK_rm_application_2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence rm_application_seq;


CREATE TABLE consult (
    consult_num number NOT NULL,
    consult_content clob NOT NULL,
    consult_reg_date date DEFAULT SYSDATE NOT NULL ,
    consult_modify_date date NULL,
    consult_status number(1)  DEFAULT 1 NOT NULL,
    consult_title varchar2(300) NOT NULL,
    mem_num number NOT NULL,
    CONSTRAINT PK_CONSULT PRIMARY KEY (consult_num),
    CONSTRAINT FK_consult_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

create sequence consult_seq;


-- 영화 API 관련

CREATE TABLE movie_api (
    ma_code varchar2(900) NOT NULL,
    ma_name varchar2(900) NULL,
    ma_madeYear varchar2(900) NULL,
    ma_openDate varchar2(900) NULL,
    ma_repGenre varchar2(900) NULL,
    ma_allGenre varchar2(900) NULL,
    CONSTRAINT PK_MOVIE_API PRIMARY KEY (ma_code)
);

CREATE TABLE movie_detail_api (
    mad_movieCd VARCHAR2(900) NOT NULL,
    mad_movieNm VARCHAR2(900),
    mad_showTm VARCHAR2(900),
    mad_openDt VARCHAR2(900),
    mad_genreNm VARCHAR2(900),
    mad_cast VARCHAR2(900),
    mad_watchGradeNm VARCHAR2(900),
    CONSTRAINT PK_movie_detail_api PRIMARY KEY (mad_movieCd),
    CONSTRAINT FK_movie_detail_api FOREIGN KEY (mad_movieCd) REFERENCES movie_api (ma_code)
);

CREATE TABLE company_api (
    mad_movieCd varchar2(900) NOT NULL,
    mad_companyNm varchar2(900) NULL,
    mad_companyCd varchar2(900) NULL,
    CONSTRAINT PK_COMPANY_API PRIMARY KEY (mad_movieCd),
    CONSTRAINT FK_company_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_detail_api (mad_movieCd)
);

CREATE TABLE actors_api (
    mad_movieCd varchar2(900) NOT NULL,
    mad_actorNm varchar2(900) NULL,
    CONSTRAINT PK_ACTORS_API PRIMARY KEY (mad_movieCd),
    CONSTRAINT FK_actors_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_detail_api (mad_movieCd)
);

CREATE TABLE directors_api (
    mad_movieCd varchar2(900) NOT NULL,
    감독_이름 varchar2(900) NULL,
    CONSTRAINT PK_DIRECTORS_API PRIMARY KEY (mad_movieCd),
    CONSTRAINT FK_directors_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_detail_api (mad_movieCd)
);







-- 외래키 추가를 위한 ALTER TABLE 명령어 모음

-- 이미 외래키 제약 조건이 있는 경우에는 아래 추가 필요 없음
-- 필요시 재확인 후 추가 필요

ALTER TABLE member_detail ADD CONSTRAINT FK_member_TO_member_detail_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE rank_update ADD CONSTRAINT FK_member_TO_rank_update_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE membership_update ADD CONSTRAINT FK_member_TO_membership_update_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE membership_benefits ADD CONSTRAINT FK_member_TO_membership_benefits_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE event_paricipation ADD CONSTRAINT FK_member_TO_event_paricipation_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE event_paricipation ADD CONSTRAINT FK_event_TO_event_paricipation_1 FOREIGN KEY (event_num) REFERENCES event (event_num);
ALTER TABLE point_history ADD CONSTRAINT FK_member_TO_point_history_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE member_coupon ADD CONSTRAINT FK_coupon_db_TO_member_coupon_1 FOREIGN KEY (coupon_num) REFERENCES coupon_db (coupon_num);
ALTER TABLE member_coupon ADD CONSTRAINT FK_member_TO_member_coupon_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE mc_history ADD CONSTRAINT FK_member_coupon_TO_mc_history_1 FOREIGN KEY (mc_num) REFERENCES member_coupon (mc_num);
ALTER TABLE mc_history ADD CONSTRAINT FK_member_TO_mc_history_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE chat_room ADD CONSTRAINT FK_assignment_board_TO_chat_room_1 FOREIGN KEY (ab_num) REFERENCES assignment_board (ab_num);
ALTER TABLE chat_room ADD CONSTRAINT FK_member_TO_chat_room_1 FOREIGN KEY (cr_receiver) REFERENCES member (mem_num);
ALTER TABLE chat_room ADD CONSTRAINT FK_member_TO_chat_room_2 FOREIGN KEY (cr_sender) REFERENCES member (mem_num);
ALTER TABLE chat_message ADD CONSTRAINT FK_chat_room_TO_chat_message_1 FOREIGN KEY (cr_num) REFERENCES chat_room (cr_num);
ALTER TABLE notice_board ADD CONSTRAINT FK_member_TO_notice_board_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE assignment_board ADD CONSTRAINT FK_member_TO_assignment_board_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE ab_bookmark ADD CONSTRAINT FK_member_TO_ab_bookmark_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE ab_bookmark ADD CONSTRAINT FK_assignment_board_TO_ab_bookmark_1 FOREIGN KEY (ab_num) REFERENCES assignment_board (ab_num);
ALTER TABLE ab_comment ADD CONSTRAINT FK_assignment_board_TO_ab_comment_1 FOREIGN KEY (ab_num) REFERENCES assignment_board (ab_num);
ALTER TABLE ab_comment ADD CONSTRAINT FK_member_TO_ab_comment_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE community_board ADD CONSTRAINT FK_member_TO_community_board_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE community_comment ADD CONSTRAINT FK_community_board_TO_community_comment_1 FOREIGN KEY (cb_num) REFERENCES community_board (cb_num);
ALTER TABLE community_comment ADD CONSTRAINT FK_member_TO_community_comment_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE community_fav ADD CONSTRAINT FK_member_TO_community_fav_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE community_fav ADD CONSTRAINT FK_community_board_TO_community_fav_1 FOREIGN KEY (cb_num) REFERENCES community_board (cb_num);
ALTER TABLE movie_genre ADD CONSTRAINT FK_movie_TO_movie_genre_1 FOREIGN KEY (m_code) REFERENCES movie (m_code);
ALTER TABLE movie_director ADD CONSTRAINT FK_movie_TO_movie_director_1 FOREIGN KEY (m_code) REFERENCES movie (m_code);
ALTER TABLE seat ADD CONSTRAINT FK_cinema_TO_seat_1 FOREIGN KEY (c_num) REFERENCES cinema (c_num);
ALTER TABLE seat_review ADD CONSTRAINT FK_seat_TO_seat_review_1 FOREIGN KEY (seat_num) REFERENCES seat (seat_num);
ALTER TABLE movie_time ADD CONSTRAINT FK_movie_TO_movie_time_1 FOREIGN KEY (m_code) REFERENCES movie (m_code);
ALTER TABLE movie_time ADD CONSTRAINT FK_cinema_TO_movie_time_1 FOREIGN KEY (c_num) REFERENCES cinema (c_num);
ALTER TABLE movie_bookmark ADD CONSTRAINT FK_member_TO_movie_bookmark_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE movie_bookmark ADD CONSTRAINT FK_movie_TO_movie_bookmark_1 FOREIGN KEY (m_code) REFERENCES movie (m_code);
ALTER TABLE movie_booking ADD CONSTRAINT FK_member_TO_movie_booking_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE movie_booking ADD CONSTRAINT FK_movie_time_TO_movie_booking_1 FOREIGN KEY (mt_num) REFERENCES movie_time (mt_num);
ALTER TABLE mb_detail ADD CONSTRAINT FK_movie_booking_TO_mb_detail_1 FOREIGN KEY (mb_num) REFERENCES movie_booking (mb_num);
ALTER TABLE mb_detail ADD CONSTRAINT FK_seat_TO_mb_detail_1 FOREIGN KEY (seat_num) REFERENCES seat (seat_num);
ALTER TABLE movie_review ADD CONSTRAINT FK_movie_TO_movie_review_1 FOREIGN KEY (m_code) REFERENCES movie (m_code);
ALTER TABLE p_basket ADD CONSTRAINT FK_product_TO_p_basket_1 FOREIGN KEY (p_num) REFERENCES product (p_num);
ALTER TABLE p_basket ADD CONSTRAINT FK_member_TO_p_basket_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE address ADD CONSTRAINT FK_member_TO_address_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE orders ADD CONSTRAINT FK_member_TO_order_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE orders ADD CONSTRAINT FK_address_TO_order_1 FOREIGN KEY (a_num) REFERENCES address (a_num);
ALTER TABLE order_detail ADD CONSTRAINT FK_order_TO_order_detail_1 FOREIGN KEY (order_num) REFERENCES "order" (order_num);
ALTER TABLE order_detail ADD CONSTRAINT FK_product_TO_order_detail_1 FOREIGN KEY (p_num) REFERENCES product (p_num);
ALTER TABLE re_movie ADD CONSTRAINT FK_member_TO_re_movie_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE rm_application ADD CONSTRAINT FK_re_movie_TO_rm_application_1 FOREIGN KEY (rf_num) REFERENCES re_movie (rm_num);
ALTER TABLE rm_application ADD CONSTRAINT FK_member_TO_rm_application_1 FOREIGN KEY (mem_num2) REFERENCES member (mem_num);
ALTER TABLE company_api ADD CONSTRAINT FK_movie_detail_api_TO_company_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_detail_api (mad_movieCd);
ALTER TABLE actors_api ADD CONSTRAINT FK_movie_detail_api_TO_actors_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_detail_api (mad_movieCd);
ALTER TABLE directors_api ADD CONSTRAINT FK_movie_detail_api_TO_directors_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_detail_api (mad_movieCd);
ALTER TABLE movie_detail_api ADD CONSTRAINT FK_movie_api_TO_movie_detail_api_1 FOREIGN KEY (mad_movieCd) REFERENCES movie_api (ma_code);
ALTER TABLE order_change ADD CONSTRAINT FK_order_TO_order_change_1 FOREIGN KEY (order_num) REFERENCES "order" (order_num);
ALTER TABLE product_review ADD CONSTRAINT FK_order_detail_TO_product_review_1 FOREIGN KEY (od_num) REFERENCES order_detail (od_num);
ALTER TABLE product_review ADD CONSTRAINT FK_product_TO_product_review_1 FOREIGN KEY (p_num) REFERENCES product (p_num);
ALTER TABLE fav_product ADD CONSTRAINT FK_member_TO_fav_product_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE fav_product ADD CONSTRAINT FK_product_TO_fav_product_1 FOREIGN KEY (p_num) REFERENCES product (p_num);
ALTER TABLE movie_actor ADD CONSTRAINT FK_movie_TO_movie_actor_1 FOREIGN KEY (m_code) REFERENCES movie (m_code);
ALTER TABLE community_bookmark ADD CONSTRAINT FK_member_TO_community_bookmark_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE community_bookmark ADD CONSTRAINT FK_community_board_TO_community_bookmark_1 FOREIGN KEY (cb_num) REFERENCES community_board (cb_num);
ALTER TABLE consult ADD CONSTRAINT FK_member_TO_consult_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE rm_form ADD CONSTRAINT FK_re_movie_TO_rm_form_1 FOREIGN KEY (rm_num) REFERENCES re_movie (rm_num);
ALTER TABLE rm_form ADD CONSTRAINT FK_member_TO_rm_form_1 FOREIGN KEY (mem_num) REFERENCES member (mem_num); 
