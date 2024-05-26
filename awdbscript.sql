CREATE DATABASE ADVENTUREWORKS;
USE ADVENTUREWORKS;

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREATE_TABLES`()
BEGIN

/*HERE ARE THE VARIABLES WE DECLARED FOR CAPTURING THE INFORMATION*/
DECLARE TABLE_COUNT INT;
DECLARE OPERATION_TYPE VARCHAR(50);
DECLARE LOG_DETAILS VARCHAR(50);
DECLARE PROCESS_NAME VARCHAR(30);
SET OPERATION_TYPE = 'CREATING THE TABLE FOR ALL THE LAYERS';
SET PROCESS_NAME = 'SP_CREATE_TABLES';


/*THIS IS THE AUDIT TABLE WHERE WE WILL CATURE ALL THE OPERATION DETAILS FOR AUDITING*/
DROP TABLE IF EXISTS TBL_SYS_AUDIT_CONTROL_AW;
CREATE TABLE TBL_SYS_AUDIT_CONTROL_AW
(
OPID INT PRIMARY KEY AUTO_INCREMENT, 
SOURCE_NAME VARCHAR(30),
TARGET_NAME VARCHAR(30),
PROCESS_NAME VARCHAR(30),
OPERATION_TYPE VARCHAR(50),
SOURCE_COUNT INT,
TARGET_COUNT INT, 
LOG_DETAILS VARCHAR(50),
OPERATED_BY VARCHAR(20),
OPERATION_DATE TIMESTAMP
);

/*THIS IS THE CUSTOMER HOP1 TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_CUSTOMERS_HOP1;
CREATE TABLE TBL_TRANS_CUSTOMERS_HOP1
(
CUSTOMERKEY INT,
CUSTOMERNAME VARCHAR(35),
BIRTHDATE DATE,
AGE INT,
MARITALSTATUS VARCHAR(10),
GENDER VARCHAR(20),
EMAILADDRESS VARCHAR(35),
ANNUALINCOME INT, 
TOTALCHILDREN INT, 
EDUCATIONLEVEL VARCHAR(20),
OCCUPATION VARCHAR(15),
HOMEOWNER VARCHAR(5)
);

/*THIS IS THE PRODUCT HOP1 TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_PRODUCTS_HOP1;
CREATE TABLE TBL_TRANS_PRODUCTS_HOP1
(PRODUCTKEY INT,
PRODUCTSUBCATEGORYKEY INT,
PRODUCTSKU VARCHAR(10),
PRODUCTNAME VARCHAR(35),
MODELNAME VARCHAR(30),
PRODUCTDESCRIPTION VARCHAR(225),
PRODUCTCOLOR VARCHAR(15),
PRODUCTSIZE VARCHAR(2),
PRODUCTSTYLE VARCHAR(1),
PRODUCTCOST DECIMAL(6,2),
PRODUCTPRICE DECIMAL(6,2)
);

/*THIS IS THE PRODUCT CATEGORY HOP1 TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_PRD_CAT_HOP1;
CREATE TABLE TBL_TRANS_PRD_CAT_HOP1
(PRODUCTCATEGORYKEY INT,
CATEGORYNAME VARCHAR(15)
);

/*THIS IS THE PRODUCT SUB CATEGORY HOP1 TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_PRD_SUB_CAT_HOP1;
CREATE TABLE TBL_TRANS_PRD_SUB_CAT_HOP1
(PRODUCTSUBCATEGORYKEY INT,
SUBCATEGORYNAME VARCHAR(20),
PRODUCTCATEGORYKEY INT
);

/*THIS IS THE TERRITORY HOP1 TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_TERRITORY_HOP1;
CREATE TABLE TBL_TRANS_TERRITORY_HOP1
(TERRITORYKEY INT,
REGION VARCHAR(15),
COUNTRY VARCHAR(15),
CONTINENT VARCHAR(15)
);

/*THIS IS THE SALES HOP1 TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_SALES_HOP1;
CREATE TABLE TBL_TRANS_SALES_HOP1(
ORDERDATE DATE,
STOCKDATE DATE, 
ORDERNUMBER VARCHAR(10),
PRODUCTKEY INT, 
CUSTOMERKEY INT,
TERRITORYKEY INT,
ORDERLINEITEM INT,
ORDERQUANTITY INT
);

/*THIS IS THE CUSTOMER HOP2 TABLE WHERE WE WILL CREATE THE NEW COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_CUSTOMERS_HOP2;
CREATE TABLE TBL_TRANS_CUSTOMERS_HOP2(
CUSTOMERKEY INT,
CUSTOMERNAME VARCHAR(35),
BIRTHDATE DATE,
AGE INT, 
MARITALSTATUS VARCHAR(10),
GENDER VARCHAR(20),
EMAILADDRESS VARCHAR(35),
ANNUALINCOME INT,
TOTALCHILDREN INT,
EDUCATIONLEVEL VARCHAR(20),
OCCUPATION VARCHAR(15),
HOMEOWNER VARCHAR(5),
CUSTOMERTYPE VARCHAR(10));

/*THIS IS THE SALES HOP2 TABLE WHERE WE WILL CREATE THE NEW COLUMNS*/
DROP TABLE IF EXISTS TBL_TRANS_SALES_HOP2;
CREATE TABLE TBL_TRANS_SALES_HOP2(
ORDERDATE DATE,
STOCKDATE DATE, 
ORDERNUMBER VARCHAR(10),
PRODUCTKEY INT, 
CUSTOMERKEY INT,
TERRITORYKEY INT,
ORDERLINEITEM INT,
ORDERQUANTITY INT,
SALES DECIMAL(6,2),
PROFIT DECIMAL(6,2)
);

/*Final Layer Tables*/

/*THIS IS THE SALES FNL TABLE WHERE WE WILL CREATE THE NEW COLUMNS*/
DROP TABLE IF EXISTS TBL_FNL_SALES;
CREATE TABLE TBL_FNL_SALES(
ORDERDATE DATE,
STOCKDATE DATE, 
ORDERNUMBER VARCHAR(10),
PRODUCTKEY INT, 
CUSTOMERKEY INT,
TERRITORYKEY INT,
ORDERLINEITEM INT,
ORDERQUANTITY INT,
SALES DECIMAL(6,2),
PROFIT DECIMAL(6,2)
);


/*THIS IS THE TERRITORY FNL TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_FNL_TERRITORY;
CREATE TABLE TBL_FNL_TERRITORY
(TERRITORYKEY INT,
REGION VARCHAR(15),
COUNTRY VARCHAR(15),
CONTINENT VARCHAR(15)
);


/*THIS IS THE CUSTOMER FNL TABLE WHERE WE WILL CREATE THE NEW COLUMNS*/
DROP TABLE IF EXISTS TBL_FNL_CUSTOMERS;
CREATE TABLE TBL_FNL_CUSTOMERS(
CUSTOMERKEY INT,
CUSTOMERNAME VARCHAR(35),
BIRTHDATE DATE,
AGE INT, 
MARITALSTATUS VARCHAR(10),
GENDER VARCHAR(20),
EMAILADDRESS VARCHAR(35),
ANNUALINCOME INT,
TOTALCHILDREN INT,
EDUCATIONLEVEL VARCHAR(20),
OCCUPATION VARCHAR(15),
HOMEOWNER VARCHAR(5),
CUSTOMERTYPE VARCHAR(10));


DROP TABLE IF EXISTS TBL_FNL_PRODUCTS;
CREATE TABLE TBL_FNL_PRODUCTS
(PRODUCTKEY INT,
PRODUCTSUBCATEGORYKEY INT,
PRODUCTSKU VARCHAR(10),
PRODUCTNAME VARCHAR(35),
MODELNAME VARCHAR(30),
PRODUCTDESCRIPTION VARCHAR(225),
PRODUCTCOLOR VARCHAR(15),
PRODUCTSIZE VARCHAR(2),
PRODUCTSTYLE VARCHAR(1),
PRODUCTCOST DECIMAL(6,2),
PRODUCTPRICE DECIMAL(6,2)
);


/*THIS IS THE PRODUCT SUB CATEGORY FNL TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_FNL_PRD_SUB_CAT;
CREATE TABLE TBL_FNL_PRD_SUB_CAT
(PRODUCTSUBCATEGORYKEY INT,
SUBCATEGORYNAME VARCHAR(20),
PRODUCTCATEGORYKEY INT
);


/*THIS IS THE PRODUCT CATEGORY FNL TABLE WHERE WE WILL MAKE THE CHANGES IN THE EXISTING COLUMNS*/
DROP TABLE IF EXISTS TBL_FNL_PRD_CAT;
CREATE TABLE TBL_FNL_PRD_CAT
(PRODUCTCATEGORYKEY INT,
CATEGORYNAME VARCHAR(15)
);


/*CHECKING THE COUNT OF TABLES FOR CREATING THE LOG ENTRIES*/
SELECT COUNT(*)  INTO TABLE_COUNT  FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'adventureworks';

IF TABLE_COUNT = 23 THEN 
	SET LOG_DETAILS  = 'ALL THE TABLE CREATED SUCCESSFULLY';
ELSE
	SET LOG_DETAILS = 'THERE IS A MISMATCH IN THE TABLE COUNTS';
END IF;


/*INSERTING THE LOG DETAILS IN THE AUDIT TABLE*/
INSERT INTO TBL_SYS_AUDIT_CONTROL_AW
(
PROCESS_NAME,
OPERATION_TYPE,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(PROCESS_NAME,
OPERATION_TYPE,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

END ;



CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOAD_HOP1`()
BEGIN

