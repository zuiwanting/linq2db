DROP TABLE "Doctor"
GO

DROP TABLE "Patient"
GO

DROP TABLE "Person"
GO

CREATE TABLE "Person"
( 
	--PersonID   INTEGER PRIMARY KEY DEFAULT NEXTVAL('Seq'),
	"PersonID"   SERIAL PRIMARY KEY,
	"FirstName"  VARCHAR(50) NOT NULL,
	"LastName"   VARCHAR(50) NOT NULL,
	"MiddleName" VARCHAR(50),
	"Gender"     CHAR(1)     NOT NULL
)
GO

INSERT INTO "Person" ("FirstName", "LastName", "Gender") VALUES ('John',   'Pupkin',    'M')
GO
INSERT INTO "Person" ("FirstName", "LastName", "Gender") VALUES ('Tester', 'Testerson', 'M')
GO

-- Doctor Table Extension

CREATE TABLE "Doctor"
(
	"PersonID" INTEGER     references "Person"("PersonID") NOT NULL,
	"Taxonomy" VARCHAR(50) NOT NULL
)
GO

INSERT INTO "Doctor" ("PersonID", "Taxonomy") VALUES (1, 'Psychiatry')
GO

-- Patient Table Extension

CREATE TABLE "Patient"
(
	"PersonID"  INTEGER      references "Person"("PersonID") NOT NULL,
	"Diagnosis" VARCHAR(256) NOT NULL
)
GO

INSERT INTO "Patient" ("PersonID", "Diagnosis") VALUES (2, 'Hallucination with Paranoid Bugs'' Delirium of Persecution')
GO


CREATE OR REPLACE FUNCTION reverse(text) RETURNS text
	AS $_$
DECLARE
original alias for $1;
	reverse_str text;
	i int4;
BEGIN
	reverse_str := '';
	FOR i IN REVERSE LENGTH(original)..1 LOOP
		reverse_str := reverse_str || substr(original,i,1);
	END LOOP;
RETURN reverse_str;
END;$_$
	LANGUAGE plpgsql IMMUTABLE;
GO


DROP TABLE "Parent"
GO
DROP TABLE "Child"
GO
DROP TABLE "GrandChild"
GO

CREATE TABLE "Parent"      ("ParentID" int, "Value1" int)
GO
CREATE TABLE "Child"       ("ParentID" int, "ChildID" int)
GO
CREATE TABLE "GrandChild"  ("ParentID" int, "ChildID" int, "GrandChildID" int)
GO


DROP TABLE "LinqDataTypes"
GO

CREATE TABLE "LinqDataTypes"
(
	"ID"             int,
	"MoneyValue"     decimal(10,4),
	"DateTimeValue"  timestamp,
	"DateTimeValue2" timestamp,
	"BoolValue"      boolean,
	"GuidValue"      uuid,
	"BinaryValue"    bytea  NULL,
	"SmallIntValue"  smallint,
	"IntValue"       int    NULL,
	"BigIntValue"    bigint NULL
)
GO


DROP TABLE entity
GO

CREATE TABLE entity
(
	the_name character varying(255) NOT NULL,
	CONSTRAINT entity_name_key UNIQUE (the_name)
)
GO

CREATE OR REPLACE FUNCTION add_if_not_exists(p_name character varying)
	RETURNS void AS
$BODY$
BEGIN
	BEGIN
		insert into entity(the_name) values(p_name);
	EXCEPTION WHEN unique_violation THEN
		-- is exists, do nothing
	END;
END;
$BODY$
	LANGUAGE plpgsql;
GO


DROP TABLE "SequenceTest1"
GO

DROP TABLE "SequenceTest2"
GO

DROP TABLE "SequenceTest3"
GO

DROP SEQUENCE SequenceTestSeq
GO

CREATE SEQUENCE SequenceTestSeq INCREMENT 1 START 1
GO

DROP SEQUENCE "SequenceTest2_ID_seq"
GO

CREATE SEQUENCE "SequenceTest2_ID_seq" INCREMENT 1 START 1
GO

CREATE TABLE "SequenceTest1"
(
	"ID"    INTEGER PRIMARY KEY,
	"Value" VARCHAR(50)
)
GO

