/**********************************/
/* Table Name: 상품 */
/**********************************/
DROP TABLE attachfile;
DROP TABLE items CASCADE CONSTRAINTS;
commit;
CREATE TABLE items(
		itemsno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ADMINNO                       		NUMBER(10)		 NOT NULL,
		category_no                        		NUMBER(10)		 NOT NULL,
		ITEM_NAME                  		VARCHAR2(50)		 NOT NULL,
		content                       		VARCHAR2(4000)		 NOT NULL,
        RECOM_CNT                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        VIEW_CNT                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        COMMENT_CNT                     NUMBER(7)         DEFAULT 0         NOT NULL,
		PASSWORD                      		VARCHAR2(20)		 NOT NULL,
        SEARCH_WORD                                  VARCHAR2(300)         NULL ,
        CDATE                                 DATE               NOT NULL,
        file1                                 VARCHAR(100)          NULL,
        file1saved                            VARCHAR(100)          NULL,
        thumb1                                VARCHAR(100)          NULL,
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  
		ITEM_PRICE                 		NUMBER(10)      DEFAULT 0 NULL,  
		DISCOUNT                          		NUMBER(10)      DEFAULT 0 NULL,  
		TOTAL_PRICE                   		NUMBER(10)      DEFAULT 0 NULL,  
        ITEM_POINT                                 NUMBER(10)      DEFAULT 0 NULL,  
        ITEM_CNT                                 NUMBER(10)      DEFAULT 0 NULL,  
  FOREIGN KEY (category_no) REFERENCES category (category_no),
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE items is '상품';
COMMENT ON COLUMN items.itemsno is '컨텐츠 번호';
COMMENT ON COLUMN items.ADMINNO is '관리자 번호';
COMMENT ON COLUMN items.category_no is '카테고리 번호';
COMMENT ON COLUMN items.ITEM_NAME is '상품명';
COMMENT ON COLUMN items.content is '상품 설명';
COMMENT ON COLUMN items.RECOM_CNT is '추천수';
COMMENT ON COLUMN items.VIEW_CNT is '조회수';
COMMENT ON COLUMN items.COMMENT_CNT is '댓글수';
COMMENT ON COLUMN items.PASSWORD is '패스워드';
COMMENT ON COLUMN items.SEARCH_WORD is '검색어';
COMMENT ON COLUMN items.CDATE is '등록일';
COMMENT ON COLUMN items.file1 is '메인 이미지';
COMMENT ON COLUMN items.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN items.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN items.size1 is ' 메인 이미지 크기';
COMMENT ON COLUMN items.ITEM_PRICE is '정가';
COMMENT ON COLUMN items.DISCOUNT is '할인률';
COMMENT ON COLUMN items.TOTAL_PRICE is '판매가';
COMMENT ON COLUMN items.ITEM_POINT is '포인트';
COMMENT ON COLUMN items.ITEM_CNT is '수량';

DROP SEQUENCE items_seq;

CREATE SEQUENCE items_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO items(itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
                              file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt)
VALUES(items_seq.nextval, 1, 1, '런닝머신 X1', '머신', 0, 0, 0, '1234', '런닝', sysdate,
            'run1.jpg', 'run1_1.jpg', 'run1_t.jpg', 1000, 2000, 10, 1800, 100, 500);
            
INSERT INTO items(itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
                              file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt)
VALUES(items_seq.nextval, 1, 1, '런닝머신 X2', '머신', 0, 0, 0, '1234', '런닝', sysdate,
            'run1.jpg', 'run1_1.jpg', 'run1_t.jpg', 1000, 2000, 10, 1800, 100, 500);            
            
INSERT INTO items(itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
                              file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt)
VALUES(items_seq.nextval, 1, 1, '런닝머신 X3', '머신', 0, 0, 0, '1234', '런닝', sysdate,
            'run1.jpg', 'run1_1.jpg', 'run1_t.jpg', 1000, 2000, 10, 1800, 100, 500);                   

-- 조회          
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
                              file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt
FROM items
WHERE itemsno = 1;

-- 목록
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt
FROM items
ORDER BY itemsno ASC;

-- 전체 목록
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
FROM items
ORDER BY itemsno ASC;

-- cateno별 목록
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
                              file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt
FROM items
WHERE category_no=1
ORDER BY itemsno ASC;

-- 수정
UPDATE items
SET item_name='머신', content='런닝 머신',  search_word='달리기, 유산소, 런닝', 
      item_price=10000, discount=5, total_price=9500, item_point=500, item_cnt=100
WHERE itemsno = 1;

-- 컨텐츠 등록후 상품 정보 update
UPDATE items
SET item_price=2000, discount=10, total_price=1800, item_point=100, item_cnt=100
WHERE itemsno = 1;

UPDATE items
SET item_price=2000, discount=10, total_price=1800, item_point=100, item_cnt=100
WHERE itemsno = 1 OR itemsno = 2;

-- 삭제
DELETE FROM items
WHERE itemsno = 12;

-- 모든 레코드 삭제
DELETE FROM items;

-- cateno별 검색 목록
-- 1) 검색
-- ① cateno별 검색 목록
-- word(태그) 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
FROM items
WHERE category_no=1 AND search_word LIKE '%런닝%'
ORDER BY itemsno ASC;

