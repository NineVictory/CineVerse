--댓글 좋아요 테이블 추가
create table community_comment_fav(
 cc_num number not null,
 mem_num number not null,
 constraint cc_fk1 foreign key (cc_num) references community_comment (cc_num),
 constraint cc_fk2 foreign key (mem_num) references member (mem_num)
);