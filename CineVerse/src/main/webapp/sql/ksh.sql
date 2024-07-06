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
    constraint member_detail_pk primary key (mem_num),
    constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);
create sequence member_seq;

--회원등급 변동내역 테이블
create table rank_update (
    ru_num number not null,
    mem_num number not null,
    ru_type number default sysdate not null,
    ru_date date not null,
    constraint rank_update_pk primary key (ru_num),
    constraint rank_update_fk foreign key (mem_num) references member (mem_num)
);
create sequence rank_update_seq;

--멤버십 변동내역 테이블
create table membership_update (
    mu_num number not null,
    mem_num number not null,
    mu_type number not null,
    mu_date date default sysdate not null,
    constraint membership_update_pk primary key (mu_num),
    constraint membership_update_fk foreign key (mem_num) references member (mem_num)
);
create sequence membership_update_seq;

--회원 멤버십혜택 사용내역 테이블 
create table membership_benefits (
    msb_num number not null,
    msb_benefit number(1) default 3 not null,
    msb_date date default sysdate not null,
    mem_num number not null,
    constraint membership_benefits_pk primary key (msb_num),
    constraint membership_benefits_fk foreign key (mem_num) references member(mem_num)
);
create sequence membership_benefits_seq;
--이벤트 테이블
create table event (
    event_num number not null,
    event_name varchar2(150) not null,
    event_filename varchar2(400),
    event_content clob not null,
    event_start varchar2 not null,
    event_end varchar2 not null,
    event_reg_date date default sysdate not null,
    event_modify_date date,
    constraint event_pk primary key (event_num)
);
create sequence event_seq;

--이벤트 참여내역 테이블
create table event_participation (
    ep_num number not null,
    mem_num number not null,
    event_num number not null,
    ep_date date default sysdate not null,
    ep_content varchar2(300),
    constraint event_participation_pk primary key (ep_num),
    constraint event_participation_fk1 foreign key (mem_num) references member (mem_num),
    constraint event_participation_fk2 foreign key (event_num) references event (event_num)
);
create sequence event_participation_seq;

--포인트 내역 테이블
create table point_history (
    ph_history number not null,
    ph_point number not null default 0,
    ph_date date default sysdate not null,
    mem_num number not null,
    constraint point_history_pk primary key (ph_history),
    constraint point_history_fk foreign key (mem_num) references member (mem_num)
);
create sequence point_history_seq;

--쿠폰DB 테이블
create table coupon_db (
    coupon_num number not null,
    coupon_name varchar2(150) not null,
    coupon_content varchar2(200),
    coupon_type number not null,
    coupon_sale number not null,
    constraint coupon_db_pk primary key (coupon_num)
);
create sequence coupon_db_seq;

--회원쿠폰 테이블
create table member_coupon (
    mc_num number not null,
    coupon_use number not null,
    coupon_num number not null,
    mem_num number not null,
    constraint member_coupon_pk primary key (mc_num),
    constraint member_coupon_fk1 foreign key (coupon_num) references coupon_db (coupon_num),
    constraint member_coupon_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence member_coupon_seq;



------------------------------------------------------------------------------------------------

--쿠폰내역
create table mc_history (
    mh_num number not null,
    mh_type number not null,
    mh_date date default sysdate not null,
    mc_num number not null,
    mem_num number not null,
    constraint mc_history_pk primary key (mh_num),
    constraint mc_history_fk1 foreign key (mc_num) references member_coupon (mc_num),
    constraint mc_history_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence mc_history_seq;

--채팅방 테이블
create table chat_room (
    cr_num number not null,
    cr_reg_date date not null,
    cr_activation number(1) not null,
    ab_num number not null,
    cr_receiver number not null,
    cr_sender number not null,
    constraint chat_room_pk primary key (cr_num),
    constraint chat_room_fk1 foreign key (ab_num) references assignment_board (ab_num),
    constraint chat_room_fk2 foreign key (cr_receiver) references member (mem_num),
    constraint chat_room_fk3 foreign key (cr_sender) references member (mem_num)
);
create sequence chat_room_seq;

--채팅메세지 테이블
create table chat_message (
    cm_num number not null,
    cm_content varchar2(500) not null,
    cm_read number(1) not null,
    cm_reg_date date not null,
    cm_sender number(1) not null,
    cr_num number not null,
    constraint chat_message_pk primary key (cm_num),
    constraint chat_message_fk foreign key (cr_num) references chat_room (cr_num)
);
create sequence chat_message_seq;

--공지사항 게시판 테이블
create table notice_board (
    nb_num number not null,
    nb_title varchar2(150) not null,
    nb_content clob not null,
    nb_reg_date date default sysdate not null,
    nb_modify_date date,
    nb_filename varchar2(400),
    nb_hit number(9),
    mem_num number not null,
    constraint notice_board_pk primary key (nb_num),
    constraint notice_board_fk foreign key (mem_num) references member (mem_num)
);
create sequence notice_board_seq;

--양도 게시판 테이블
create table assignment_board ( 
    ab_num number not null,
    ab_title varchar2(150) not null,
    ab_content clob not null,
    ab_reg_date date default sysdate not null,
    ab_modify_date date,
    ab_price number(9) not null,
    ab_hit number(9) not null,
    ab_status number(1) not null,
    ab_filename clob not null,
    mem_num number not null,
    constraint assignment_board_pk primary key (ab_num),
    constraint assignment_board_fk foreign key (mem_num) references member (mem_num)
);
create sequence assignment_board_seq;

--양도 게시판 북마크
create table ab_bookmark (
    mem_num number not null,
    ab_num number not null,
    constraint ab_bookmark_pk primary key (mem_num, ab_num),
    constraint ab_bookmark_fk1 foreign key (mem_num) references member (mem_num),
    constraint ab_bookmark_fk2 foreign key (ab_num) references assignment_board (ab_num)
);

create table ab_comment (
    ac_num number not null,
    ac_content clob not null,
    ac_reg_date date not null,
    ac_modify_date date,
    ab_num number not null,
    mem_num number not null,
    constraint ab_comment_pk primary key (ac_num),
    constraint ab_comment_fk1 foreign key (ab_num) references assignment_board (ab_num),
    constraint ab_comment_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence ab_comment_seq;

create table community_board (
    cb_num number not null,
    mem_num number not null,
    cb_title varchar2(150) not null,
    cb_content clob not null,
    cb_filename varchar2(400) not null,
    cb_type number not null,
    cb_reg_date date default sysdate not null,
    cb_modify_date date,
    cb_report number(2) default 0 not null,
    constraint community_board_pk primary key (cb_num),
    constraint community_board_fk foreign key (mem_num) references member (mem_num)
);
create sequence community_board_seq;

create table community_comment (
    cc_num number not null,
    mem_num number not null,
    cb_num number not null,
    cc_content clob not null,
    cc_reg_date date default sysdate not null,
    cc_modify_date date,
    cc_report number(2) default 0 not null,
    constraint community_comment_pk primary key (cc_num),
    constraint community_comment_fk1 foreign key (mem_num) references member (mem_num),
    constraint community_comment_fk2 foreign key (cb_num) references community_board (cb_num)
);
create sequence community_comment_seq;

create table community_fav (
    mem_num number not null,
    cb_num number not null,
    constraint community_fav_pk primary key (mem_num, cb_num),
    constraint community_fav_fk1 foreign key (mem_num) references member (mem_num),
    constraint community_fav_fk2 foreign key (cb_num) references community_board (cb_num)
);
