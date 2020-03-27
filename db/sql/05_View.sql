-- 뷰란?
--   뷰는 하나의 가상 테이블이라 생각 하면 된다. 
--   뷰는 실제 데이터가 저장 되는 것은 아니지만 뷰를 통해 데이터를 관리 할수 있다. 
--   뷰는 복잡한 Query를 통해 얻을 수 있는 결과를 간단한 Query로 얻을 수 있게 한다. 
--   한 개의 뷰로 여러 테이블에 대한 데이터를 검색 할 수 있다. 
--   특정 평가 기준에 따른 사용자 별로 다른 데이터를 액세스할 수 있도록 한다. 

--  각 부서에서 최대 급여를 받는 사원의 목록 

select *
from emp e
where (deptno, sal) in (select deptno, max(sal) from emp group by deptno)
order by deptno;

-- View. read only? no. renewaled
create or replace view max_Dept as 
select *
from emp e
where (deptno, sal) in (select deptno, max(sal) from emp group by deptno)
order by deptno;

select * from max_dept;
select * from max_dept where deptno=10;


create or replace view page_emp as
select *
from (select rownum row#, ename, job, sal
	  from (select * from emp order by sal desc)
);

select * from page_emp;
select * from page_emp where row# between 6 and 10;


----------------------------------------------------
--	sequence
----------------------------------------------------
-- 시퀀스란?
--   유일(UNIQUE)한 값을 생성해주는 오라클 객체이다. 
--   시퀀스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로 생성 할 수 있다. 
--   보통 PRIMARY KEY 값을 생성하기 위해 사용 한다. 
--   메모리에 Cache되었을 때 시퀀스값의 액세스 효율이 증가 한다. 
--   시퀀스는 테이블과는 독립적으로 저장되고 생성된다.

select * from emp2;
select * from dept2;

delete * from emp2;
delete * from dept2;
delete * from book;

--CREATE SEQUENCE dept_seq
--	START WITH 1 
--	INCREMENT BY 1 
--	MAXVALUE 10000;

CREATE SEQUENCE dept_seq;		-- default : start with 1
drop SEQUENCE dept_seq;

insert into dept2 (deptno, dname, loc) values(dept_seq.nextval, 'EDU', 'SEOUL');
--											--'1'

insert into dept2 (deptno, dname, loc) values(dept_seq.nextval, 'EDU', 'SEOUL');
insert into dept2 (deptno, dname, loc) values(dept_seq.nextval, 'EDU', 'SEOUL');
insert into dept2 (deptno, dname, loc) values(dept_seq.nextval, 'EDU', 'SEOUL');

-- Current Sequence value
select dept_seq.currval from dual;
select dept_seq.nextval from dual;		-- ! nextval increse current val


CREATE SEQUENCE dept_seq				-- Only in Oracle**
START WITH 10
INCREMENT BY 10;						-- 10, 20, 30...


insert into dept2 (deptno, dname, loc)
values(  nvl( ( select max(deptno) from dept2 ), 0)+1, 'EDU', 'SEOUL');
values( (select nvl(max(deptno), 0)+1 from dept2  )   , 'EDU', 'SEOUL');

select nvl(max(deptno), 0)+1 from dept2;









