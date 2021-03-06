-- Generated by Oracle SQL Developer Data Modeler 20.4.1.406.0906
--   at:        2021-03-03 15:16:22 NPT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

DROP TABLE cuisineitem PURGE;
DROP TABLE deliveryaddress PURGE;
DROP TABLE lineitem PURGE;
DROP TABLE loyaltypoint PURGE;
DROP TABLE menuitem PURGE;
DROP TABLE restaurant PURGE;
DROP TABLE useraddress PURGE;
DROP TABLE cuisine PURGE;
DROP TABLE delivery PURGE;
DROP TABLE dish PURGE;
DROP TABLE "Order" PURGE;
DROP TABLE "User" PURGE;


CREATE TABLE cuisine (
    id           NUMBER(10) NOT NULL,
    name         VARCHAR2(50),
    description  VARCHAR2(100)
);

ALTER TABLE cuisine ADD CONSTRAINT cuisine_pk PRIMARY KEY ( id );

CREATE TABLE cuisineitem (
    id             NUMBER(10) NOT NULL,
    restaurant_id  NUMBER(10) NOT NULL,
    cuisine_id     NUMBER(10) NOT NULL
);

ALTER TABLE cuisineitem ADD CONSTRAINT cuisineitem_pk PRIMARY KEY ( id );

CREATE TABLE delivery (
    id             NUMBER(10) NOT NULL,
    deliverystage  VARCHAR2(50) NOT NULL,
    assignedagent  VARCHAR2(100),
    "date"         DATE,
    order_id       NUMBER(10) NOT NULL
);

CREATE INDEX delivery__idx ON
    delivery (
        id
    ASC );

CREATE INDEX deliveryorder__idx ON
    delivery (
        id
    ASC,
        order_id
    ASC );

ALTER TABLE delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( id );

CREATE TABLE deliveryaddress (
    id           NUMBER(10) NOT NULL,
    longitude    VARCHAR2(100),
    latitude     VARCHAR2(100),
    city         VARCHAR2(100),
    street       VARCHAR2(255),
    landmarks    VARCHAR2(255),
    delivery_id  NUMBER(10) NOT NULL
);

CREATE INDEX deliveryaddress__idx ON
    deliveryaddress (
        id
    ASC );

CREATE UNIQUE INDEX addressdelivery__idx ON
    deliveryaddress (
        delivery_id
    ASC );

ALTER TABLE deliveryaddress ADD CONSTRAINT deliveryaddress_pk PRIMARY KEY ( id );

CREATE TABLE dish (
    id    NUMBER(10) NOT NULL,
    code  VARCHAR2(50),
    name  VARCHAR2(100)
);

CREATE INDEX dish__idx ON
    dish (
        id
    ASC );

ALTER TABLE dish ADD CONSTRAINT dish_pk PRIMARY KEY ( id );

ALTER TABLE dish ADD CONSTRAINT dish_code_un UNIQUE ( code );

CREATE TABLE lineitem (
    id           NUMBER(10) NOT NULL,
    quantity     NUMBER(5) NOT NULL,
    itemtotal    NUMBER(10, 2) NOT NULL,
    order_id     NUMBER(10) NOT NULL,
    menuitem_id  NUMBER(10) NOT NULL
);

ALTER TABLE lineitem
ADD CONSTRAINT lineitem_min_qty CHECK (quantity > 0);

ALTER TABLE lineitem
ADD CONSTRAINT lineitem_max_qty CHECK (quantity < 30);

CREATE INDEX lineitem__idx ON
    lineitem (
        id
    ASC );

CREATE INDEX orderitemmenu__idx ON
    lineitem (
        id
    ASC,
        order_id
    ASC,
        menuitem_id
    ASC );

ALTER TABLE lineitem ADD CONSTRAINT lineitem_pk PRIMARY KEY ( id );

CREATE TABLE loyaltypoint (
    id           NUMBER(10) NOT NULL,
    points       NUMBER(10, 2) NOT NULL,
    status       VARCHAR2(100) NOT NULL,
    activefrom   TIMESTAMP(0),
    activeuntil  TIMESTAMP(0),
    menuitem_id  NUMBER(10) NOT NULL
);

ALTER TABLE loyaltypoint
ADD CONSTRAINT loyaltypoint_date_validity CHECK (activeuntil >= activefrom);

ALTER TABLE loyaltypoint ADD CONSTRAINT loyaltypoint_pk PRIMARY KEY ( id );

CREATE TABLE menuitem (
    id             NUMBER(10) NOT NULL,
    rate           NUMBER(10, 2) NOT NULL,
    displayname    VARCHAR2(255) NOT NULL,
    dietcategory   VARCHAR2(50),
    description    VARCHAR2(255),
    displayphoto   BLOB,
    isavailable    CHAR(1) NOT NULL,
    dish_id        NUMBER(10) NOT NULL,
    restaurant_id  NUMBER(10) NOT NULL
);

CREATE INDEX menuitem__idx ON
    menuitem (
        id
    ASC );