DECLARE SOURCE_TABLE VARCHAR(30);
DECLARE TARGET_TABLE VARCHAR(30);
DECLARE SOURCE_COUNT INT;
DECLARE TARGET_COUNT INT;
DECLARE PROCESS_NAME VARCHAR(30);
DECLARE OPERATION_TYPE VARCHAR(50);
DECLARE LOG_DETAILS VARCHAR(50);


/*This is the population of the customer table*/

SELECT 'TBL_STG_CUSTOMERS' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_CUSTOMERS_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 CUSTOMER TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_CUSTOMERS;
TRUNCATE TBL_TRANS_CUSTOMERS_HOP1;
INSERT INTO TBL_TRANS_CUSTOMERS_HOP1
SELECT 
CUSTOMERKEY, 
CONCAT(IFNULL(PREFIX,'NA.'), FIRSTNAME, ' ', LASTNAME) CUSTOMERNAME,
BIRTHDATE,
DATEDIFF(CURRENT_DATE(),BIRTHDATE)/365 AGE,
CASE WHEN MARITALSTATUS  = 'S' THEN 'SINGLE' ELSE 'MARRIED' END MARITALSTATUS,
CASE WHEN GENDER='F' THEN 'FEMALE'
	 WHEN GENDER='M' THEN 'MALE'
     ELSE 'DID NOT DISCLOSE' 
