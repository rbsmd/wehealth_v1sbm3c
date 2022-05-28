/**********************************/
/* Table Name: 쇼핑카트 */
/**********************************/
DROP TABLE cart CASCADE CONSTRAINTS;
CREATE TABLE cart (
  cartno                        NUMBER(10) NOT NULL PRIMARY KEY,
  itemsno                 NUMBER(10) NULL ,
  memberno                 NUMBER(10) NOT NULL,
  cnt                            NUMBER(10) DEFAULT 0 NOT NULL,
  rdate                          DATE NOT NULL,
  FOREIGN KEY (itemsno) REFERENCES items (itemsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);
 
COMMENT ON TABLE cart is '쇼핑카트';
COMMENT ON COLUMN cart.cartno is '쇼핑카트 번호';
COMMENT ON COLUMN cart.itemsno is '상품 번호';
COMMENT ON COLUMN cart.memberno is '회원 번호';
COMMENT ON COLUMN cart.cnt is '수량';
COMMENT ON COLUMN cart.rdate is '날짜';

DROP SEQUENCE cart_seq;
CREATE SEQUENCE cart_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
-- INSERT
SELECT itemsno, item_name, item_price FROM items;  
SELECT memberno, mname FROM member; 

INSERT INTO cart(cartno, itemsno, memberno, cnt, rdate)
VALUES(cart_seq.nextval, 1, 4, 1, sysdate);

INSERT INTO cart(cartno, itemsno, memberno, cnt, rdate)
VALUES(cart_seq.nextval, 2, 4, 2, sysdate);
commit;

-- LIST
SELECT cartno, itemsno, memberno, cnt, rdate FROM cart ORDER BY cartno ASC;


-- LIST contents join
SELECT t.cartno, c.itemsno, c.item_name, c.thumb1, c.item_price, c.discount, c.total_price, c.item_point, t.memberno, t.cnt, t.rdate 
FROM items c, cart t
WHERE c.itemsno = t.itemsno
ORDER BY cartno ASC;

         
-- READ
SELECT t.cartno, c.itemsno, c.item_name, c.item_price, t.memberno, t.cnt, t.rdate 
FROM items c, cart t
WHERE (c.itemsno = t.itemsno) AND t.cartno=1;


-- UPDATE
UPDATE cart
SET cnt=2
WHERE cartno=1;
commit;

-- DELETE
DELETE FROM cart WHERE cartno=2;
commit;