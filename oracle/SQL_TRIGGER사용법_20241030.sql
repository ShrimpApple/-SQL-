show user;

-- drop user shopping;

-- 트리거 테스트 사용자 계정 생성
CREATE USER PYW IDENTIFIED BY 1234;

-- 권한 부여
-- 모든 권한 부여( 비추)
-- grant all privileges to sample;
-- 접속, 테이블 생성 권한 부여
grant connect, create table to pyw;
-- 시퀀스 생성 권한 부여
grant create sequence to pyw;
-- 트리거 생성 권한 부여
grant create trigger to pyw;

-- 테이블 스페이스 사용권한
grant unlimited tablespace to pyw;

-- 여기서 부터는 shopping 사용자로 로그인해서 작업하세요.

-- 상품 테이블 생성
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    stock_quantity NUMBER,
    import_date TIMESTAMP,
    modify_date TIMESTAMP
);
    
-- 주문 테이블 생성
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    member_id NUMBER,
    product_id NUMBER,
    order_quantity NUMBER,
    order_date TIMESTAMP,
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 시퀀스 생성
CREATE SEQUENCE order_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE product_id_seq START WITH 1 INCREMENT BY 1;

-- 샘플 상품 데이터 생성
BEGIN
    INSERT INTO products (product_id, product_name, stock_quantity, import_date, modify_date)
    VALUES (product_id_seq.NEXTVAL, '사과', 10, SYSDATE, SYSDATE);
    
    INSERT INTO products (product_id, product_name, stock_quantity, import_date, modify_date)
    VALUES (product_id_seq.NEXTVAL, '배', 20, SYSDATE, SYSDATE);
    
    INSERT INTO products (product_id, product_name, stock_quantity, import_date, modify_date)
    VALUES (product_id_seq.NEXTVAL, '오렌지', 30, SYSDATE, SYSDATE);
END;

-- 상품 조회
select *
from products;

-- 주문 조회
select *
from orders;

/* 
1. 주문 트리거 생성
- 주문이 된 상품의 재고 수량을 주문 수량만큼 차감
*/
CREATE OR REPLACE TRIGGER order_insert_trigger
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - 1
    WHERE product_id = :NEW.product_id;
END;

-- 주문 트리거 테스트 위한 샘플 주문 생성(order_id를 증가시키면서 테스트)
BEGIN
    INSERT INTO orders (order_id, member_id, product_id, order_quantity, order_date)
    VALUES (1, 1, 1, 1, TIMESTAMP '2024-02-22 10:00:00');
END;

/*
    2. 주문 수량 수정 트리거
    - 주문 테이블에서 주문 수량이 수정되면 상품 테이블에서 해당 상품의 재고 수량을 수정된
    수량에 맞춰서 증가 또는 감소시키는 트리거
    - 기존 주문보다 수정된 주문 수량이 클경우와 작은 경우를 구분해서 상품의 재고 수량을 증가/차감 한다.
*/
CREATE OR REPLACE TRIGGER order_update_trigger
AFTER UPDATE OF order_quantity ON orders
FOR EACH ROW
BEGIN
    IF :NEW.order_quantity > :OLD.order_quantity THEN
        UPDATE products
        SET stock_quantity = stock_quantity - (:NEW.order_quantity - :OLD.order_quantity)
        WHERE product_id = :NEW.product_id;
    ELSEIF :NEW.order_quantity < :OLD.order_quantity THEN
        UPDATE products
        SET stock_quantity = stock_quantity + (:OLD.order_quantity - :NEW.order_quantity)
        WHERE product_id = :NEW.product_id; 
    END IF;
END;

-- 주문 수량 수정 트리거 테스트, 주문 수량을 기존 수량보다 적게/많이 해서 테스트
BEGIN
    UPDATE orders
    SET order_quantity = 1
    WHERE order_id = 1;
END;

/*
    3. 주문 취소 트리거
    - 주문 테이블에서 주문이 취소되면 상품 테이블에서 해당 상품의 재고 수량을
    취소된 수량만큼 증가 시키는 트리거
*/
CREATE OR REPLACE TRIGGER order_delete_trigger
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity + :OLD.order_quantity
    WHERE product_id = :OLD.product_id;
END;

-- 주문 취소 트리거 테스트, 삭제한 주문의 상품 수량이 삭제된 주문 수량만큼 증가된다.
BEGIN
    DELETE FROM orders
    WHERE order_id = 3;
END;