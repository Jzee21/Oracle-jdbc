
sqlplus system/1234

/*	unlock hr account	*/
alter user hr identified by hr account unlock;

conn hr/hr
sqlplus hr/hr

select * from tab;

******************
*   TABLESPACE   *
******************

create TABLESPACE mc
datafile 'C:\oraclexe\app\oracle\oradata\XE\mc.dbf'
size 10M
autoextend on next 1M maxsize UNLIMITED;

/*	Delete Tablespace	*/
drop TABLESPACE mc INCLUDING CONTENTS and datafiles;

**************************
*   Management Account   *
**************************

/*							  pw	*/
create user test01 identified by 1234
default TABLESPACE mc;

/*	set Authorization	*/
grant connect, resource, dba to test01;

/*	delete Authorization(권한)	*/
revoke dba from test01;
revoke connect from test01;

/*	delete user	*/
/*				 by compulsion(강제적으로)	*/
drop user test01 cascade;


***************************
*   SCOTT/TIGER Account   *
***************************
create user SCOTT identified by TIGER
default TABLESPACE mc;		/*	<-	if not set, using system area (system.dbf)	*/

select * from tab;

/*	@ : sql run	*/
@c:\lib\scott.sql;

select * from tab;

/*	Now, consol's setting	*/
/*	another consol's reset	*/
set linesize 300;
set pagesize 20;

select * from EMP;

/*	Edit : C:\oraclexe\app\oracle\product\11.2.0\server\sqlplus\admin\glogin.sql	*/
set linesize 300;
set pagesize 20;

col ename for a10;		/*	consol print size setting	*/
col job for a12;		/*	string, char	*/
col deptno for 9999;	/*	integer, number	*/
col sal for 9999;
col mgr for 9999;
col comm for 9999;












