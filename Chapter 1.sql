-- SQL Cookbook 
-- 1.1 
select * from pl_player_summary_2223;

-- 1.2
select * 
from pl_player_summary_2223
where "Mins" > 1000;
-- 오라클에서 ""를 통해 지정된 컬럼명은 대소문자 구분

-- 1.3
select *
from pl_player_summary_2223
where to_char(team_name) = 'Liverpool'
and "Mins" > 1000;
-- clob 형태는 가변 길이 타입이라서 char 형태와 직접 비교연산 불가

-- 1.4
select player_name, team_name, "Rating"
from pl_player_summary_2223;

-- 1.5 
select player_name player, team_name team, "Rating" rating
from pl_player_summary_2223;

-- 1.6
-- * 쿼리 처리 순서 FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
SELECT *
FROM   (
SELECT PLAYER_NAME PLAYER, "Rating" RATING
FROM PL_PLAYER_SUMMARY_2223
)
WHERE RATING > 7;

-- 1.7
-- 작은 따옴표 사용시 '' 두 번 사용
select player_name || '''s rating is ' || "Rating"
from pl_player_summary_2223
order by "Rating" desc;

-- 1.8
select player_name,
       "Rating",
       case when "Rating" <= 6.5 then 'normal'
            when "Rating" >= 7.5 then 'world class'
            else 'top class'
       end as class
from pl_player_summary_2223;

-- 1.9
-- mySQL, postgreSQL 
/*
select *
from emp limit 5
*/
-- SQL Server
/*
select top5 *
from emp 
*/
-- oracle
select *
from pl_player_summayr_2223
where rownum <= 5;

-- 1.10 
-- mysql
/*
select *
from pl_player_summary_2223
order by rand() limit 5
*/
-- postgreSQL 
/* 
select *
from pl_player_summary_2223
order by random() limit 5
*/
-- Oracle
select *
from (
select *
from pl_player_summary_2223
order by dbms_random.value()
)
where rownum <= 5;

-- 1.11
select *
from pl_player_summary_2223
where "AerialsWon" is null;

-- 1.12
select coalesce("AerialsWon", 0)
from pl_player_summary_2223;

-- 1.13
-- sql and 연산자는 or 연산자 보다 우선 순위가 높다.
select *
from pl_player_summary_2223
where upper(team_name) like '%MAN%';









