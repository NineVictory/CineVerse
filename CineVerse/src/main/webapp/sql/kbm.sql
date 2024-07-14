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