-- title, content, word column search
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
FROM items
WHERE category_no=1 AND (item_name LIKE '%런닝%' OR content LIKE '%머신%' OR search_word LIKE '%X%')
ORDER BY itemsno ASC;


-- ② 검색 레코드 갯수
-- 전체 레코드 갯수
SELECT COUNT(*) as cnt
FROM items
WHERE category_no=1;

-- cateno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM items
WHERE category_no=1 AND search_word LIKE '%런닝%';

SELECT COUNT(*) as cnt
FROM items
WHERE category_no=1 AND (item_name LIKE '%런닝%' OR content LIKE '%머신%' OR search_word LIKE '%X%')

-- 검색 + 페이징 + 메인 이미지
-- step 1
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
FROM items
WHERE category_no=1 AND (item_name LIKE '%런닝%' OR content LIKE '%머신%' OR search_word LIKE '%X%')
ORDER BY itemsno ASC;

-- step 2
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, rownum as r
FROM (
          SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
                     file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
          FROM items
          WHERE itemsno=1 AND (item_name LIKE '%런닝%' OR content LIKE '%머신%' OR search_word LIKE '%X%')
          ORDER BY itemsno ASC
);

-- step 3, 1 page
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, r
FROM (
           SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, rownum as r
           FROM (
                        SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
                        FROM items
                        WHERE itemsno=1 AND (item_name LIKE '%런닝%' OR content LIKE '%머신%' OR search_word LIKE '%X%')
                        ORDER BY itemsno ASC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, r
FROM (
           SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, rownum as r
           FROM (
                     SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point
                     FROM items
                        WHERE itemsno=1 AND (item_name LIKE '%런닝%' OR content LIKE '%머신%' OR search_word LIKE '%X%')
                        ORDER BY itemsno ASC
           )          
)
WHERE r >= 4 AND r <= 6;

-- 등록 기능 제작 응용 상품 정보의 등록
UPDATE items
SET item_price=5000, discount=10, total_price=4500, item_point=250
WHERE itemsno = 1;


-- 조회
SELECT itemsno, adminno, category_no, item_name, content, recom_cnt, view_cnt, comment_cnt, password, search_word, cdate,
           file1, file1saved, thumb1, size1, item_price, discount, total_price, item_point, item_cnt
FROM items
WHERE itemsno = 1;


-- 패스워드 확인
SELECT COUNT(*) as cnt 
FROM items
WHERE itemsno=1 AND password='1234';

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
-- SUCCESS, Single Quotation 2번 사용
UPDATE items
SET item_name='기차를 타고', content='계획없이 ''여행'' 출발',  search_word='나,기차,생각', 
      item_price=10000, discount=5, total_price=9500, item_point=500, item_cnt=100
WHERE itemsno = 1;

-- SUCCESS, Double Quotation 사용
UPDATE items
SET item_name='기차를 타고', content='계획없이 "여행" 출발',  search_word='나,기차,생각', 
      item_price=10000, discount=5, total_price=9500, item_point=500, item_cnt=100
WHERE itemsno = 1;

-- 파일 수정
SELECT * FROM items ORDER BY itemsno ASC;

UPDATE items
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE itemsno = 1;

-- 추천
UPDATE items
SET recom_cnt = recom_cnt + 1
WHERE itemsno = 2;

-- 추천수 내림차순
SELECT * FROM items ORDER BY recom_cnt DESC;

DELETE FROM items WHERE itemsno=12;

commit;