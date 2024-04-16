--2 쿼리 결과 정렬
--2.1 지정한 순서대로 쿼리 결과 반환하기
select ename, job, sal
  from emp
 where deptno = 10
 order by sal;

--2.2 다중 필드로 정렬하기
select empno, deptno, sal, ename, job
  from emp
 order by deptno, sal desc;
 
--2.3 부분 문자열로 정렬하기
select ename, job, substr(job, length(job)-1)
  from emp
 order by substr(job, -2);
 
--2.4 혼합 영숫자 데이터 정렬하기
create view V
as
 select ename||' '||deptno as data
   from emp;

select * from V;

select data 
  from V
 order by replace(
          translate(data, ' 0123456789', '#'), '#', '');

select data
 from V
 order by replace(data,
          replace(
          translate(data, ' 0123456789', '#'), '#', ''), '');

--2.5 정렬할 때 null 처리하기
select ename, sal, comm
  from emp
 order by comm desc nulls last;
 
--2.6 데이터 종속 키 기준으로 정렬하기
select ename, sal, job, commßß
  from emp
 order by case when job = 'SALESMAN' then comm else sal end;
 

