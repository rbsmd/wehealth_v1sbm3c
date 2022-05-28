DROP TABLE reply;
DROP TABLE reply CASCADE CONSTRAINTS;

CREATE TABLE reply(
    replyno   NUMBER(10) NOT NULL PRIMARY KEY,
    itemsno    NUMBER(10) NOT NULL,
    memberno NUMBER(6) NOT NULL,
    content  VARCHAR2(1000) NOT NULL,
    passwd VARCHAR2(20) NOT NULL,
    rdate       DATE NOT NULL,
    FOREIGN KEY (itemsno) REFERENCES items (itemsno),
    FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글번호';
COMMENT ON COLUMN reply.itemsno is '아이템 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.content is '내용';
COMMENT ON COLUMN reply.passwd is '비밀번호';
COMMENT ON COLUMN reply.rdate is '등록일';


DROP SEQUENCE reply_seq;

CREATE SEQUENCE reply_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999999
CACHE 2
NOCYCLE;


--1) 등록
INSERT INTO reply(replyno, itemsno, memberno, content, passwd, rdate)
VALUES(reply_seq.nextval, 1, 4, '제품 너무 좋아요!', '1234', sysdate);

INSERT INTO reply(replyno, itemsno, memberno, content, passwd, rdate)
VALUES(reply_seq.nextval, 1, 5, '잘 사용하고 있습니다! ^_____^', '1234', sysdate);

commit;

--2) 전체 목록
SELECT replyno, itemsno, memberno, content, passwd, rdate
FROM reply
ORDER BY replyno DESC;

--   REPLYNO    ITEMSNO   MEMBERNO CONTENT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  PASSWD               RDATE              
---------- ---------- ---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------- -------------------
--         2          1          5 잘 사용하고 있습니다! ^_____^                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            1234                 2022-01-24 07:16:12
 --        1          1          4 제품 너무 좋아요!       
       

--3) reply + member join 목록
SELECT m.id,
          r.replyno, r.itemsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE m.memberno = r.memberno
ORDER BY r.replyno DESC;

--4) reply + member join + 특정 contentsno 별 목록
SELECT m.id,
           r.replyno, r.itemsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.itemsno=1
ORDER BY r.replyno DESC;

--ID                      REPLYNO    ITEMSNO   MEMBERNO CONTENT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  PASSWD               RDATE              
--------------------- ---------- ---------- ---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------- -------------------
--user2                         2          1          5 잘 사용하고 있습니다! ^_____^                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            1234                 2022-01-24 07:16:12
--user1                         1          1          4 제품 너무 좋아요!      
 

--5) 삭제
-- 패스워드 검사
SELECT count(passwd) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

-- CNT
 ---
 --  1
   
-- 삭제
DELETE FROM reply
WHERE replyno=1;

--6) contentsno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE itemsno=1;

 --CNT
 ---
  -- 1

DELETE FROM reply
WHERE itemsno=1;

--7) memberno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE memberno=4;

 --CNT
 ---
 --  1

DELETE FROM reply
WHERE memberno=1;
 
--8) 삭제용 패스워드 검사
SELECT COUNT(*) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 --CNT
 ---
 --  0

--9) 삭제
DELETE FROM reply
WHERE replyno=1;

SELECT id, replyno, itemsno, memberno, content, passwd, rdate, r
    FROM (
        SELECT id, replyno, itemsno, memberno, content, passwd, rdate, rownum as r
        FROM (
            SELECT m.id, r.replyno, r.itemsno, r.memberno, r.content, r.passwd, r.rdate
            FROM member m,  reply r
            WHERE (m.memberno = r.memberno) AND r.itemsno= 1
            ORDER BY r.replyno DESC
        )
    )
    WHERE r <= 1000;

SELECT m.id,
               r.replyno, r.itemsno, r.memberno, r.content, r.passwd, r.rdate
    FROM member m,  reply r
    WHERE (m.memberno = r.memberno) AND r.itemsno=1
    ORDER BY r.replyno DESC;
