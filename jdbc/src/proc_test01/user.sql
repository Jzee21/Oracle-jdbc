---------------------------------------------------------------
--	테이블 생성문
---------------------------------------------------------------
drop table USERS;

create table USERS(
	user_no number(5) 		CONSTRAINT PK_USERS PRIMARY KEY,
	user_id varchar2(20) 	UNIQUE,
	user_pw varchar2(20),
	name  varchar2(12),
	role 	number(2) 		default 0
);


---------------------------------------------------------------
--	회원 등록 sql 구문
---------------------------------------------------------------
-- admin
insert into USERS (user_no, user_id, user_pw, name, role)
	values((select nvl(max(user_no), 0)+1 from USERS), 'admin', 'admin', '관리자', 1);
	
-- general user
insert into USERS (user_no, user_id, user_pw, name)
	values((select nvl(max(user_no), 0)+1 from USERS), 'user01', '1234', 'user01');


---------------------------------------------------------------
--	로그인 sql 구문
---------------------------------------------------------------
select user_no from USERS u 
where u.user_id = 'admin' and u.user_pw = 'admin';

