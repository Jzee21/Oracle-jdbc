--	*********************
--	 게시판  관련 SQL 작성
--	********************
--	users 테이블 생성 구문 
--	     id          
--	     password   
--	     name        
--	     role       -- admin / user
--	
--	board 테이블 생성 구문 
--	     seq		-- num of content	
--	     title      
--	     content
--	     regdate	-- date
--	     cnt		-- view count 
--	     id      
--	     
--	
--	회원등록
--	회원정보수정
--	로그인
--	
--	게시판 글등록
--	글수정
--	게시판 글 삭제
--	
--	데이터검색(Query)
--	전체 등록글 수
--	사용자별 등록글수 
--	월별개시글수
--	사용자별 게시글 검색
--	제목으로 게시글 검색

-- SCOTT/TIGER

drop table BOARD;
drop table USERS;

create table USERS(
	user_no number(5) 		CONSTRAINT PK_USERS PRIMARY KEY,
	user_id varchar2(20) 	UNIQUE,
	user_pw varchar2(20),
	name  varchar2(12),
	role 	number(2) 		default 0	-- 1 : admin  / 0 : general user
);

create table BOARD(
	seq 	number(7) PRIMARY KEY,
	user_no number(7) 	CONSTRAINT FK_USER_NO REFERENCES USERS,
	title 	varchar(20),
	content varchar(1000),
	regdate date 		default sysdate,
	cnt 	number(5) 	default 0 	check(cnt>=0)
);
----------------------------
drop SEQUENCE USER_NO_SEQ;
drop SEQUENCE BOARD_NO_SEQ;

CREATE SEQUENCE USER_NO_SEQ
	START WITH 1 
	INCREMENT BY 1 
	MAXVALUE 10000;

CREATE SEQUENCE BOARD_NO_SEQ
	START WITH 1 
	INCREMENT BY 1 
	MAXVALUE 1000000;
----------------------------


------------------------------------------------------------
--	회원등록
------------------------------------------------------------
-- admin
insert into USERS (user_no, user_id, user_pw, name, role)
	values(USER_NO_SEQ.nextval, 'admin', 'admin', '관리자', 1);
-- general user
insert into USERS (user_no, user_id, user_pw, name)
	values(USER_NO_SEQ.nextval, 'user01', '1234', 'user01');

	
------------------------------------------------------------
--	회원정보수정
------------------------------------------------------------
-- USER_NO
-- after Login** (get USER_NO)
-- Edit pw format
update USERS set user_pw = 'NEW_PW' where user_no = 'USER_NO' and user_pw = 'NOW_USER_PW';
-- ex
update USERS set user_pw = 'q1234' where user_no = '2' and user_pw = '1234';


------------------------------------------------------------
--	로그인
------------------------------------------------------------
-- Login format
select user_no from USERS u where u.user_id = 'USER_ID' and u.user_pw = 'USER_PW';
-- ex
select user_no from USERS u where u.user_id = 'admin' and u.user_pw = 'admin';



------------------------------------------------------------
------------------------------------------------------------
--	게시판 글등록
------------------------------------------------------------
-- detail
insert into BOARD (seq, user_no, title, content, regdate, cnt)
	values(BOARD_NO_SEQ.nextval, USER_NO_FROM_SECCION, 'board01', 'aaaaaaa', sysdate, 0);
-- simple by default
insert into BOARD (seq, user_no, title, content)
	values(BOARD_NO_SEQ.nextval, 2, 'board01', 'aaaaaaa');


------------------------------------------------------------
--	글수정
------------------------------------------------------------
-- after Login** (get USER_NO)
-- Edit title
update BOARD set title = 'NEW_TITLE' where seq = 'SEQ' and user_no = 'USER_NO_FROM_SECCION';
-- ex
update BOARD set title = 'Edit Title' where seq = '2' and user_no = '2';

-- Edit content	 (update regdate also)
update BOARD set content = 'NEW_CONTENT', regdate = sysdate where seq = 'SEQ' and user_no = 'USER_NO_FROM_SECCION';
-- ex
update BOARD set content = 'Changed Content', regdate = sysdate where seq = '2' and user_no = '2';


