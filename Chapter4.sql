--4.1 새로운 레코드 삽입하기
insert into dept (deptno, dname, loc)
select 1, 'A', 'B' from dual
union all
select 2, 'B', 'C' from dual;

rollback;

--4.2 기본값 삽입하기
create table D(id integer default 0);
insert into D values (default);
commit;
select * from D;

drop table D;
create table D (id integer default 0, foo varchar(10));

insert into D (foo) values ('Bar');
select * from D;
drop table D;

--4.3 null로 기본 값 오버라이딩하기
create table D (id integer default 0, foo varchar(10));
insert into D (id, foo) values (null, 'Brighten');
insert into D (foo) values ('Brighten');
select * from D;
drop table D;

--4.4 한 테이블에서 다른 테이블로 행 복사하기
create table dept_east 
as select * from dept where 1=2;

insert into dept_east (deptno, dname, loc)
select deptno, dname, loc
  from dept
 where loc in ('NEW YORK', 'BOSTON');
rollback; 

insert into dept_east
select * from dept
 where loc in ('NEW YORK', 'BOSTON');
 
select * from dept_east;

--4.5 테이블 정의 복사하기
create table dept_east 
as select * from dept where 1=2;
create table dept_mid
as select * from dept where 1=2;
create table dept_west
as select * from dept where 1=2;


--4.6 한 번에 여러 테이블에 삽입하기
insert all
  when loc in ('NEW YORK', 'BOSTON') then
  into dept_east (deptno, dname, loc) values (deptno, dname, loc)
  when loc = 'CHICAGO' then
    into dept_mid (deptno, dname, loc) values (deptno, dname, loc)
  else
    into dept_west (deptno, dname, loc) values (deptno, dname, loc)
  select deptno, dname, loc
    from dept;
    
--4.7 특정 열에 대한 삽입 차단하기.

create table emp_backup as select * from emp;
create table dept_backup as select * from dept;

create view new_emps as select empno, ename, job
  from emp;

insert into new_emps (empno, ename, job)
  values (1, 'Jonathan', 'Editor');
  
select * from emp;
select * from new_emps;

drop table emp;
create table emp as select * from emp_backup; 

--4.8 테이블에서 레코드 수정하기

update emp
   set sal = sal*1.10
 where deptno = 20;
 
rollback;

select * from emp
minus 
select * from emp_backup;

--4.9 일치하는 행이 있을 때 없데이트하기
update emp
   set sal=sal*1.20
 where empno in (select empno from emp_bonus);

rollback;

--4.10 다른 테이블 값으로 업데이트하기
create table new_sal
as select 10 deptno, 4000 sal from dual;

update (
select e.sal emp_sal, e.comm emp_comm, 
       ns.sal as ns_sal, ns.sal/2 as ns_comm
  from emp e, new_sal ns
 where e.deptno = ns.deptno )
   set emp_sal = ns_sal, emp_comm = ns_comm;

commit;

drop table emp;
create table emp as select * from emp_backup; 

--4.11 레코드 병합하기
create table emp_commission
as select deptno, empno, ename, comm from emp where deptno = 10;

merge into emp_commission ec
using (select * from emp) emp
   on (ec.empno=emp.empno)
 when matched then
      update set ec.comm = 1000
      delete where (sal < 2000)
 when not matched then
      insert (ec.empno, ec.ename, ec.deptno, ec.comm)
      values (emp.empno, emp.ename, emp.deptno, emp.comm);

select * from emp_commission;

--4.13 특정 레코드 삭제하기
delete from emp where deptno = 10;
rollback;

--4.14 단일 레코드 삭제하기
delete from emp where empno = 7782;

--4.15 참조 무결성 위반 삭제하기
delete from emp
 where not exists (
   select * from dept
    where dept.deptno = emp.deptno
);

delete from emp
where deptno not in (select deptno from dept);
    
--4.16 중복 레코드 삭제하기
create table dupes (id integer, name varchar(10));

insert into dupes values (1, 'NAPOLEON');
insert into dupes values (2, 'DYNAMITE');
insert into dupes values (3, 'DYNAMITE');
insert into dupes values (4, 'SHE SELLS');
insert into dupes values (5, 'SEA SHELLS');
insert into dupes values (6, 'SEA SHELLS');
insert into dupes values (7, 'SEA SHELLS');

select * from dupes order by 1;

delete from dupes
 where id not in (select min(id)
                    from dupes
                   group by name );

--4.17 다른 테이블에서 참조된 레코드 삭제하기
