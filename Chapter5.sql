--5장 메타 데이터 쿼리

--5.1 스키마의 테이블 목록 보기
select table_name, owner
  from all_tables;
  
--5.2 테이블의 열 나열하기
select column_name, data_type, column_id, owner
  from all_tab_columns
 where owner = 'EMP'
   and table_name = 'EMP';
   
--5.3 테이블의 인덱싱 된 열 나열하기
select table_name, index_name, column_name, column_position
  from sys.all_ind_columns
 where  table_owner = 'EMP';
 
--5.4 테이블의 제약조건 나열하기
select a.table_name, 
       a.constraint_name,
       b.column_name,
       a.constraint_type
  from all_constraints a,
       all_cons_columns b
 where a.table_name = 'EMP'
   and a.owner = 'EMP'
   and a.table_name = b.table_name
   and a.owner = b.owner
   and a.constraint_name = b.constraint_name;
   
--5.5 관련 인덱스가 없는 외래 키 나열하기
select a.table_name,
       a.constraint_name,
       a.column_name,
       c.index_name
  from all_cons_columns a,
       all_constraints b,
       all_ind_columns c
 where a.table_name = 'EMP'
   and a.owner = 'EMP'
   and b.constraint_type = 'R'
   and a.owner = b.owner
   and a.table_name = b.table_name
   and a.constraint_name = a.constraint_name
   and a.owner = c.table_owner (+)
   and a.table_name = c.table_name (+)
   and a.column_name = c.column_name (+)
   and c.index_name is null;
   
--5.6 SQL로 SQL 생성하기
select 'select count(*) from ' ||table_name||';' cnts from user_tables;

--5.7 Oracle에서 데이터 딕셔너리 뷰 확인하기
select table_name, comments
  from dictionary
 order by table_name;
   