-- Edit cnt	(view count ++)
update BOARD set CNT = cnt+1 where seq = 'SEQ';
-- ex)
update BOARD set CNT = cnt+1 where seq = '2';


------------------------------------------------------------
--	게시판 글 삭제
------------------------------------------------------------
delete from BOARD where seq = 'SEQ' and user_no = 'USER_NO_FROM_SECCION';
-- ex)
delete from BOARD where seq = '1' and user_no = '2';




------------------------------------------------------------
--	데이터검색(Query)
------------------------------------------------------------
-- in Java : 'Search_Keyword' -> '%Search_keyword%'
-- title search
select *
from BOARD
where title like '%Search_keyword%';

-- content search
select *
from BOARD
where content like '%Search_keyword%';

-- both search
select *
from BOARD
where lower(title) like lower('%Search_keyword%')
or lower(content) like lower('%Search_keyword%');

-- ex)
select *
from BOARD
where lower(title) like lower('%content%')
or lower(content) like lower('%content%');


------------------------------------------------------------
create table BOARD(
	seq 	number(7) PRIMARY KEY,
	user_no number(7) 	CONSTRAINT FK_USER_NO REFERENCES USERS,
	title 	varchar(20),
	content varchar(1000),
	regdate date 		default sysdate,
	cnt 	number(5) 	default 0 	check(cnt>=0)
);
------------------------------------------------------------
--	전체 등록글 수
------------------------------------------------------------
select count(seq) from BOARD;

------------------------------------------------------------
--	사용자별 등록글수 
------------------------------------------------------------
select user_no, count(seq) from BOARD group by user_no;

------------------------------------------------------------
--	월별개시글수
------------------------------------------------------------
select to_char(regdate, 'mm') as "월", count(to_char(regdate, 'mm')) as "게시글수"
from BOARD
group by to_char(regdate, 'mm') 
order by "월";

------------------------------------------------------------
--	사용자별 게시글 검색
------------------------------------------------------------
select user_no, count(user_no) as "게시글수"
from BOARD
group by user_no
order by user_no;


------------------------------------------------------------
--	제목으로 게시글 검색
------------------------------------------------------------
-- content search
select *
from BOARD
where content like '%Search_keyword%';




--===============================================================================

drop table BOARD;
drop table USERS;

create table USERS(
	user_no number(5) 		CONSTRAINT PK_USERS PRIMARY KEY,
	user_id varchar2(20) 	UNIQUE,
	user_pw varchar2(20),
	name  varchar2(12),
	role 	number(2) 		default 0	-- 1 : admin  / 0 : general user
);

create table BOARD(
	seq 	number(7) PRIMARY KEY,
	user_no number(7) 	CONSTRAINT FK_USER_NO REFERENCES USERS,
	title 	varchar(20),
	content varchar(1000),
	regdate date 		default sysdate,
	cnt 	number(5) 	default 0 	check(cnt>=0)
);


----------------------------
drop SEQUENCE USER_NO_SEQ;
drop SEQUENCE BOARD_NO_SEQ;

CREATE SEQUENCE USER_NO_SEQ
	START WITH 1 
	INCREMENT BY 1 
	MAXVALUE 10000;

CREATE SEQUENCE BOARD_NO_SEQ
	START WITH 1 
	INCREMENT BY 1 
	MAXVALUE 1000000;


----------------------------
insert into USERS (user_no, user_id, user_pw, name, role)
	values(USER_NO_SEQ.nextval, 'admin', 'admin', '관리자', 1);
insert into USERS (user_no, user_id, user_pw, name)
	values(USER_NO_SEQ.nextval, 'user01', '1234', 'user01');


----------------------------
insert into BOARD (seq, user_no, title, content)
	values(BOARD_NO_SEQ.nextval, 2, 'board01', 'aaaaaaa');
insert into BOARD (seq, user_no, title, content)
	values(BOARD_NO_SEQ.nextval, 1, 'Notic01', 'aaaaaaa');
insert into BOARD (seq, user_no, title, content)
	values(BOARD_NO_SEQ.nextval, 1, 'Notic02', 'aaaaaaa');


----------------------------
update BOARD set title = 'Edit Title' where seq = '2' and user_no = '2';
update BOARD set content = 'Changed Content', regdate = sysdate where seq = '2' and user_no = '2';
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