END GENDER,
EMAILADDRESS,
ANNUALINCOME,
TOTALCHILDREN,
EDUCATIONLEVEL,
OCCUPATION,
CASE WHEN HOMEOWNER='Y' THEN 'YES' ELSE 'NO' END HOMEOWNER
FROM TBL_STG_CUSTOMERS;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_CUSTOMERS_HOP1;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

/*This is the population of the product table*/

SELECT 'TBL_STG_PRD' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_PRODUCTS_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 PRODUCT TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_PRD;
TRUNCATE TBL_TRANS_PRODUCTS_HOP1;
INSERT INTO TBL_TRANS_PRODUCTS_HOP1
SELECT 
PRODUCTKEY,
PRODUCTSUBCATEGORYKEY,
PRODUCTSKU,
PRODUCTNAME,
MODELNAME,
PRODUCTDESCRIPTION,
PRODUCTCOLOR,
PRODUCTSIZE,
PRODUCTSTYLE,
PRODUCTCOST,
PRODUCTPRICE
FROM TBL_STG_PRD;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_PRODUCTS_HOP1;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);


/*This is the population of the product category table*/

SELECT 'TBL_STG_PRDCAT' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_PRD_CAT_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 PRODUCT CATEGORY TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_PRDCAT;
TRUNCATE TBL_TRANS_PRD_CAT_HOP1;
INSERT INTO TBL_TRANS_PRD_CAT_HOP1
SELECT 
PRODUCTCATEGORYKEY,
CATEGORYNAME
FROM TBL_STG_PRDCAT;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_PRD_CAT_HOP1;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);