CREATE TABLE "SequenceTest2"
(
	"ID"    INTEGER PRIMARY KEY DEFAULT NEXTVAL('"SequenceTest2_ID_seq"'),
	"Value" VARCHAR(50)
)
GO

CREATE TABLE "SequenceTest3"
(
	"ID"    INTEGER PRIMARY KEY DEFAULT NEXTVAL('SequenceTestSeq'),
	"Value" VARCHAR(50)
)
GO


DROP TABLE "TestIdentity"
GO

DROP SEQUENCE "TestIdentity_ID_seq"
GO

CREATE SEQUENCE "TestIdentity_ID_seq" INCREMENT 1 START 1
GO

CREATE TABLE "TestIdentity" (
	"ID" INTEGER PRIMARY KEY DEFAULT NEXTVAL('"TestIdentity_ID_seq"')
)
GO


DROP TABLE AllTypes
GO

DROP TYPE color
GO

CREATE TYPE color AS ENUM ('Red', 'Green', 'Blue');
GO

CREATE TABLE AllTypes
(
	ID                  serial               NOT NULL PRIMARY KEY,

	bigintDataType      bigint                   NULL,
	numericDataType     numeric                  NULL,
	smallintDataType    smallint                 NULL,
	intDataType         int                      NULL,
	moneyDataType       money                    NULL,
	doubleDataType      double precision         NULL,
	realDataType        real                     NULL,

	timestampDataType   timestamp                NULL,
	timestampTZDataType timestamp with time zone NULL,
	dateDataType        date                     NULL,
	timeDataType        time                     NULL,
	timeTZDataType      time with time zone      NULL,
	intervalDataType    interval                 NULL,

	charDataType        char(1)                  NULL,
	varcharDataType     varchar(20)              NULL,
	textDataType        text                     NULL,

	binaryDataType      bytea                    NULL,

	uuidDataType        uuid                     NULL,
	bitDataType         bit(3)                   NULL,
	booleanDataType     boolean                  NULL,
	colorDataType       color                    NULL,

	pointDataType       point                    NULL,
	lsegDataType        lseg                     NULL,
	boxDataType         box                      NULL,
	pathDataType        path                     NULL,
	polygonDataType     polygon                  NULL,
	circleDataType      circle                   NULL,

	inetDataType        inet                     NULL,
	macaddrDataType     macaddr                  NULL,

	xmlDataType         xml                      NULL
)
GO

INSERT INTO AllTypes
(
	bigintDataType,
	numericDataType,
	smallintDataType,
	intDataType,
	moneyDataType,
	doubleDataType,
	realDataType,

	timestampDataType,
	timestampTZDataType,
	dateDataType,
	timeDataType,
	timeTZDataType,
	intervalDataType,

	charDataType,
	varcharDataType,
	textDataType,

	binaryDataType,

	uuidDataType,
	bitDataType,
	booleanDataType,
	colorDataType,

	pointDataType,
	lsegDataType,
	boxDataType,
	pathDataType,
	polygonDataType,
	circleDataType,

	inetDataType,
	macaddrDataType,

	xmlDataType
)
SELECT
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,

	NULL,

	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,

	NULL,
	NULL,

	NULL
UNION ALL
SELECT
	1000000,
	9999999,
	25555,
	7777777,
	100000,
	20.31,
	16.2,

	Cast('2012-12-12 12:12:12' as timestamp),
	Cast('2012-12-12 12:12:12-04' as timestamp with time zone),
	Cast('2012-12-12 12:12:12' as date),
	Cast('2012-12-12 12:12:12' as time),
	Cast('12:12:12' as time with time zone),
	Cast('1 3:05:20' as interval),

	'1',
	'234',
	'567',

	E'\\052'::bytea,

	Cast('6F9619FF-8B86-D011-B42D-00C04FC964FF' as uuid),
	B'101',
	true,
	'Green'::color,

	'(1,2)'::point,
	'((1,2),(3,4))'::lseg,
	'((1,2),(3,4))'::box,
	'((1,2),(3,4))'::path,
	'((1,2),(3,4))'::polygon,
	'((1,2),3)'::circle,

	'192.168.1.1'::inet,
	'01:02:03:04:05:06'::macaddr,

	XMLPARSE (DOCUMENT'<root><element strattr="strvalue" intattr="12345"/></root>')

GO
