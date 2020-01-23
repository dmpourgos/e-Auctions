CREATE SCHEMA TED;

CREATE TABLE TED.AUCTIONS (ITEM_ID INTEGER   NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), "NAME" VARCHAR(1000) NOT NULL, CURRENTLY DOUBLE NOT NULL, BUY_PRICE DOUBLE, FIRST_BID DOUBLE NOT NULL, NUMBER_OF_BIDS INTEGER DEFAULT 0  NOT NULL, COUNTRY VARCHAR(50) NOT NULL, LOCATION VARCHAR(1000) NOT NULL, LATITUDE DOUBLE, LONGITUDE DOUBLE, STARTED TIMESTAMP NOT NULL, ENDS TIMESTAMP NOT NULL, USERNAME VARCHAR(1000) NOT NULL, DESCRIPTION VARCHAR(10000) NOT NULL, BUYER VARCHAR(1000), SENT_MESSAGE INTEGER DEFAULT 0  NOT NULL, PRIMARY KEY (ITEM_ID));




CREATE TABLE TED.BIDS (USERNAME VARCHAR(1000) NOT NULL, "TIME" TIMESTAMP NOT NULL, AMOUNT DOUBLE NOT NULL, ITEM_ID INTEGER NOT NULL, PRIMARY KEY (USERNAME, "TIME", ITEM_ID));



CREATE TABLE TED.CATEGORIES (CATEGORY VARCHAR(150) NOT NULL, PRIMARY KEY (CATEGORY));


CREATE TABLE TED.ITEM_TO_CATEGORY (ITEM_ID INTEGER NOT NULL, CATEGORY VARCHAR(150) NOT NULL, PRIMARY KEY (CATEGORY, ITEM_ID));



CREATE TABLE TED.USERS (USERNAME VARCHAR(1000) NOT NULL, PASSWORD VARCHAR(30) NOT NULL, "NAME" VARCHAR(30) NOT NULL, SURNAME VARCHAR(30) NOT NULL, EMAIL VARCHAR(60) NOT NULL, PHONE VARCHAR(15) NOT NULL, CITY VARCHAR(50) NOT NULL, ADDRESS VARCHAR(30) NOT NULL, "NUMBER" INTEGER NOT NULL, TK INTEGER NOT NULL, INFOS INTEGER NOT NULL, ACCEPTED INTEGER NOT NULL, AFM VARCHAR(30) NOT NULL, "ROLE" INTEGER NOT NULL, COUNTRY VARCHAR(50), S_RATING INTEGER DEFAULT 0  NOT NULL, B_RATING INTEGER DEFAULT 0  NOT NULL, LOCATION VARCHAR(1000), PRIMARY KEY (USERNAME));


CREATE TABLE TED.IMAGES (ITEM_ID INTEGER NOT NULL, IMAGE_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), IMAGE BLOB NOT NULL, CONTENT_TYPE VARCHAR(50), CONTENT_LENGTH DOUBLE, PRIMARY KEY (ITEM_ID, IMAGE_ID));


CREATE TABLE TED.MESSAGES (MESSAGE_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), SENDER VARCHAR(1000) NOT NULL, RECEIVER VARCHAR(1000) NOT NULL, THEME VARCHAR(60) NOT NULL, IS_READ INTEGER DEFAULT 0  NOT NULL, CONTENT VARCHAR(1000) NOT NULL, "TIME" TIMESTAMP, "TYPE" INTEGER, DELETED_SENDER INTEGER DEFAULT 0  NOT NULL, DELETED_RECEIVER INTEGER DEFAULT 0  NOT NULL, PRIMARY KEY (MESSAGE_ID));



ALTER TABLE TED.AUCTIONS ADD FOREIGN KEY(USERNAME) REFERENCES TED.USERS;


ALTER TABLE TED.BIDS ADD FOREIGN KEY(USERNAME) REFERENCES TED.USERS;
ALTER TABLE TED.BIDS ADD FOREIGN KEY(ITEM_ID) REFERENCES TED.AUCTIONS;
ALTER TABLE TED.ITEM_TO_CATEGORY ADD FOREIGN KEY(ITEM_ID) REFERENCES TED.AUCTIONS;
ALTER TABLE TED.ITEM_TO_CATEGORY ADD FOREIGN KEY(CATEGORY) REFERENCES TED.CATEGORIES;
ALTER TABLE TED.AUCTIONS ADD FOREIGN KEY(BUYER) REFERENCES TED.USERS;

ALTER TABLE TED.MESSAGES ADD FOREIGN KEY(SENDER) REFERENCES TED.USERS;
ALTER TABLE TED.MESSAGES ADD FOREIGN KEY(RECEIVER) REFERENCES TED.USERS;

INSERT INTO TED.USERS (USERNAME, PASSWORD, "NAME", SURNAME, EMAIL, PHONE, CITY, ADDRESS, "NUMBER", TK, INFOS, ACCEPTED, AFM, "ROLE", COUNTRY, S_RATING, B_RATING, LOCATION) 
	VALUES ('admin', 'admin', 'name', 'surname', 'asd@as.ds', '12', 'asfd', 'asf', 1, 23, 0, 1, '13', 1, 'sdgv', 0, 0, 'cvh');

INSERT INTO TED.USERS (USERNAME, PASSWORD, "NAME", SURNAME, EMAIL, PHONE, CITY, ADDRESS, "NUMBER", TK, INFOS, ACCEPTED, AFM, "ROLE", COUNTRY, S_RATING, B_RATING, LOCATION) 
	VALUES ('null', 'null', 'name', 'surname', 'asd@as.ds', '12', 'asfd', 'asf', 1, 23, 0, 1, '13', 2, 'sdgv', 0, 0, 'cvh');



