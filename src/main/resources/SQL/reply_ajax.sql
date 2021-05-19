--chapter17 댓글처리를 위한 테이블 DDL

CREATE TABLE TBL_REPLY(
    RNO NUMBER(10,0),
    BNO NUMBER(10,0) NOT NULL,
    REPLY VARCHAR2(1000) NOT NULL,
    REPLYER VARCHAR2(50) NOT NULL,
    REPLYDATE DATE DEFAULT SYSDATE,
    UPDATEDATE DATE DEFAULT SYSDATE
);

--SEQ
CREATE SEQUENCE SEQ_REPLY;

--PK지정 : PK_REPLY
ALTER TABLE TBL_REPLY ADD CONSTRAINT PK_REPLY PRIMARY KEY (RNO);

--FK연결 : FK_REPLY_BOARD
ALTER TABLE TBL_REPLY ADD CONSTRAINT FK_REPLY_BOARD
FOREIGN KEY (BNO) REFERENCES TBL_BOARD(BNO);


--확인
select * from TBL_REPLY where BNO=425999;
select * from TBL_REPLY where rno=20;

commit ;

--가장 최신글 20개 조회해서 존재하는 BNO찾음
SELECT /*+ INDEX_DESC(TBL_BOARD PK_BOARD)*/
    ROWNUM, BNO, TITLE, CONTENT
FROM TBL_BOARD
WHERE ROWNUM <= 20;
/*
        425999
        425997
        425996
        425992
        425991
*/

----

--글번호로 확인
select * from TBL_REPLY where BNO=425999;

--댓글번호로 확인
select * from TBL_REPLY where rno=20;
