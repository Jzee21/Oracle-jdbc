--
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script is automatically run
--

set linesize 300;
set pagesize 20;

col ename for a10;
col job for a12;
col deptno for 9999;
col sal for 9999;
col mgr for 9999;
col comm for 9999;