--2 쿼리 결과 정렬
--2.1 
select *
from pl_player_summary_2223
order by "Mins" desc;
-- default 값은 오름차순
--2.2
select *
from pl_player_summary_2223
order by "Mins" desc, "Rating" desc;
-- 오름차순 내림차순은 컬럼마다 따로 지정
--2.3
select substr(to_char(player_name), 2, 2), player_name, team_name
from pl_player_summary_2223
order by substr(to_char(player_name), 2, 2);
-- substr(문자타입 컬럼명, 시작위치, 문자길이) 
--2.4
/* create view */
create view V
as 
    select to_char(player_name) ||' '|| "Rating" as data
    from pl_player_summary_2223;

select * from V;
/*rating으로 정렬하기*/ 
-- translate(바꿀 문자열, 바꿀문자(다중), 바뀔문자(다중-1대1대응)) (바꿀문자에 바뀔문자 없으면 제거)
-- replace(바꿀 문자열, 바꿀문자, 바뀔문자) 
select *
from V
order by replace(data, replace(translate(data, '01234567890.', '##########'), '#', ''), '') desc;
/*name으로 정렬*/
select *
from V
order by replace(translate(data, '01234567890.', '##########'), '#', '');

--2.5
select *
from  pl_player_summary_2223
order by "Rating" desc nulls first;

--2.6
select player_name, team_number, team_name, "Mins", "Rating"
from pl_player_summary_2223
order by case when "Rating" > 7 then team_number else "Rating" end;