CREATE INDEX restaurantmenu__idx ON
    menuitem (
        id
    ASC,
        restaurant_id
    ASC );

CREATE INDEX menudish__idx ON
    menuitem (
        id
    ASC,
        dish_id
    ASC );

ALTER TABLE menuitem ADD CONSTRAINT menuitem_pk PRIMARY KEY ( id );

CREATE TABLE "Order" (
    id             NUMBER(10) NOT NULL,
    serialnumber   NUMBER(10),
    ordertotal     NUMBER(10, 2),
    orderstatus    VARCHAR2(50) NOT NULL,
    paymentstatus  VARCHAR2(50) NOT NULL,
    creationdate   TIMESTAMP(0),
    loyaltyscore   NUMBER(10, 2),
    user_id        NUMBER(10) NOT NULL
);

CREATE INDEX order__idx ON
    "Order" (
        id
    ASC );

CREATE INDEX user__idxv4 ON
    "Order" (
        user_id
    ASC );

CREATE INDEX userorder__idx ON
    "Order" (
        id
    ASC,
        user_id
    ASC );

ALTER TABLE "Order" ADD CONSTRAINT order_pk PRIMARY KEY ( id );

ALTER TABLE "Order" ADD CONSTRAINT order_serialnumber_un UNIQUE ( serialnumber );

CREATE TABLE restaurant (
    id            NUMBER(10) NOT NULL,
    name          VARCHAR2(100) NOT NULL,
    branch        VARCHAR2(100),
    bio           VARCHAR2(255),
    phone         NUMBER(10),
    displayphoto  BLOB,
    costfortwo    NUMBER(10, 2),
    city          VARCHAR2(100),
    street        VARCHAR2(255)
);

ALTER TABLE restaurant ADD CONSTRAINT restaurant_pk PRIMARY KEY ( id );

CREATE TABLE "User" (
    id               NUMBER(10) NOT NULL,
    username         VARCHAR2(50) NOT NULL,
    phone            INTEGER NOT NULL,
    email            VARCHAR2(255) NOT NULL,
    password         VARCHAR2(255) NOT NULL,
    redeemedloyalty  NUMBER(10)
);

ALTER TABLE "User"
ADD CONSTRAINT user_email_validity CHECK (email LIKE '%@%.%');

CREATE INDEX user__idx ON
    "User" (
        id
    ASC );

ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( id );

ALTER TABLE "User" ADD CONSTRAINT user_phone_un UNIQUE ( phone );

ALTER TABLE "User" ADD CONSTRAINT user_username_un UNIQUE ( username );

CREATE TABLE useraddress (
    id         NUMBER(10) NOT NULL,
    longitude  NUMBER(9,6),
    latitude   NUMBER(9,6),
    city       VARCHAR2(100),
    street     VARCHAR2(255),
    landmarks  VARCHAR2(255),
    user_id    NUMBER(10) NOT NULL
);

CREATE INDEX useraddress__idx ON
    useraddress (
        id
    ASC );

CREATE INDEX user__idxv1 ON
    useraddress (
        user_id
    ASC );

ALTER TABLE useraddress ADD CONSTRAINT useraddress_pk PRIMARY KEY ( id );

ALTER TABLE cuisineitem
    ADD CONSTRAINT cuisineitem_cuisine_fk FOREIGN KEY ( cuisine_id )
        REFERENCES cuisine ( id );

ALTER TABLE cuisineitem
    ADD CONSTRAINT cuisineitem_restaurant_fk FOREIGN KEY ( restaurant_id )
        REFERENCES restaurant ( id );

ALTER TABLE delivery
    ADD CONSTRAINT delivery_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( id );

ALTER TABLE deliveryaddress
    ADD CONSTRAINT deliveryaddress_delivery_fk FOREIGN KEY ( delivery_id )
        REFERENCES delivery ( id );

ALTER TABLE lineitem
    ADD CONSTRAINT lineitem_menuitem_fk FOREIGN KEY ( menuitem_id )
        REFERENCES menuitem ( id );

ALTER TABLE lineitem
    ADD CONSTRAINT lineitem_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( id );

ALTER TABLE loyaltypoint
    ADD CONSTRAINT loyaltypoint_menuitem_fk FOREIGN KEY ( menuitem_id )
        REFERENCES menuitem ( id );

ALTER TABLE menuitem
    ADD CONSTRAINT menuitem_dish_fk FOREIGN KEY ( dish_id )
        REFERENCES dish ( id );

ALTER TABLE menuitem
    ADD CONSTRAINT menuitem_restaurant_fk FOREIGN KEY ( restaurant_id )
        REFERENCES restaurant ( id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_user_fk FOREIGN KEY ( user_id )
        REFERENCES "User" ( id );

ALTER TABLE useraddress
    ADD CONSTRAINT useraddress_user_fk FOREIGN KEY ( user_id )
        REFERENCES "User" ( id )
            ON DELETE CASCADE;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                            16
-- ALTER TABLE                             32
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
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          12
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
