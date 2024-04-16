-- SQL Cookbook 
-- 1.1 테이블의 모든 행과 열 검색하기
select * from emp;

-- 1.2 테이블에서 행의 하위 집합 검색하기
select * 
from emp
where deptno = 10;
-- 오라클에서 ""를 통해 지정된 컬럼명은 대소문자 구분

-- 1.3 여러조건을 충족하는 행 찾기
select *
 from emp
where deptno = 10
   or comm is not null
   or (sal <= 2000 and deptno = 20);

-- 1.4 테이블에서 열의 하위 집합 검색하기
select ename, deptno, sal
  from emp;
  
-- 1.5 열에 의미있는 이름 지정하기
select sal as salary, comm as commision
  from emp;
  
-- 1.6 Where 절에서 별칭이 지정된 열 참조하기
select *
from (
select sal as salary, comm as commision
  from emp) x
where salary < 5000;

-- 1.7 열 값 이어 붙이기
-- 작은 따옴표 사용시 '' 두 번 사용
select ename || ' WORK AS A ' || job
from emp
where deptno = 10;

-- 1.8 SELECT 문에서 조건식 사용하기
-- else 사용하지 않으면 null 값 반환
select ename,
       sal,
       case when sal <= 2000 then 'UNDERPAID'
            when sal >= 4000 then 'OVERPAID'
            else 'OK'
        end as status
  from emp;
  
-- 1.9 반환되는 행 수 제한하기
select * 
  from emp
 where rownum < 5;
 
-- 1.10 테이블에서 n개의 무작위 레코드 반환하기
select *
  from (
select ename, job
  from emp
 order by dbms_random.value()
       )
 where rownum <=5;
 
-- 1.11 null 값 찾기
select * 
  from emp
 where comm is null;
 
-- 1.12 null 을 실젯값으로 변환하기
select coalesce(comm, 0)
  from emp;
  
-- 1.13 패턴 검색하기
select ename, job
  from emp
 where deptno in (10, 20)
   and (ename like '%I%' or job like '%ER');
  








