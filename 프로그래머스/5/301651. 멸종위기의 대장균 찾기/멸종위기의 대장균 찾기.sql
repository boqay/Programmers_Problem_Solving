with recursive family as (
    -- 1) 부모가 없는 최초 세대 구하기
    select id, parent_id, 1 as generation
    from ecoli_data
    where parent_id is null 

    union all 

    -- 2) 재귀적으로 세대 구하기
    select t1.id, t1.parent_id, t2.generation + 1
    from ecoli_data t1
    join family t2 on t1.parent_id = t2.id
)
-- 3) 최종 집계
select count(distinct t1.id) as COUNT, generation
-- t1.id, t1.generation, t2.id as chilren
from family t1
left join ecoli_data t2 on t1.id = t2.parent_id -- 각 세대의 자식 세대 구하기
where t2.id is null -- 자식이 없는 개체만 필터링
group by generation