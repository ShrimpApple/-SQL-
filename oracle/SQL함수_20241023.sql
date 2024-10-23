SELECT * FROM employees;

-- where
-- 비교연산자
SELECT * 
FROM employees
WHERE employee_id = 100;

--first_name이 David인 직원의 정보
SELECT *
FROM employees
WHERE first_name = 'David';

--employee_id가 105 이상인 직원의 정보
SELECT *
FROM employees
WHERE employee_id >= 105;

--salary가 10,000 이상이고 20,000 이하인 직원의 정보
--SQL 연산자
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

--salary가 10000, 17000, 24000인 직원 정보
SELECT *
FROM employees
WHERE salary IN(10000, 17000, 24000);

-- job_id값이 AD로 시작하는 모든(%) 데이터를 출력
SELECT *
FROM employees
WHERE job_id LIKE 'AD%';

--AD로 시작하면서 뒤에 따라오는 문자열이 3자리인 데이터 출력
SELECT *
FROM employees
WHERE job_id LIKE 'AD___';

--manager_id가 null 값인 직원 정보
SELECT *
FROM employees
WHERE manager_id IS NULL;

-- 논리연산자
-- salary가 4000을 초과하면서 job_id가 IT_PROG인 값을 조회
SELECT *
FROM employees
WHERE salary > 4000 AND job_id = 'IT_PROG';

-- salary가 4000을 초과하면서 job_id가 IT_PROG 이거나 FI_ACCOUNT인 경우
SELECT *
FROM employees
WHERE salary > 4000 
AND job_id = 'IT_PROG'
OR job_id = 'FI_ACCOUNT';

-- employee_id가 105가 아닌 직원만 출력
SELECT *
FROM employees
WHERE employee_id <> 105;

-----------------------------------------------------------
-- SQL 함수
--  문자 표시
select last_name,
    lower(last_name) Lower적용,
    upper(last_name) Upper적용,
    email,
    initcap(email) Intcap적용
from employees;

-- 특정 글자 출력
SELECT job_id, substr(job_id,1,2)
FROM employees;

-- 글자 바꾸기(표시로만 )
select job_id, replace(job_id, 'ACCOUNT', 'ACCNT') 적용결과
FROM employees;

-- 특정 문자로 채우기 (LPAD적용결과 - 오른쪽)
select first_name,  LPAD(first_name, 12, '*') 
FROM employees;

--자르기(LTRIM, RTRIM, TRIM)
select 'start'||'    - space -    '||'end'
from dual;

-- 좌우 공백제거
--  dual 테이블은 더미(dummy)
select 'start'||trim('    - space -    ')||'end'
from dual;

-- 자리 올림
select salary,
       salary/30 일급,
       round(salary/30, 0) 적용결과_0,
       round(salary/30, 1) 적용결과_1,
       round(salary/30, -1) 적용결과_마이너스1
FROM employees;

-- 절삭
select salary,
       salary/30 일급,
       trunc(salary/30, 0) 적용결과_0,
       trunc(salary/30, 1) 적용결과_1,
       trunc(salary/30, -1) 적용결과_마이너스1
FROM employees;

-- 날짜계산 - 오늘날짜, 더하기1, 빼기1, 특정날짜 빼기, 시간더하기
select to_char(sysdate, 'YY/MM/DD/HH24:MI') 오늘날짜,
        sysdate + 1 더하기_1,
        sysdate - 1 빼기_1,
        to_date('20241205') - to_date('20021201') 날짜빼기,
        sysdate + 13/24 시간더하기
from dual;

-- 두 날짜 사이에 개월 수 계산
select sysdate, hire_date, months_between(sysdate, hire_date) 적용결과
FROM employees
where department_id = 100;

-- 월에 날짜 더하기 - ADD_MONTHS
select hire_date,
        add_months(hire_date, 3) 더하기_적용결과,
        add_months(hire_date, -3) 빼기_적용결과
FROM employees
where department_id = 100;

-- NULL 값 출력
select salary * commission_pct
FROM employees
order by commission_pct;

-- NULL 값 처리 NVL
select salary * NVL(commission_pct, 1)
FROM employees
order by commission_pct;

-- DECODE 사용
select first_name,
       last_name,
       department_id,
       salary 원래_급여,
       decode(department_id, 60, salary*1.1, salary) 조정된급여,
       decode(department_id, 60, '10%인상', '미인상') 인상여부
FROM employees;

-- DECODE를 case로 변경
select first_name,
       last_name,
       department_id,
       salary 원래_급여,
       case department_id  when 60 then  salary*1.1  else salary end 조정된급여,
       case department_id  when 60 then  '10%인상'  else '미인상' end 인상여부
FROM employees;

