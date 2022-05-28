-- 테이블 구조
-- member 삭제전에 FK가 선언된 blog 테이블 먼저 삭제합니다.

DROP TABLE member;
-- 제약 조건과 함께 삭제(제약 조건이 있어도 삭제됨, 권장하지 않음.)
DROP TABLE member CASCADE CONSTRAINTS; 
 
CREATE TABLE member (
  memberno NUMBER(10) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  id             VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  passwd      VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mname      VARCHAR(30)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel            VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode     VARCHAR(5)        NULL, -- 우편번호, 12345
  address1    VARCHAR(80)       NULL, -- 주소 1
  address2    VARCHAR(50)       NULL, -- 주소 2
  mdate       DATE             NOT NULL, -- 가입일    
  grade        NUMBER(2)     NOT NULL, -- 등급(1~10: 관리자, 11~20: 회원, 비회원: 30~39, 정지 회원: 40~49, 탈퇴 회원: 99)
  file1                                 VARCHAR(100)          NULL,
  file1saved                            VARCHAR(100)          NULL,
  thumb1                                VARCHAR(100)          NULL,
  size1                                  NUMBER(10)      DEFAULT 0 NULL,  
        
  PRIMARY KEY (memberno)                     -- 한번 등록된 값은 중복 안됨
);
 
COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원 번호';
COMMENT ON COLUMN MEMBER.ID is '아이디';
COMMENT ON COLUMN MEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN MEMBER.MNAME is '성명';
COMMENT ON COLUMN MEMBER.TEL is '전화번호';
COMMENT ON COLUMN MEMBER.ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN MEMBER.MDATE is '가입일';
COMMENT ON COLUMN MEMBER.GRADE is '등급';
COMMENT ON COLUMN MEMBER.file1 is '메인 이미지';
COMMENT ON COLUMN MEMBER.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN MEMBER.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN MEMBER.size1 is ' 메인 이미지 크기';

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 
 
--1. 등록
 
--1) id 중복 확인(null 값을 가지고 있으면 count에서 제외됨)
SELECT COUNT(id)
FROM member
WHERE id='user1';

SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 --cnt
 ---
 --  0   ← 중복 되지 않음.
   
--2) 등록
-- 회원 관리용 계정, Q/A 용 계정

INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'qnaadmin', '1234', '질문답변관리자', '000-0000-0000', '12345',  '서울시 종로구', '관철동', sysdate, 1,
                            'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'crm', '1234', '고객관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 1,
                            'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
                            
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'admin_notice', '1234', '공지사항관리자', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 1,
                             'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
 
-- 개인 회원 테스트 계정
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15,
 'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'user2', '1234', '아로미', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15,
 'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'user3', '1234', '투투투', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15,
 'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
 
-- 부서별(그룹별) 공유 회원 기준
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'team1', '1234', '개발팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15,
 'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);

 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'team2', '1234', '웹퍼블리셔팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15,
 'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);
 
INSERT INTO member(memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1)
VALUES (member_seq.nextval, 'team3', '1234', '디자인팀', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate, 15,
 'profile.jpg', 'profile_1.jpg', 'profile_t.jpg', 1000);

COMMIT;

 
--2. 목록
-- 검색을 하지 않는 경우, 전체 목록 출력
 
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
file1, file1saved, thumb1, size1
FROM member
ORDER BY memberno ASC;
     
     
--3. 조회
 
--1) user1 사원 정보 보기
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE memberno = 1;

SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade
FROM member
WHERE id = 'user1';
 
    
--4. 수정
UPDATE member 
SET mname='아로미', tel='111-1111-1111', zipcode='00000',
      address1='경기도', address2='파주시', grade=14
WHERE memberno=1;

COMMIT;

UPDATE member
SET id = 'admin_n'
WHERE memberno=15;
 
--5. 삭제
--1) 모두 삭제
DELETE FROM member;
 
--2) 특정 회원 삭제
DELETE FROM member
WHERE memberno=15;

COMMIT;

 
--6. 패스워드 변경
--1) 패스워드 검사
SELECT COUNT(memberno) as cnt
FROM member
WHERE memberno=1 AND passwd='1234';
 
--2) 패스워드 수정
UPDATE member
SET passwd='0000'
WHERE memberno=1;

COMMIT;
 
 
--7. 로그인
SELECT COUNT(memberno) as cnt
FROM member
WHERE id='user1' AND passwd='1234';
 --cnt
 ---
 ---  0
 
 
 
 
 
 
 
 
 
 -- 검색 + 페이징 + 메인 이미지
-- step 1
SELECT memberno, id, passwd, mname, tel, zipcode, address1, address2, mdate, grade,
                             file1, file1saved, thumb1, size1
FROM member
WHERE memberno=1 AND (id LIKE '%테스트%' OR tel LIKE '%010%' OR mname LIKE '%테스트%')
ORDER BY memberno ASC;

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



 