drop table addresses;
drop table users CASCADE CONSTRAINTS;
drop table addresses CASCADE CONSTRAINTS;

create table users(
id INTEGER primary key,
myid INTEGER,
username VARCHAR2(25) not null,
enabled char(1) default '1',
last_login date default sysdate
);

create table address(
    user_id INTEGER PRIMARY key,
    street varchar2(30) not null,
    city VARCHAR2(30) not null,
    state VARCHAR2(30) not null
);

ALTER TABLE adress ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (myid);
ALTER TABLE users ADD CONSTRAINT fk_addresses_id FOREIGN KEY (myid) REFERENCES addresses (user_id);
-- CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (myid));