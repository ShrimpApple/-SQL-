-- 1
select count(*)   전체주문건,
    sum(B.sales)  총매출,
    avg(B.sales)  평균매출,
    max(B.sales)  최고매출,
    min(B.sales)  최저매출
from reservation A, order_info B
where A.reserv_no = B.reserv_no;

-- 2
select count(*) 총판매량,

    sum(B.sales) 총매출,
    sum(decode(B.item_id, 'M0001', 1, 0)) 전용상품판매량,
    
    sum(decode(B.item_id, 'M0001', B.sales, 0)) 전용상품매출
from reservation A, order_info B
where A.reserv_no = B.reserv_no
and A.cancel = 'N';

-- 3
select C.item_id 상품아이디,
       C.product_name 상품이름,
       SUm(B.sales) 상품매출
from reservation A, order_info B, item C
where A.reserv_no = B.reserv_no
and B.item_id = C.item_id
and A.cancel = 'N'
group by C.item_id, C.product_name
order by sum(B.sales) desc;

-- 4
select substr(A.reserv_date, 1, 6) 매출월,
    sum(decode(B.item_id, 'M0001', B.sales, 0)) special_set,
    sum(decode(B.item_id, 'M0002', B.sales, 0)) pasta,
    sum(decode(B.item_id, 'M0003', B.sales, 0)) pizza,
    sum(decode(B.item_id, 'M0004', B.sales, 0)) see_food,
    sum(decode(B.item_id, 'M0005', B.sales, 0)) steak,
    sum(decode(B.item_id, 'M0006', B.sales, 0)) salad_bar,
    sum(decode(B.item_id, 'M0007', B.sales, 0)) salad,
    sum(decode(B.item_id, 'M0008', B.sales, 0)) sandwich,
    sum(decode(B.item_id, 'M0009', B.sales, 0)) wine,
    sum(decode(B.item_id, 'M0010', B.sales, 0)) juice
from reservation A, order_info B
where A.reserv_no = b.reserv_no
and A.cancel = 'N'
group by substr(A.reserv_date, 1, 6)
order by substr(A.reserv_date, 1, 6);

-- 5
select substr(A.reserv_date, 1, 6) 매출월,
    sum(B.sales) 총매출,
    sum(decode(B.item_id, 'M0001', B.sales, 0)) 전용상품매출
from reservation A, order_info B
where A.reserv_no = B.reserv_no
and A.cancel = 'N'
group by substr(A.reserv_date, 1, 6)
order by substr(A.reserv_date, 1, 6);

-- 6
select substr(A.reserv_date, 1, 6) 매출월,
    sum(B.sales) 총매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품매출,
    round(sum(decode(B.item_id, 'M0001', B.sales, 0))/sum(B.sales)*100, 1) 매출기여율
from reservation A, order_info B
where A.reserv_no = B.reserv_no
and A.cancel = 'N'
group by substr(A.reserv_date, 1, 6)
order by substr(A.reserv_date, 1, 6);

-- 7
select substr(A.reserv_date, 1, 6) 매출월,
    sum(B.sales) 총매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품매출,
    round(sum(decode(B.item_id, 'M0001', B.sales, 0))/sum(B.sales)*100, 1) 매출기여율,
    count(A.reserv_no) 총예약건,
    sum(decode(A.cancel, 'N', 1, 0)) 예약완료건,
    sum(decode(A.cancel, 'Y', 1, 0)) 예약취소건
from reservation A, order_info B
where A.reserv_no = B.reserv_no
-- and A.cancel = 'N'
group by substr(A.reserv_date, 1, 6)
order by substr(A.reserv_date, 1, 6);



select substr(A.reserv_date, 1, 6) 매출월,
    sum(B.sales) 총매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품매출,
    round(sum(decode(B.item_id, 'M0001', B.sales, 0))/sum(B.sales)*100, 1) 매출기여율,
    count(A.reserv_no) 총예약건,
    sum(decode(A.cancel, 'N', 1, 0)) 예약완료건,
    sum(decode(A.cancel, 'Y', 1, 0)) 예약취소건
