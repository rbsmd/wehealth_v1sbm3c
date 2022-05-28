/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE category;
DROP TABLE category CASCADE CONSTRAINTS;

CREATE TABLE category(
category_no NUMERIC(10) NOT NULL PRIMARY KEY,
categorygrp_no NUMERIC(10) NOT NULL,
category_name VARCHAR(30) NOT NULL,
cdate DATE NOT NULL,
product_cnt NUMERIC(10) NOT NULL,
  FOREIGN KEY (categorygrp_no) REFERENCES categorygrp (categorygrp_no)
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.category_no is '카테고리 번호';
COMMENT ON COLUMN category.categorygrp_no is '카테고리 그룹 번호 ';
COMMENT ON COLUMN category.category_name is '카테고리 이름';
COMMENT ON COLUMN category.cdate is '등록일';
COMMENT ON COLUMN category.product_cnt is '관련 자료수';

DROP SEQUENCE category_seq;
CREATE SEQUENCE category_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999    -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO category(category_no, categorygrp_no, category_name, cdate, product_cnt)
VALUES(category_seq.nextval, 1, '런닝 머신', sysdate, 0);

INSERT INTO category(category_no, categorygrp_no, category_name, cdate, product_cnt)
VALUES(category_seq.nextval, 1, '워킹 머신', sysdate, 0);

INSERT INTO category(category_no, categorygrp_no, category_name, cdate, product_cnt)
VALUES(category_seq.nextval, 1, '실내 자전거', sysdate, 0);
commit;
-- 조회
SELECT category_no, categorygrp_no, category_name, cdate, product_cnt
FROM category
WHERE category_no=1;

-- 수정
UPDATE category
SET categorygrp_no=1, category_name='로잉 머신', product_cnt=0
WHERE category_no = 1;

SELECT * FROM category;

-- 삭제
DELETE FROM category
WHERE category_no = 1;

commit;