/*This is the population of the product subcategory table*/

SELECT 'TBL_STG_PRDSUBCAT' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_PRD_SUB_CAT_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 PRODUCT SUBCATEGORY TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_PRDSUBCAT;
TRUNCATE TBL_TRANS_PRD_SUB_CAT_HOP1;
INSERT INTO TBL_TRANS_PRD_SUB_CAT_HOP1
SELECT 
PRODUCTSUBCATEGORYKEY,
SUBCATEGORYNAME,
PRODUCTCATEGORYKEY
FROM TBL_STG_PRDSUBCAT;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_PRD_SUB_CAT_HOP1;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);


/*This is the population of the territory table*/

SELECT 'TBL_STG_TERRITORY' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_TERRITORY_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 TERRITORY TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_TERRITORY;
TRUNCATE TBL_TRANS_TERRITORY_HOP1;
INSERT INTO TBL_TRANS_TERRITORY_HOP1
SELECT 
SALESTERRITORYKEY,
REGION,
COUNTRY,
CONTINENT
FROM TBL_STG_TERRITORY;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_TERRITORY_HOP1;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

/*This is the population of the sales 2015 table*/

SELECT 'TBL_STG_SALES_2015' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_SALES_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 SALES TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_SALES_2015;
TRUNCATE TBL_TRANS_SALES_HOP1;
INSERT INTO TBL_TRANS_SALES_HOP1
SELECT 
ORDERDATE,
STOCKDATE, 
ORDERNUMBER,
PRODUCTKEY, 
CUSTOMERKEY,
TERRITORYKEY,
ORDERLINEITEM,
ORDERQUANTITY
FROM TBL_STG_SALES_2015;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_SALES_HOP1 WHERE YEAR(ORDERDATE)=2015;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

/*This is the population of the sales 2016 table*/

SELECT 'TBL_STG_SALES_2016' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_SALES_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 SALES TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_SALES_2016;

INSERT INTO TBL_TRANS_SALES_HOP1
SELECT 
ORDERDATE,
STOCKDATE, 
ORDERNUMBER,
PRODUCTKEY, 
CUSTOMERKEY,
TERRITORYKEY,
ORDERLINEITEM,
ORDERQUANTITY
FROM TBL_STG_SALES_2016;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_SALES_HOP1 WHERE YEAR(ORDERDATE)=2016;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

/*This is the population of the sales 2017 table*/

SELECT 'TBL_STG_SALES_2017' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_SALES_HOP1' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP1 SALES TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP1';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_STG_SALES_2017;

INSERT INTO TBL_TRANS_SALES_HOP1
SELECT 
ORDERDATE,
STOCKDATE, 
ORDERNUMBER,
PRODUCTKEY, 
CUSTOMERKEY,
TERRITORYKEY,
ORDERLINEITEM,
ORDERQUANTITY
FROM TBL_STG_SALES_2017;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_SALES_HOP1 WHERE YEAR(ORDERDATE)=2017;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

END ;



CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOAD_HOP2`()
BEGIN
DECLARE SOURCE_TABLE VARCHAR(30);
DECLARE TARGET_TABLE VARCHAR(30);
DECLARE SOURCE_COUNT INT;
DECLARE TARGET_COUNT INT;
DECLARE PROCESS_NAME VARCHAR(30);
DECLARE OPERATION_TYPE VARCHAR(50);
DECLARE LOG_DETAILS VARCHAR(50);


/*This is the population of the customer table*/

SELECT 'TBL_TRANS_CUSTOMERS_HOP1' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_CUSTOMERS_HOP2' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP2 CUSTOMER TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP2';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_CUSTOMERS_HOP1;
TRUNCATE TBL_TRANS_CUSTOMERS_HOP2;
INSERT INTO TBL_TRANS_CUSTOMERS_HOP2
SELECT 
CUST.CUSTOMERKEY,
CUST.CUSTOMERNAME,
CUST.BIRTHDATE,
CUST.AGE,
CUST.MARITALSTATUS,
CUST.GENDER,
CUST.EMAILADDRESS,
CUST.ANNUALINCOME,
CUST.TOTALCHILDREN,
CUST.EDUCATIONLEVEL,
CUST.OCCUPATION,
CUST.HOMEOWNER,
CASE WHEN TBL.PROFIT>4000 THEN "PLATINUM"
	 WHEN TBL.PROFIT>=2000 AND TBL.PROFIT<=4000 THEN "GOLD"
     WHEN TBL.PROFIT>=1000 AND TBL.PROFIT<2000 THEN "SILVER"
     WHEN TBL.PROFIT>=0 AND TBL.PROFIT<1000 THEN "BRONZE"
     ELSE "PROSPECTS"
END 
CUSTOMERTYPE
FROM TBL_TRANS_CUSTOMERS_HOP1 CUST
INNER JOIN 
(SELECT CUST.CUSTOMERKEY, SUM((PRODUCTPRICE-PRODUCTCOST)*ORDERQUANTITY) PROFIT FROM TBL_TRANS_CUSTOMERS_HOP1 CUST 
LEFT OUTER JOIN TBL_TRANS_SALES_HOP1 SALES 
ON CUST.CUSTOMERKEY = SALES.CUSTOMERKEY
LEFT OUTER JOIN TBL_TRANS_PRODUCTS_HOP1 PRD 
ON SALES.PRODUCTKEY = PRD.PRODUCTKEY
GROUP BY CUST.CUSTOMERKEY) TBL
ON CUST.CUSTOMERKEY= TBL.CUSTOMERKEY;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_CUSTOMERS_HOP2;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);


/*This is the population of the sales table*/

SELECT 'TBL_TRANS_SALES_HOP1' INTO SOURCE_TABLE;
SELECT 'TBL_TRANS_SALES_HOP2' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING HOP2 CUSTOMER TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_HOP2';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_SALES_HOP1;
TRUNCATE TBL_TRANS_SALES_HOP2;
INSERT INTO TBL_TRANS_SALES_HOP2
SELECT 
SALES.ORDERDATE,
SALES.STOCKDATE,
SALES.ORDERNUMBER,
SALES.PRODUCTKEY,
SALES.CUSTOMERKEY,
SALES.TERRITORYKEY,
SALES.ORDERLINEITEM,
SALES.ORDERQUANTITY,
PRD.PRODUCTPRICE * SALES.ORDERQUANTITY SALES,
(PRD.PRODUCTPRICE - PRD.PRODUCTCOST) * SALES.ORDERQUANTITY PROFIT
FROM TBL_TRANS_SALES_HOP1 SALES 
INNER JOIN TBL_TRANS_PRODUCTS_HOP1 PRD 
ON SALES.PRODUCTKEY = PRD.PRODUCTKEY;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_TRANS_SALES_HOP2;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);
END ;



CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOAD_FNL`()
BEGIN

DECLARE SOURCE_TABLE VARCHAR(30);
DECLARE TARGET_TABLE VARCHAR(30);
DECLARE SOURCE_COUNT INT;
DECLARE TARGET_COUNT INT;
DECLARE PROCESS_NAME VARCHAR(30);
DECLARE OPERATION_TYPE VARCHAR(50);
DECLARE LOG_DETAILS VARCHAR(50);


/*This is the population of the customer table*/