from reservation A, order_info B
where A.reserv_no = B.reserv_no(+)
-- and A.cancel = 'N'
group by substr(A.reserv_date, 1, 6)
order by substr(A.reserv_date, 1, 6);

-- 8
select substr(A.reserv_date, 1, 6) 매출월,
    sum(B.sales) 총매출,
    - sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품외매출,
    sum(decode(b.item_id, 'M0001', b.sales, 0)) 전용상품매출,
    round(sum(decode(B.item_id, 'M0001', B.sales, 0))/sum(B.sales)*100, 1)||'%' 전용상품만매율,
    count(A.reserv_no) 총예약건,
    sum(decode(A.cancel, 'N', 1, 0)) 예약완료건,
    sum(decode(A.cancel, 'Y', 1, 0)) 예약취소건,
    round(sum(decode(A.cancel, 'Y', 1, 0))/count(A.reserv_no)*100,1)||'%' 예약취소율
from reservation A, order_info B
where A.reserv_no = B.reserv_no(+)
-- and A.cancel = 'N'
group by substr(A.reserv_date, 1, 6)
order by substr(A.reserv_date, 1, 6);

-- 9
select substr(reserv_date, 1, 6) 날짜,
        A.product_name 상품명,
        sum(decode(A.week, '1', A.sales, 0)) 일요일,
        sum(decode(A.week, '2', A.sales, 0)) 월요일,
        sum(decode(A.week, '3', A.sales, 0)) 화요일,
        sum(decode(A.week, '4', A.sales, 0)) 수요일,
        sum(decode(A.week, '5', A.sales, 0)) 목요일,
        sum(decode(A.week, '6', A.sales, 0)) 금요일,
        sum(decode(A.week, '7', A.sales, 0)) 토요일
from
    (
    select A.reserv_date,
        C.product_name,
        to_char(to_date(A.reserv_date, 'YYYYMMDD'), 'd') week,
        B.sales
    from reservation A, order_info B, item C
    where A.reserv_no = B.reserv_no
    and B.item_id = C.item_id
    and B.item_id = 'M0001'
    ) A
group by substr(reserv_date, 1, 6), A.product_name
order by substr(reserv_date, 1, 6);

-- 10 
select *
    from
    (
    select substr(A.reserv_date, 1, 6) 매출월,
        A.branch                       지점,
        sum(B.sales)                   전용상품매출,
        rank() over(partition by substr(A.reserv_date, 1, 6)
    order by sum(B.sales) desc) 지점순위
    from reservation A, order_info B
    where A.reserv_no = B.reserv_no
    and A.cancel = 'N'
    and B.item_id = 'M0001'
    group by substr(A.reserv_date, 1, 6), A.branch
    order by substr(A.reserv_date, 1, 6)
    ) A
    where A.지점순위 <= 3;
    
    
