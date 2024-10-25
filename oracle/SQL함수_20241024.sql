-- 1. job_id가 IT_PROG라면 employee_id, first_name, last_name, salary를 출력하되
--  salary가 9000 이상이면 '상위급여', 6000과 8999사이이면 '중위급여'
--  그 외에는 '하위급여'라고 출력 CASE 문
select employee_id, first_name, last_name, salary,
    case
        when salary >= 9000 then '상위급여'
        when salary BETWEEN 6000 and 8999 then '중위급여'
        else '하위급여'
    end as 급여등급
from employees
where job_id = 'IT_PROG';

-- 순위 매기기 (3가지 종류 구분)
select employee_id, 
       salary, 
       RANK()       OVER(order by salary desc) Rank_급여,
       DENSE_RANK() OVER(order by salary desc) ENSE_Rank_급여,
       ROW_NUMBER() OVER(order by salary desc) ROW_NUMBER_급여
from employees;

-- 그룹함수
-- salary의 합계와 평균을 구하고 avg를 사용하지 말고 평균 출력
select sum(salary) 합계, avg(salary) 평균, sum(salary)/count(salary) 계산된_평균
from employees;

-- salary의 최대값과 최소값 그리고 first_name 의 최댓값, 최소값 출력
select max(salary) 최대값, min(salary) 최소값,
max(first_name) 최대문자, min(first_name) 최소문자
from employees;

-- 그룹화
--employee_id가 10 이상인 직원에 대해 job_id별로 그룹화 하여 
  -- job_id별 총 급여와 job_id별 평균 급여를 구함
  -- job_id별 총 급여를 기준으로 내림 차순 정렬
select job_id 직무, sum(salary) 직무별_총급여, avg(salary) 직무별_평균급여
from employees
where employee_id >= 10
group by job_id
order by 직무별_총급여 desc, 직무별_평균급여;

-- 그룹화(조건 - having)
-- employee_id가 10 이상인 직원에 대해 job_id별로 그룹화 하여 
  -- job_id별 총 급여와 job_id별 평균 급여를 구함
  -- job_id별 총 급여가 30000보다 큰 값만 출력
  -- 출력 결과는 job_id별 총 급여를 기준으로 내림차순
select job_id 직무, sum(salary) 직무별_총급여, avg(salary) 직무별_평균급여
from employees
where employee_id >= 10
group by job_id
having sum(salary) > 30000
order by 직무별_총급여 desc, 직무별_평균급여;


-- ***** 조인
-- 동등 조인
select a.employee_id, a.department_id, b.department_name, c.location_id, c.city
from employees A, departments B, locations C
where a.department_id = b.department_id
and b.location_id = c.location_id;

-- 외부조인
select a.employee_id, a.first_name, a.last_name, b.department_id, b.department_name
from employees A, departments B
where a.department_id = b.department_id(+)
order by a.employee_id;

select a.employee_id, a.first_name, a.last_name, b.department_id, b.department_name
from employees A, departments B
where a.department_id(+) = b.department_id
order by a.employee_id;

-- 자체조인
select a.employee_id, a.first_name, a.last_name, a.manager_id, (b.first_name||' '||b.last_name) manager_name
from employees A, employees B
where a.manager_id = b.employee_id
order by a.employee_id;

-- ** 집합연산자
-- 합집합 - UNION, UNIONALL
select department_id
from employees
union all
select department_id
from departments;
-- 교집합 - INTERSET
select department_id
from employees
intersect
select department_id
from departments
order by department_id;


-- 차집합 - MINUS
select department_id
from departments
minus
select department_id
from employees;







