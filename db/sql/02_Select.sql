
conn SCOTT/TIGER
/* conn SCOTT */

select * from emp;
select * from dept;
select * from salgrade;

desc emp;		/*	view data type	*/

select ename, sal, deptno
from emp;

select ename, hiredate
from emp;

select distinct job		/*	skip duplicated value	*/
from emp;

						  -- alliance
select ename, sal, sal*12 as year_sal
from emp;

select ename, job, sal, comm
from emp;

select ename, job, sal, sal+comm as "실급여"
from emp;

/*	if null, convert 0 or others	*/		/*	comm = null -> -1	*/
select ename, job, sal, sal+comm as "실급여", nvl(comm, -1)
from emp;

select ename, job, sal, comm, sal+nvl(comm, 0) as 실급여
from emp;

select empno, ename, mgr
from emp;

					 -- num to char
select empno, ename, nvl(to_char(mgr), '<<CEO>>') as 실급여
from emp;

/*	String conn commend ||	*/
select job||'  '||ename as job_name
from emp;

select 20*20*4
from dual;			-- virtual table : dual

select sysdate		-- to date : sysdate
from dual;

select user			-- to user info : user
from dual;

-- where : limit in row
select ename, job, deptno
from emp
where deptno=10;

select ename, job, deptno
from emp
where job=UPPER('manager');

select ename, job, deptno
from emp
where LOWER(job)=LOWER('manager');

select sysdate
from dual;

select ename, to_char(hiredate, 'yyyy-mm-dd') as hiredate
from emp
where hiredate > '82/01/01';

select ename, to_char(hiredate, 'yyyy-mm-dd') as hiredate
from emp
where hiredate != '81/05/01';

select ename, to_char(hiredate, 'yyyy-mm-dd') as hiredate
from emp
where hiredate <> '81/05/01';	-- [ '!='  ==  '<>' ]



-- between and
select ename, sal
from emp
where 3000 >= sal and sal >= 2450;

select ename, sal
from emp
where sal between 2450 and 3000;
		  -- ! lower num must come front ! --

-- in or
select ename, job, deptno
from emp
where deptno=10 or deptno=20;

select ename, job, deptno
from emp
where deptno in(10, 20);

select dname, loc
from dept
where (deptno, loc) in((20, 'DALLAS'), (30, 'CHICAGO'));
	--      and			  and		 or	   and

-- like
select *
from emp
where ename = 'A'

select *
from emp
where ename like 'A%';	-- name 'A~'

select *
from emp
where ename like '%E';

select *
from emp
where ename like '%A%';

select *
from emp
where upper(ename) like upper('%A%');

--
select *
from emp
where ename like '%A__';	-- name '~~~A??'

-- 81
select *
from emp
where hiredate between '80/01/01' and '80/12/31';

select *
from emp
where hiredate like '80%';

-- where null
select *
from emp
where mgr is null;
		-- =  for null?

select *
from emp
where mgr is not null;

--
select ename, sal, comm, sal+nvl(comm, 0) as "총급여"
from emp
where "총급여" >= 2000;		-- error, allianced value can't use

select ename, sal, comm, sal+nvl(comm, 0) as "총급여"
from emp
where sal+nvl(comm, 0) >= 2000;

---------
-- sort
select ename, sal, comm, sal+nvl(comm, 0) as "총급여"
from emp
order by sal+nvl(comm, 0);

select ename, sal, comm, sal+nvl(comm, 0) as "총급여"
from emp
order by sal+nvl(comm, 0) desc;	-- sort reverse?	big->small

select ename, sal, comm, sal+nvl(comm, 0) as "총급여"
from emp
order by sal+nvl(comm, 0) asc;	-- asc is default	small->big

select ename, sal, comm, sal+nvl(comm, 0) as "총급여"
from emp
order by sal asc, comm desc;

select ename, sal, sal+nvl(comm, 0) as "총급여"
from emp
order by sal asc, comm desc;

select ename, sal, sal+nvl(comm, 0) as "총급여"
from emp
where comm is not null
order by sal asc, comm desc;

-- in order, can use allianced val
select ename, sal, sal+nvl(comm, 0) as "총급여"
from emp
where sal+nvl(comm, 0) >= 2000
order by "총급여";

select ename, sal, sal+nvl(comm, 0) as "총급여"
from emp
where sal+nvl(comm, 0) >= 2000
order by 3;		-- index 3 : "총급여"


---------------------------------
-- single row function	(단일행함수)
select dname, lower(dname), loc, lower(loc)
from dept;

select round(44.55), round(44.55, 1), trunc(44.55) from dual;
--			 45			   44.6				44

select sal, sal*0.03 as "Tex"	from emp;

select sal, trunc(sal*0.03) as "Tex"	from emp;

select ename, hiredate, substr(hiredate, 4, 2) as hire_monte	from emp;
						--		index 4~ , 2 space

select ename, hiredate, substr(hiredate, 4, 2) as hire_monte	from emp
where substr(hiredate, 4, 2) = 12;


--
select sysdate, substr(sysdate, 4, 2) from dual;
select sysdate, to_char(sysdate, 'yy') from dual;
select sysdate, to_char(sysdate, 'yyyy') from dual;
select sysdate, to_char(sysdate, 'day') from dual;
select sysdate, to_char(sysdate, 'mm') from dual;
select sysdate, to_char(sysdate, 'dd') from dual;

-- emp, get name, hire_month, week?
select ename, to_char(hiredate, 'mm') as hire_month, to_char(sysdate, 'day') as hire_day
from emp
order by hire_month;

select sysdate, to_date('19/12/24') from dual;
select sysdate, to_date('19-12-24') from dual;
select sysdate, to_date('19 12 24') from dual;
select sysdate, to_date('2019/12/24') from dual;
select sysdate, to_date('12/24/19', 'mm/dd/yy') from dual;


-- decode func
select ename, sal, deptno, decode(deptno, 10, sal*1.2, 20, sal*0.7, sal) as bonus
from emp
order by deptno;

-- end of single row func
-------------------------