SELECT 'TBL_TRANS_CUSTOMERS_HOP2' INTO SOURCE_TABLE;
SELECT 'TBL_FNL_CUSTOMERS' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING FINAL CUSTOMER TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_FNL';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_CUSTOMERS_HOP2;

INSERT INTO TBL_FNL_CUSTOMERS
SELECT 
CUSTOMERKEY, 
CUSTOMERNAME,
BIRTHDATE,
AGE,
MARITALSTATUS,
GENDER,
EMAILADDRESS,
ANNUALINCOME,
TOTALCHILDREN,
EDUCATIONLEVEL,
OCCUPATION,
HOMEOWNER,
CUSTOMERTYPE
FROM TBL_TRANS_CUSTOMERS_HOP2;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_FNL_CUSTOMERS;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

/*This is the population of the product table*/

SELECT 'TBL_TRANS_PRODUCTS_HOP1' INTO SOURCE_TABLE;
SELECT 'TBL_FNL_PRODUCTS' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING FINAL PRODUCT TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_FNL';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_PRODUCTS_HOP1;

INSERT INTO TBL_FNL_PRODUCTS
SELECT 
PRODUCTKEY,
PRODUCTSUBCATEGORYKEY,
PRODUCTSKU,
PRODUCTNAME,
MODELNAME,
PRODUCTDESCRIPTION,
PRODUCTCOLOR,
PRODUCTSIZE,
PRODUCTSTYLE,
PRODUCTCOST,
PRODUCTPRICE
FROM TBL_TRANS_PRODUCTS_HOP1;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_FNL_PRODUCTS;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);


/*This is the population of the product category table*/

SELECT 'TBL_TRANS_PRD_CAT_HOP1' INTO SOURCE_TABLE;
SELECT 'TBL_FNL_PRD_CAT' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING FINAL PRODUCT CATEGORY TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_FNL';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_PRD_CAT_HOP1;

INSERT INTO TBL_FNL_PRD_CAT
SELECT 
PRODUCTCATEGORYKEY,
CATEGORYNAME
FROM TBL_TRANS_PRD_CAT_HOP1;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_FNL_PRD_CAT;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);



/*This is the population of the product subcategory table*/

SELECT 'TBL_TRANS_PRD_SUB_CAT_HOP1' INTO SOURCE_TABLE;
SELECT 'TBL_FNL_PRD_SUB_CAT' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING FINAL PRODUCT SUBCAT TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_FNL';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_PRD_SUB_CAT_HOP1;

INSERT INTO TBL_FNL_PRD_SUB_CAT
SELECT 
PRODUCTSUBCATEGORYKEY,
SUBCATEGORYNAME,
PRODUCTCATEGORYKEY
FROM TBL_TRANS_PRD_SUB_CAT_HOP1;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_FNL_PRD_SUB_CAT;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);


/*This is the population of the territory table*/

SELECT 'TBL_TRANS_TERRITORY_HOP1' INTO SOURCE_TABLE;
SELECT 'TBL_FNL_TERRITORY' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING FINAL TERRITORY TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_FNL';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_TERRITORY_HOP1;

INSERT INTO TBL_FNL_TERRITORY
SELECT 
TERRITORYKEY,
REGION,
COUNTRY,
CONTINENT
FROM TBL_TRANS_TERRITORY_HOP1;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_FNL_TERRITORY;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

/*This is the population of the sales table*/


SELECT 'TBL_TRANS_SALES_HOP2' INTO SOURCE_TABLE;
SELECT 'TBL_FNL_SALES' INTO TARGET_TABLE;
SET OPERATION_TYPE = 'LOADING FINAL SALES TABLE WITH LOGICS';
SET PROCESS_NAME = 'SP_LOAD_FNL';

SELECT COUNT(*) INTO SOURCE_COUNT FROM TBL_TRANS_SALES_HOP2;

