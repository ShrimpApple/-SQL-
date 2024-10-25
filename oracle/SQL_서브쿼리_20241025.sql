select salary
from employees
where last_name = 'De Haan';

select *
from employees A
where A.salary = 17000;

-- 단일행 서브쿼리
select *
from employees A
where A.salary = (select salary
                  from employees
                  where last_name = 'De Haan'
);

-- 다중행 서브쿼리
select salary
from employees
where last_name = 'Taylor';

select *
from employees A
where A.salary in (
            select salary
            from employees
            where last_name = 'Taylor'
);

select min(salary) 최저급여
from employees
group by department_id;

select *
from employees A
where A.salary IN(
select min(salary) 최저급여
from employees
group by department_id
)
order by a.salary desc;

-- 다중열 서브쿼리
select job_id, min(salary) 그룹별_급여
from employees
group by job_id;

select *
from employees A
where(A.job_id, A.salary) in(
select job_id, min(salary) 그룹별_급여
from employees
group by job_id
)
order by A.salary desc;

-- FROM절 서브쿼리 -> 인라인 뷰 == 가상뷰
select *
from employees A,(
        select department_id
        from departments
        where department_name = 'IT') B
where A.department_id = B.department_id;
---------------------------------------- select 끝
-- insert into
insert into departments(department_id, department_name, manager_id, location_id)
values(271, 'Sample_Dept', 200, 1700);

select * from departments;

insert into departments values(272, 'Sample_Dept', 200, 1700);

insert into departments(department_id, department_name) values(273, 'Sample_Dept');

-- update set
update departments
set manager_id = 201,
    location_id = 1800
where department_name = 'Sample_Dept';

select manager_id, location_id
from departments
where department_id = 40;

update departments
set (manager_id, location_id) = (
select manager_id, location_id
from departments
where department_id = 40
)

where department_name = 'Sample_Dept';

-- delete from
delete from departments where department_name = 'Sample_Dept';

delete from departments where department_id = 271;

commit;

ROLLBACK;


create table sample_product (
    product_id number PRIMARY key,
    product_name varchar2(30) not null,
    manu_date date not null
);

drop table sample_product;

select * from sample_product;
insert into sample_product values(1, 'television', to_date('241010', 'YYMMDD'));
insert into sample_product values(2, 'washer', to_date('241015', 'YYMMDD'));
insert into sample_product values(3, 'cleanner', to_date('241024', 'YYMMDD'));

-- 테이블 변경
alter table sample_product add(factory varchar(10));

-- 열 삭제
alter table sample_product drop column factory;

-- 열 변경
alter table sample_product modify (factory char(20));

-- 테이블의 내용만 삭제
delete from sample_product;

-- 테이블의 내용만 삭제
truncate table sample_product;

select * from sample_product;
rollback;