select *
    from
    (
    select substr(A.reserv_date, 1, 6) 매출월,
        A.branch                       지점,
        sum(B.sales)                   전용상품매출,
        row_number() over(partition by substr(A.reserv_date, 1, 6)
    order by sum(B.sales) desc) 지점순위,
        decode(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B') 지점등급
    from reservation A, order_info B
    where A.reserv_no = B.reserv_no
    and A.cancel = 'N'
    and B.item_id = 'M0001'
    group by substr(A.reserv_date, 1, 6), A.branch,
        decode(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')
    order by substr(A.reserv_date, 1, 6)
    ) A
    where A.지점순위 = 1;
    -- and 지점등급 = 'A'
    
-- 11
select A.매출월           매출월,
       MAX(총매출)        총매출,
       MAX(전용상품외매출)  전용상품외매출,
       MAX(전용상품매출)   전용상품매출,
       MAX(전용상품판매율)  전용상품판매율,
       MAX(총예약건)      총예약건,
       MAX(예약완료건)    예약완료건,
       MAX(예약최소율)    예약최소율,
       MAX(최대매출지점)   최대매출지점,
       MAX(지점매출액)     지점매출액
from
(
    select substr(A.reserv_date, 1, 6) 매출월,
           sum(B.sales) 총매출,
           sum(B.sales)
           - sum(decode(B.item_id, 'M0001', B.sales, 0)) 전용상품외매출,
           sum(decode(B.item_id, 'M0001', B.sales, 0)) 전용상품매출,
           round(sum(decode(B.item_id, 'M0001', B.sales, 0))/sum(B.sales)*100,
    1)||'%' 전용상품판매율,
           count(A.reserv_no) 총예약건,
           sum(decode(A.cancel, 'N', 1, 0)) 예약완료건,
           sum(decode(A.cancel, 'Y', 1, 0)) 예약취소건,
           round(sum(decode(A.cancel, 'Y', 1, 0))/count(A.reserv_no)*100, 1)||'%' 예약최소율,
           '' 최대매출지점,
           0 지점매출액
        from reservation A, order_info B
        where A.reserv_no = B.reserv_no(+)
        -- AND A.cancel = 'N'
        group by substr(A.reserv_date, 1, 6), '', 0
    union
        select A.매출월,
               0           총매출,
               0           전용상품외매출,
               0           전용상품매출,
               ''          전용상품판매율,
               0           총예약건,
               0           예약완료건,
               0           예약취소건,
               ''          예약취소율,
               A.지점       최대매출지점,
               A.전용상품매출 지점매출액
        from
        (
        select substr(A.reserv_date, 1, 6) 매출월,
                A.branch                   지점,
                sum(B.sales)               전용상품매출,
                row_number() over(partition by substr(A.reserv_date, 1, 6)
        order by sum(B.sales) desc) 지점순위,
                decode(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B') 지점등급
        from reservation A, order_info B
        where A.reserv_no = B.reserv_no
        and A.cancel = 'N'
        and B.item_id = 'M0001'
        group by substr(A.reserv_date, 1, 6), A.branch,
            decode(A.branch, '강남', 'A', '종로', 'A', '영등포', 'A', 'B')
            order by substr(A.reserv_date, 1, 6)
        ) A
        where A.지점순위 = 1
        -- AND 지점등급 = 'A'
    ) A
    group by A.매출월
    order by A.매출월;
    
-- 12
select count(customer_id) 고객수,
    sum(decode(sex_code, 'M', 1, 0)) 남자,
    sum(decode(sex_code, 'F', 1, 0)) 여자,
    round(avg(months_between(to_date('20171231', 'YYYYMMDD'), to_date(birth,
    'YYYYMMDD'))/12), 1) 평균나이,
        round(avg(months_between(to_date('20171231', 'YYYYMMDD'), first_reg_date)),
    1) 평균거래기간
from customer;

-- 13
select A.customer_id     고객아이디,
       A.customer_name   고객이름,
       count(C.order_no) 전체상품주문건수,
       sum(C.sales)      총매출,
       sum(decode(C.item_id, 'M0001', 1, 0)) 전용상품주문건수,
       sum(decode(C.item_id, 'M0001', C.sales, 0)) 전용상품매출
from customer A, reservation B, order_info C
where A.customer_id = B.customer_id
and   B.reserv_no   = C.reserv_no
and   B.cancel      = 'N'
group by A.customer_id, A.customer_name
order by sum(decode(C.item_id, 'M0001', C.sales, 0)) desc;

-- 14
select B.address_detail 주소, B.zip_code, count(B.address_detail) 카운팅
from (
    select distinct A.customer_id, A.zip_code
    from customer A, reservation B, order_info C
    where A.customer_id = B.customer_id
    and B.reserv_no     = C.reserv_no
    and B.cancel        = 'N'
    -- AND C.item_id    - 'M0001'
    ) A, address B
where A.zip_code = B.zip_code
group by B.address_detail, B.zip_code
order by count(B.address_detail)desc;


-- 15
select nvl(B.job,'정보없음') 직업, count(nvl(B.job,1)) 카운팅
from (
    select distinct A.customer_id, A.zip_code
    from   customer A, reservation B, order_info C
    where A.customer_id = B.customer_id
    and   B.reserv_no   = C.reserv_no
    and   B.cancel      = 'N'
    -- and C.item_id = 'M0001'
    ) A, customer B
where A.customer_id = B.customer_id
group by nvl(B.job, '정보없음')
order by count(nvl(B.job, 1)) desc;


-- 16
select *
from
(
select A.customer_id,
       A.customer_name,
       sum(C.sales) 전용상품매출,
       row_number() over(partition by C.item_id order by sum(C.sales) desc) 순위
    from customer A, reservation B, order_info C
    where A.customer_id = B.customer_id
    and   B.reserv_no   = C.reserv_no
    and   B.cancel      = 'N'
    and   C.item_id     = 'M0001'
    group by A.customer_id, C.item_id, A.customer_name
) A
where A.순위 <= 10
order by A.순위;

-- 17
select rownum, A.*
from
(
    select A.customer_id,
           A.customer_name,
           sum(decode(C.item_id, 'M0001', C.sales, 0)) 전용상품_매출
    from customer A, reservation B, order_info C
    where A.customer_id = B.customer_id
    and   B.reserv_no   = C.reserv_no
    and   B.cancel      = 'N'
    group by A.customer_id, A.customer_name
    order by sum(decode(C.item_id, 'M0001', C.sales, 0)) desc
) A
where rownum <= 10;

-- 18
select A.주소, count(A.주소) 카운팅
from
(
    select A.customer_id        고객아이디,
           A.customer_name      고객이름,
           NVL(A.job, '정보없음') 직업,
           D.address_detail     주소,
           sum(C.sales)         전용상품_매출,
           rank() over(partition by C.item_id order by sum(C.sales) desc) 순위
    from customer A, reservation B, order_info C, address D
    where A.customer_id = B.customer_id
    and   B.reserv_no   = C.reserv_no
    and   A.zip_code    = D.zip_code
    and   B.cancel      = 'N'
    and   C.item_id     = 'M0001'
    group by A.customer_id, C.item_id, A.customer_name, nvl(A.job, '정보없음'),
D.address_detail
) A
where A.순위 <= 10
group by A.주소
order by count(A.주소) desc;

select A.직업, count(A.직업) 카운팅
from
(
    select A.customer_id        고객아이디,
           A.customer_name      고객이름,
           NVL(A.job, '정보없음') 직업,
           D.address_detail     주소,
           sum(C.sales)         전용상품_매출,
           rank() over(partition by C.item_id order by sum(C.sales) desc) 순위
    from customer A, reservation B, order_info C, address D
    where A.customer_id = B.customer_id
    and   B.reserv_no   = C.reserv_no
    and   A.zip_code    = D.zip_code
    and   B.cancel      = 'N'
    and   C.item_id     = 'M0001'
    group by A.customer_id, C.item_id, A.customer_name, NVL(A.job, '정보없음'),
D.address_detail
) A group by A.직업
where A.순위 <= 10
group by A.직업;
order by count(A.직업) desc;


-- 19
select *
from (
    select A.고객아이디,
           A.고객이름,
           D.product_name 상품명,
           sum(C.sales) 상품매출,
           rank() over(partition by A.고객아이디 order by sum(C.sales) desc) 선호도순위
    from
    (
        select A.customer_id          고객아이디,
               A.customer_name        고객이름,
               sum(C.sales)           전용상품_매출
        from customer A, reservation B, order_info C
        where A.customer_id = B.customer_id
        and   B.reserv_no   = C.reserv_no
        and   B.cancel      = 'N'
        and   C.item_id     = 'M0001'
        group by A.customer_id, A.customer_name
        having sum(C.sales) >= 216000
    ) A, reservation B, order_info C, item D
    where A.고객아이디       = B.customer_id
    and   B.reserv_no      = C.reserv_no
    and   C.item_id        = D.item_id
    and   D.item_id        <> 'M0001'
    and   B.cancel         = 'N'
    group by A.고객아이디, A.고객이름, D.product_name
) A
where A.선호도순위 = 1;


