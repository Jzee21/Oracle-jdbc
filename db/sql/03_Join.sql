/***	join	***/
----------------------------------------------
/*	Oracle Join								*/
----------------------------------------------
select * from dept;
select * from emp;

select ename, dname, loc
from emp, dept
where emp.deptno = dept.deptno;

select *
from emp, dept
where emp.deptno = dept.deptno;

-- table alliance
select ename, d.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

-- sal>=2000, deptno=20 -> ename, sal, loc
select ename, sal, loc
from emp e, dept d
where e.deptno = d.deptno and sal >= 2000 and e.deptno=20;



----------------------------------------------------------------------
/*	Ansi Join	// reference	:	join (from's ,), on (where) 	*/
----------------------------------------------------------------------

-- *** Inner Join ***
-- from
select ename, sal, loc
from emp e, dept d
where e.deptno = d.deptno ;
-- to
select ename, sal, loc
from emp e join dept d		-- join	**
on e.deptno = d.deptno;		-- on	**
/*
from emp e inner join dept d
*/

-- ex]
select ename, sal, loc
from emp e join dept d
on e.deptno = d.deptno 
where sal >= 2000 and e.deptno=20;


-- *** Outer Join ***
-- from
select ename, d.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno ;
-- to
select ename, d.deptno, dname, loc
from emp e join dept d
on e.deptno(+) = d.deptno;
-- at null table ^ , making '+'

select ename, d.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;

-- from	: right table : master
select ename, d.deptno, dname, loc
from emp e right outer join dept d
on e.deptno = d.deptno;



------------------------------------------------------
/*	non equi Join									*/
------------------------------------------------------

select * from SALGRADE;

-- oracle join
select ename, sal, grade
from emp, SALGRADE
where sal between losal and hisal;


-- ansi join
select ename, sal, grade
from emp join SALGRADE
on sal between losal and hisal;



----------------------------------------------------------
/*	n table Join										*/
----------------------------------------------------------
/* ename, sal, dname, grade */
-- oracle
select ename, sal, d.dname, grade
from EMP e , DEPT d , SALGRADE s
where e.deptno=d.deptno and sal between losal and hisal;
-- ansi
select ename, sal, d.dname, grade
from EMP e
	join DEPT d on e.deptno=d.deptno
	join SALGRADE s on sal between losal and hisal

/* upper add sal>1500 */
select ename, sal, d.dname, grade
from EMP e
	join DEPT d on e.deptno=d.deptno
	join SALGRADE s on sal between losal and hisal
where sal>1500;



----------------------------------------------------------
/*	self Join											*/
----------------------------------------------------------
select e1.ename, nvl(e2.ename, 'master') as mgr
from EMP e1	, EMP e2
where e1.mgr = e2.empno(+);

select e1.ename, nvl(e2.ename, 'master') as mgr
from EMP e1	left join EMP e2
on e1.mgr = e2.empno;

-- add
select e1.ename, e1.sal, nvl(e2.ename, 'master') as mgr, e2.sal
from EMP e1	, EMP e2
where e1.mgr = e2.empno(+) and e1.sal > e2.sal;

select e1.ename, e1.sal, nvl(e2.ename, 'master') as mgr, e2.sal
from EMP e1	join EMP e2
on e1.mgr = e2.empno(+)
where e1.sal > e2.sal;
----
select e1.ename, e1.hiredate, nvl(e2.ename, 'master') as mgr, e2.hiredate
from EMP e1	, EMP e2
where e1.mgr = e2.empno(+) and e1.hiredate < e2.hiredate;
--
select e1.ename, e1.hiredate, nvl(e2.ename, 'master') as mgr, e2.hiredate
from EMP e1	join EMP e2
on e1.mgr = e2.empno(+) 
where e1.hiredate < e2.hiredate;



----------------------------------------------------------
/*	count func											*/
----------------------------------------------------------
select ename, round(sal) from emp;

select ename, avg(sal) from emp;
-- ERROR : single-group group function

select round(avg(sal), 2)||' 원' as total_sal_avg from emp;

-- select에 참여 가능한 collem은 group by로 묶인 항목 뿐.
select deptno, round(avg(sal)) from emp group by deptno;


-- 12/26
select avg(sal), count(*), min(sal), max(sal), count(mgr)
from emp
where deptno=20;
--												except null


select dname, avg(sal), count(*), min(sal), max(sal), count(mgr)
from emp e
	right join dept d on e.deptno = d.deptno
group by dname;
--
select d.deptno, dname, avg(sal), count(*), min(sal), max(sal), count(mgr)
from emp e
	right join dept d on e.deptno = d.deptno
group by d.deptno, dname
order by d.deptno;


----------
/*	순서	*/
----------
select
from
where
group by
having
order by

--
select e.deptno, dname, round(avg(sal)) as 평균급여
from emp e, dept d
where e.deptno = d.deptno		-- each sal > num
group by  e.deptno, dname
having round(avg(sal))>2000;	-- avg_sal > num



----------------------------------------------------------
/*	subQuery											*/
----------------------------------------------------------
-- query A
select sal from emp where ename='FORD';		-- 3000
-- query B
select * from emp where sal>3000;			-- FORD's sal, 3000

-- query B has A
select * from emp where sal > (select sal from emp where ename='FORD');


-- employees who under avg sal
select * from emp where sal < (select avg(sal) from emp);
select ename, sal, (select avg(sal) from emp) from emp where sal < (select avg(sal) from emp);


select * from emp where sal = (select min(sal) from emp);


-- employees who max sal in each dept
select *
from emp
where sal in (select max(sal) from emp group by deptno);
	--	  =   error : single-row subquery returns more than one row
	--    in  returns multiple row
select *
from emp
where (deptno, sal) in (select deptno, max(sal) from emp group by deptno)
order by deptno;
	 -- recommend like this. more clearly.



----------------------------------------------------------
/*	rownum												*/
/*		- subQuery_where								*/
----------------------------------------------------------
select rownum, ename, job, sal
from emp;

-- add order by
select rownum, ename, job, sal
from emp
order by sal;

select rownum, ename, job, sal
from (select *
		from emp
		order by sal);

-- high sal employee
select rownum, ename, job, sal
from (select *
		from emp
		order by sal desc)
where rownum < 4;

select rownum, ename, job, sal
from (select *
		from emp
		order by sal desc)
where rownum between 1 and 4;



----------------------------------------------------------
/*	oracle paging										*/
----------------------------------------------------------
select rownum, ename, job, sal
from (select *
		from emp
		order by sal desc)
where rownum between 5 and 10;
-- Error : no rows selected

select *
from (select rownum row#, ename, job, sal
	  from (select * from emp order by sal desc) )
where row# between 1 and 5;

select *
from (select rownum row#, ename, job, sal
	  from (select * from emp order by sal desc) )
where row# between 6 and 10;


