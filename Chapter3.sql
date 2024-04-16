--3. 다중 테이블 작업
--3.1 행 집합을 다른 행 위에 추가하기
select ename as ename_and_dname, deptno
  from emp
 where deptno = 10
union all
select '__________', null
  from t1
union all
select dname, deptno
  from dept;
  
--3.2 연관된 여러 행 결합하기
select emp.ename, dept.loc
  from emp, dept
 where emp.deptno = dept.deptno
   and emp.deptno = 10;
   
--3.3 두 테이블의 공통 행 찾기
create or replace view V
as
select ename, job, sal
  from emp
 where job = 'CLERK';

select * from V;


select emp.empno, emp.ename, emp.job, emp.sal, emp.deptno
  from emp, V
 where emp.ename = V.ename
   and emp.job = V.job
   and emp.sal = V.sal;
   
select empno, ename, job, sal, deptno
  from emp
 where (ename, job, sal) in (
  select ename, job, sal from emp
intersect
  select ename, job, sal from V
 );
 
 --3.4 한 테이블에서 다른 테이블에 존재하지 않는 값 검색하기
 select deptno from dept
 minus
 select deptno from emp;

 select deptno from dept
 except
 select deptno from emp;

--3.5 다른 테이블 행과 일치하지 않는 행 검색하
 select d.deptno, d.dname, d.loc
   from emp e, dept d
  where e.deptno(+) = d.deptno
    and e.deptno is null;기

--3.5 다른 조인을 방해하지 않고 쿼리에 조인 추가하

CREATE TABLE EMP_BONUS
(
EMPNO NUMBER ,
RECEIVED DATE ,
TYPE NUMBER); 

INSERT INTO EMP_BONUS VALUES (7369, TO_DATE('20050314', 'YYYYMMDD'), 1);
INSERT INTO EMP_BONUS VALUES (7900, TO_DATE('20050314', 'YYYYMMDD'), 2);
INSERT INTO EMP_BONUS VALUES (7788, TO_DATE('20050314', 'YYYYMMDD'), 3);

select e.ename, d.loc, b.received
  from emp e, dept d, emp_bonus b
 where e.deptno=d.deptno
   and e.empno=b.empno(+)
 order by 2;
 
 --3.7 두 테이블에 같은 데이터가 있는지 확인하기
drop view V;
create view V
as
select * from emp where deptno != 10
 union all
select * from emp where ename = 'WARD';

(select empno, ename, job, mgr, hiredate, sal, comm, deptno, count(*) cnt
  from V
 group by empno, ename, job, mgr, hiredate, sal, comm, deptno
minus
select empno, ename, job, mgr, hiredate, sal, comm, deptno, count(*) cnt
  from emp
 group by empno, ename, job, mgr, hiredate, sal, comm, deptno)
union all
(select empno, ename, job, mgr, hiredate, sal, comm, deptno, count(*) cnt
  from emp
 group by empno, ename, job, mgr, hiredate, sal, comm, deptno
minus
select empno, ename, job, mgr, hiredate, sal, comm, deptno, count(*) cnt
  from V
 group by empno, ename, job, mgr, hiredate, sal, comm, deptno);

--3.8 데카르트 곱 식별 및 방지하기
select e.ename, d.locß
 from emp e, dept d
 where e.deptno = 10
   and e.deptno = d.deptno;

--3.9 집계를 사용할 때 조인 수행하기
select * from emp_bonus;

select deptno2, sum(sal) as total_sal, sum(bonus) as total_bonus
from (
select e.empno, e.ename, e.sal, e.deptno, eb.type, 10 deptno2,
       e.sal * case when eb.type = 1 then .1
                    when eb.type = 2 then .2
                    else .3
                end as bonus
  from emp e, emp_bonus eb
 where e.empno = eb.empno)
group by deptno2;

select e.empno, e.ename, e.sal, e.deptno, eb.type, 10 deptno2,
       e.sal * case when eb.type = 1 then .1
                    when eb.type = 2 then .2
                    else .3
                end as bonus
  from emp e, emp_bonus eb
 where e.empno = eb.empno;

--3.10 집계시 외부 조인 수행하기

--3.11 여러 테이블에서 누락된 데이터 반환하기
select d.deptno, d.dname, e.ename
  from dept d left outer join emp e
    on (d.deptno=e.deptno);
    
--3.12 연산 및 비교에서 null 사용하기
select ename, comm, coalesce(comm, 0)
  from emp
 where coalesce(comm, 0) < (select comm
                            from emp
                           where ename = 'WARD');