INSERT INTO TBL_FNL_SALES
SELECT 
ORDERDATE,
STOCKDATE, 
ORDERNUMBER,
PRODUCTKEY, 
CUSTOMERKEY,
TERRITORYKEY,
ORDERLINEITEM,
ORDERQUANTITY,
SALES,
PROFIT
FROM TBL_TRANS_SALES_HOP2;

SELECT COUNT(*) INTO TARGET_COUNT FROM TBL_FNL_SALES;

IF SOURCE_COUNT <> TARGET_COUNT THEN
	SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
ELSE 
	SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
END IF;

INSERT INTO TBL_SYS_AUDIT_CONTROL_AW 
(SOURCE_NAME,
TARGET_NAME,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(SOURCE_TABLE,
TARGET_TABLE,
PROCESS_NAME,
OPERATION_TYPE,
SOURCE_COUNT,
TARGET_COUNT,
LOG_DETAILS,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

END ;


CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CONSTRAINTS_ENABLE`()
BEGIN

DECLARE PROCESS_NAME VARCHAR(30);
DECLARE OPERATION_TYPE VARCHAR(50);
DECLARE LOG_DETAILS VARCHAR(50);

SET OPERATION_TYPE = 'ADDING CONSTRAINTS';
SET PROCESS_NAME = 'SP_CONSTRAINTS_ENABLE';

/*CREATING ALL THE PRIMARY KEYS*/
ALTER TABLE TBL_FNL_CUSTOMERS ADD CONSTRAINT PK_CUS_KEY PRIMARY KEY (CUSTOMERKEY);
ALTER TABLE TBL_FNL_TERRITORY ADD CONSTRAINT PK_TER_KEY PRIMARY KEY (TERRITORYKEY);
ALTER TABLE TBL_FNL_PRODUCTS ADD CONSTRAINT PK_PRD_KEY PRIMARY KEY (PRODUCTKEY);
ALTER TABLE TBL_FNL_PRD_SUB_CAT ADD CONSTRAINT PK_SUB_KEY PRIMARY KEY (PRODUCTSUBCATEGORYKEY);
ALTER TABLE TBL_FNL_PRD_CAT ADD CONSTRAINT PK_CAT_KEY PRIMARY KEY (PRODUCTCATEGORYKEY);
ALTER TABLE TBL_FNL_SALES ADD CONSTRAINT PK_SALES_KEY PRIMARY KEY (CUSTOMERKEY,TERRITORYKEY,PRODUCTKEY,ORDERNUMBER);

/*CREATING ALL THE FOREIGN KEYS*/
ALTER TABLE TBL_FNL_SALES ADD CONSTRAINT FK_CUS_KEY FOREIGN KEY (CUSTOMERKEY) REFERENCES TBL_FNL_CUSTOMERS (CUSTOMERKEY);
ALTER TABLE TBL_FNL_SALES ADD CONSTRAINT FK_PRD_KEY FOREIGN KEY (PRODUCTKEY) REFERENCES TBL_FNL_PRODUCTS (PRODUCTKEY);
ALTER TABLE TBL_FNL_SALES ADD CONSTRAINT FK_TER_KEY FOREIGN KEY (TERRITORYKEY) REFERENCES TBL_FNL_TERRITORY (TERRITORYKEY);
ALTER TABLE TBL_FNL_PRODUCTS ADD CONSTRAINT FK_PRD_SUB_KEY FOREIGN KEY (PRODUCTSUBCATEGORYKEY) REFERENCES TBL_FNL_PRD_SUB_CAT (PRODUCTSUBCATEGORYKEY);
ALTER TABLE TBL_FNL_PRD_SUB_CAT ADD CONSTRAINT FK_PRD_CAT_KEY FOREIGN KEY (PRODUCTCATEGORYKEY) REFERENCES TBL_FNL_PRD_CAT (PRODUCTCATEGORYKEY);


INSERT INTO TBL_SYS_AUDIT_CONTROL_AW
(PROCESS_NAME,
OPERATION_TYPE,
OPERATED_BY,
OPERATION_DATE
)
VALUES 
(PROCESS_NAME,
OPERATION_TYPE,
CURRENT_USER(),
CURRENT_TIMESTAMP()
);

END ;


CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MASTER_SCRIPT`(IN STEP_TYPE VARCHAR(50), OUT OUTPUT VARCHAR(50))
BEGIN

IF STEP_TYPE = 'SP_CREATE_TABLES' THEN 
		CALL SP_CREATE_TABLES();
        SET OUTPUT = 'SP_CREATE_TABLES RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_LOAD_HOP1' THEN 
		CALL SP_LOAD_HOP1();
        SET OUTPUT = 'SP_LOAD_HOP1 RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_LOAD_HOP2' THEN 
		CALL SP_LOAD_HOP2();
        SET OUTPUT = 'SP_LOAD_HOP2 RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_LOAD_FNL' THEN 
		CALL SP_LOAD_FNL();
        SET OUTPUT = 'SP_LOAD_FNL RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_CONSTRAINTS_ENABLE' THEN 
		CALL SP_CONSTRAINTS_ENABLE();
        SET OUTPUT = 'SP_CONSTRAINTS_ENABLE RAN SUCCESSFULLY';
ELSE 
		SET OUTPUT = 'GIVE THE CORRECT VALUE';
END IF;
END ;




/*Create Views*/
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `adventureworks`.`vw_customerlifetimevalue` AS
    SELECT 
        `tbl`.`customerkey` AS `customerkey`,
        `tbl`.`customername` AS `customername`,
        `tbl`.`total_sales` AS `total_sales`,
        `tbl`.`total_orders` AS `total_orders`,
        `tbl`.`lifetime_value` AS `lifetime_value`
    FROM
        (SELECT 
            `c`.`customerkey` AS `customerkey`,
                `c`.`customername` AS `customername`,
                SUM(`s`.`SALES`) AS `total_sales`,
                COUNT(`s`.`ORDERNUMBER`) AS `total_orders`,
                (SUM(`s`.`SALES`) / COUNT(DISTINCT `s`.`ORDERNUMBER`)) AS `lifetime_value`
        FROM
            ((SELECT 
            `adventureworks`.`tbl_fnl_customers`.`CUSTOMERKEY` AS `customerkey`,
                `adventureworks`.`tbl_fnl_customers`.`CUSTOMERNAME` AS `customername`
        FROM
            `adventureworks`.`tbl_fnl_customers`
        WHERE
            (`adventureworks`.`tbl_fnl_customers`.`flag` = 1)) `c`
        LEFT JOIN `adventureworks`.`tbl_fnl_sales` `s` ON ((`c`.`customerkey` = `s`.`CUSTOMERKEY`)))
        GROUP BY `c`.`customerkey` , `c`.`customername`) `tbl`;
		
		
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `adventureworks`.`vw_customerrentionchurn` AS
    SELECT 
        `c`.`customerkey` AS `customerkey`,
        `c`.`customername` AS `customername`,
        MAX(`s`.`ORDERDATE`) AS `last_order_date`,
        (TO_DAYS(CURDATE()) - TO_DAYS(MAX(`s`.`ORDERDATE`))) AS `days_since_last_order`,
        (CASE
            WHEN ((TO_DAYS(CURDATE()) - TO_DAYS(MAX(`s`.`ORDERDATE`))) > 365) THEN 'Churned'
            ELSE 'Active'
        END) AS `customer_status`
    FROM
        ((SELECT 
            `adventureworks`.`tbl_fnl_customers`.`CUSTOMERKEY` AS `customerkey`,
                `adventureworks`.`tbl_fnl_customers`.`CUSTOMERNAME` AS `customername`
        FROM
            `adventureworks`.`tbl_fnl_customers`
        WHERE
            (`adventureworks`.`tbl_fnl_customers`.`flag` = 1)) `c`
        LEFT JOIN `adventureworks`.`tbl_fnl_sales` `s` ON ((`s`.`CUSTOMERKEY` = `c`.`customerkey`)))
    GROUP BY `c`.`customerkey` , `c`.`customername`;