--댓글 좋아요 테이블 추가
create table community_comment_fav(
 cc_num number not null,
 mem_num number not null,
 constraint cc_fk1 foreign key (cc_num) references community_comment (cc_num),
 constraint cc_fk2 foreign key (mem_num) references member (mem_num)
);


--답글 테이블 추가
create table community_response_fav(
 te_num number not null,
 te_content varchar2(900) not null,
 te_date date default sysdate not null,
 te_mdate date,
 te_parent_num number not null, --부모글의 번호가 들어감, 자식글이 아니라 부모글일 경우 0
 te_depth number not null, --자식글의 깊이. 부모글의 자식글A 1, 자식글A의 자식글B 2, 부모글일 경우 0  (부모글 0 참조할 수 업음. fk 제약조건 불가
 te_ip varchar2(40) not null,
 cc_num number not null,
 mem_num number not null,
 te_report number default 0,
 constraint cr_pk primary key (te_num),
 constraint cr_fk1 foreign key (cc_num) references community_comment (cc_num),
 constraint cr_fk2 foreign key (mem_num) references member (mem_num)
);

create sequence community_response_seq;



--답글 좋아요 추가
create table community_response_fav(
 cc_num number not null,
 mem_num number not null,
 constraint crfav_fk1 foreign key (cc_num) references community_comment (cc_num),
 constraint crfav_fk2 foreign key (mem_num) references member (mem_num)
);


--커뮤니티 신고
create table community_report{
 cr_num number not null,
 cr_content varchar2(300)
 cr_category number(1) not null,
 mem_num number not null,
 cb_num number not null,
 constraint creport_fk1 foreign key (cb_num) references community_board (cb_num),
 constraint creport_fk2 foreign key (mem_num) references member (mem_num)
};

create sequence community_report_seq;


--양도글 신고
create table assign_report{
 ar_num number not null,
 ar_content varchar2(300)
 ar_category number(1) not null,
 mem_num number not null,
 ab_num number not null,
 constraint creport_fk1 foreign key (ab_num) references assignment_board (ab_num),
 constraint creport_fk2 foreign key (mem_num) references member (mem_num)
};

create sequence assign_report_seq;

--댓글 신고

CREATE TABLE FAQ(
 F_NUM number not null,
 MEM_NUM number not null,
 F_TITLE varchar2(150) not null,
 F_CONTENT clob not null,
 F_REG_DATE date not null,
 F_MODIFY_DATE date,
 F_FILENAME varchar2(400),
 F_HIT number(9) not null,
 constraint faq_pk primary key (F_NUM),
 constraint faq_fk foreign key (mem_num) references member (mem_num)
);

create sequence faq_seq;