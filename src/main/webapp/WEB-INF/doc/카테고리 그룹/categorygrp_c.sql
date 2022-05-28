DROP TABLE categorygrp CASCADE CONSTRAINTS; 
DROP TABLE categorygrp;

CREATE TABLE categorygrp(
categorygrp_no NUMERIC(10) NOT NULL PRIMARY KEY,
categorygrp_name VARCHAR(50) NOT NULL,
seq_no NUMERIC(7) NOT NULL,
print_mode CHAR(1) NOT NULL,
cdate DATE NOT NULL
);

COMMENT ON TABLE categorygrp is '카테고리 그룹';
COMMENT ON COLUMN categorygrp.categorygrp_no is '카테고리 그룹 번호 ';
COMMENT ON COLUMN categorygrp.categorygrp_name is '이름';
COMMENT ON COLUMN categorygrp.seq_no is '출력 순서';
COMMENT ON COLUMN categorygrp.print_mode is '출력 모드';
COMMENT ON COLUMN categorygrp.cdate is '그룹 생성일';

DROP SEQUENCE categorygrp_seq;
CREATE SEQUENCE categorygrp_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999    -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO categorygrp(categorygrp_no, categorygrp_name, seq_no, print_mode, cdate)
VALUES(categorygrp_seq.nextval, '유산소 운동', 1, 'Y', sysdate);

INSERT INTO categorygrp(categorygrp_no, categorygrp_name, seq_no, print_mode, cdate)
VALUES(categorygrp_seq.nextval, '근력 운동', 2, 'Y', sysdate);

INSERT INTO categorygrp(categorygrp_no, categorygrp_name, seq_no, print_mode, cdate)
VALUES(categorygrp_seq.nextval, '유연성 운동', 3, 'Y', sysdate);
commit;
-- 조회
SELECT categorygrp_no, categorygrp_name, seq_no, print_mode, cdate 
FROM categorygrp 
WHERE categorygrp_no = 1;

-- 삭제
DELETE FROM categorygrp  
WHERE categorygrp_no =3;

-- 수정
UPDATE categorygrp
SET categorygrp_name='부속품'
WHERE categorygrp_no=1;
commit;