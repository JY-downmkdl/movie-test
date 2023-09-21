-- 생성자 Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   위치:        2023-09-21 16:31:52 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



CREATE USER greencinema IDENTIFIED BY ACCOUNT UNLOCK ;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE greencinema.mem_auth (
    userid VARCHAR2(50 BYTE) NOT NULL,
    auth   VARCHAR2(50 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX greencinema.mem_auth_pk ON
    greencinema.mem_auth (
        userid
    ASC )
        TABLESPACE system PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE greencinema.mem_auth
    ADD CONSTRAINT mem_auth_pk PRIMARY KEY ( userid )
        USING INDEX greencinema.mem_auth_pk;

CREATE TABLE greencinema.member (
    userid   VARCHAR2(50 BYTE) NOT NULL,
    userpw   VARCHAR2(100 BYTE) NOT NULL,
    username VARCHAR2(100 BYTE) NOT NULL,
    birth    DATE DEFAULT sysdate,
    phone    VARCHAR2(100 BYTE),
    enabled  CHAR(1 BYTE) DEFAULT '1'
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE greencinema.member
    ADD CONSTRAINT member_pk PRIMARY KEY ( userid )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE system
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE greencinema.movies (
    movcode        NUMBER(6) NOT NULL,
    movname        VARCHAR2(100 BYTE),
    movdirector    VARCHAR2(100 BYTE),
    movgenre       VARCHAR2(50 BYTE),
    movgrade       NUMBER,
    movrunningtime NUMBER(4),
    movrelease     DATE,
    thum_movposter VARCHAR2(200 BYTE),
    filename       VARCHAR2(500 BYTE) DEFAULT 'default_img.jpg',
    uploadpath     VARCHAR2(500 BYTE),
    fullname       VARCHAR2(500 BYTE),
    thstates       NUMBER(1) DEFAULT 1
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX greencinema.sys_c007425 ON
    greencinema.movies (
        movcode
    ASC )
        TABLESPACE system PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE greencinema.movies
    ADD CONSTRAINT movies_pk PRIMARY KEY ( movcode )
        USING INDEX greencinema.sys_c007425;

CREATE TABLE greencinema.persistent_logins (
    username  VARCHAR2(64 BYTE) NOT NULL,
    series    VARCHAR2(64 BYTE) NOT NULL,
    token     VARCHAR2(64 BYTE) NOT NULL,
    last_used TIMESTAMP NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE greencinema.persistent_logins
    ADD CONSTRAINT persistent_logins_pk PRIMARY KEY ( series )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE system
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE greencinema.reservation (
    rvcode     VARCHAR2(50 BYTE),
    rvuserid   VARCHAR2(50 BYTE),
    rvmovcode  NUMBER(6),
    rvmovname  VARCHAR2(100 BYTE),
    rvthcode   NUMBER(4),
    rvthname   VARCHAR2(100 BYTE),
    rvschtime  DATE,
    rvrunning  VARCHAR2(100 BYTE),
    rvschall   VARCHAR2(50 BYTE),
    rvcount    NUMBER(2),
    rvschseats VARCHAR2(50 BYTE),
    rvlist     VARCHAR2(100 BYTE),
    rvprice    NUMBER(5),
    rvtime     DATE DEFAULT sysdate,
    paymethod  VARCHAR2(20 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE greencinema.schedules (
    schall     VARCHAR2(50 BYTE) NOT NULL,
    schtime    DATE NOT NULL,
    schthcode  NUMBER(4) NOT NULL,
    schmovcode NUMBER(6) NOT NULL,
    seatcount  NUMBER(3) DEFAULT 110,
    seatlist   VARCHAR2(330 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX greencinema.schedules_pk ON
    greencinema.schedules (
        schtime
    ASC,
        schthcode
    ASC,
        schall
    ASC )
        TABLESPACE system PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE greencinema.schedules
    ADD CONSTRAINT schedules_pk PRIMARY KEY ( schtime,
                                              schthcode,
                                              schall )
        USING INDEX greencinema.schedules_pk;

CREATE TABLE greencinema.text_seq (
    nums NUMBER(6)
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE greencinema.theaters (
    thcode    NUMBER(4) NOT NULL,
    thname    VARCHAR2(100 BYTE),
    thaddress VARCHAR2(200 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX greencinema.sys_c007427 ON
    greencinema.theaters (
        thcode
    ASC )
        TABLESPACE system PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE greencinema.theaters
    ADD CONSTRAINT theaters_pk PRIMARY KEY ( thcode )
        USING INDEX greencinema.sys_c007427;

ALTER TABLE greencinema.mem_auth
    ADD CONSTRAINT fk_member_auth FOREIGN KEY ( userid )
        REFERENCES greencinema.member ( userid )
    NOT DEFERRABLE;

ALTER TABLE greencinema.schedules
    ADD CONSTRAINT fk_movcode FOREIGN KEY ( schmovcode )
        REFERENCES greencinema.movies ( movcode )
    NOT DEFERRABLE;

ALTER TABLE greencinema.schedules
    ADD CONSTRAINT fk_schthcode FOREIGN KEY ( schthcode )
        REFERENCES greencinema.theaters ( thcode )
    NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             4
-- ALTER TABLE                              9
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
