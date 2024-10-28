--drop table tbl_board;
--drop sequence seq_board;
--drop index pk_board;

create SEQUENCE seq_board;

create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board primary key(bno);

insert into tbl_board(bno, title, content, writer)
        values(seq_board.nextval, '테스트 제목', ' 테스트 내용', 'user00');
        
select * from tbl_board;


-- 재귀 복사를 통해서 데이터 개수 늘리기
insert into tbl_board(bno, title, content, writer)
        (select seq_board.nextval, title, content, writer from tbl_board);


select * from tbl_board order by bno desc;

select * from tbl_board order by bno+1 desc;

-- 오라클 힌트
select /*+ INDEX_DESC(tbl_board pk_board) */ *
from tbl_board
where bno>0;


select /*+ FULL(tbl_board) */ * from tbl_board order by bno desc;

-- rownum으로 1페이지 보기
select /*+ INDEX_DESC(tbl_board pk_board */ rownum rn, bno, title, content 
from tbl_board where rownum <= 10;

-- 2페이지 보기
-- 머리속에만 있고 실제로는 안됨
select /*+ INDEX_DESC(tbl_board pk_board */ rownum rn, bno, title, content 
from tbl_board where rownum > 10 and rownum <= 20;
-- 해결방안
-- 1단계 : rownum은 반드시 1이 포함되도록 해야 한다.
select /*+ INDEX_DESC(tbl_board pk_board */ rownum rn, bno, title, content 
from tbl_board where rownum <= 20;

-- 2단계 : 인라인 뷰를 사용...!!!
select bno, title, content
from (select /*+ INDEX_DESC(tbl_board pk_board */ rownum rn, bno, title, content 
        from tbl_board 
        where rownum <= 20)
where rn > 10;









