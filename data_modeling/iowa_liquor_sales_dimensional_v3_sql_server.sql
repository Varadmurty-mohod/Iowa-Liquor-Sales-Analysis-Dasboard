-- Iowa_Liqur_Sales Dimensional Model
-- 2022-11-06 V1 to be extended
-- r sherman
-- SQL Server

-- CREATE DATABASE Iowa_Liquor_Sales;

-- DROP TABLE FCT_Iowa_County_Population_By_Year;
-- DROP TABLE FCT_Iowa_City_Population_By_Year;
-- DROP TABLE FCT_Iowa_Liquor_Sales_Invoice_Header;
-- DROP TABLE FCT_Iowa_Liquor_Sales_Invoice_lineitem;

-- DROP TABLE Dim_Iowa_Liquor_Geo;
-- DROP TABLE Dim_Iowa_Liquor_Products;
-- DROP TABLE Dim_Iowa_Liquor_Vendors;
-- DROP TABLE Dim_Iowa_Liquor_Product_Categories;
-- DROP TABLE Dim_Iowa_Liquor_Stores;
-- DROP TABLE Dim_Date;
-- DROP TABLE Dim_Iowa_County;
-- DROP TABLE Dim_Iowa_City;

CREATE TABLE FCT_Iowa_Liquor_Sales_Invoice_Header(

	Invoice_Number   varchar(24) NOT NULL,   -- Header
	Invoice_Date     datetime not NULL,
	InvoiceDate_SK   int not null,
	Store_SK int NULL,
	Store_Number int NULL,

	Invoice_Bottles_Sold        int NULL,		
	Invoice_Sale_Dollars        numeric(19,4) NULL,    
	Invoice_Volume_Sold_Liters  numeric(19,4) NULL,
	Invoice_Volume_Sold_Gallons numeric(19,4) NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Invoice_Number)
);
	
CREATE TABLE FCT_Iowa_Liquor_Sales_Invoice_lineitem(

	Invoice_Number         varchar(24) NOT NULL,   -- Header
	Invoice_Number_LineNo  int NULL,
	Invoice_Item_Number    varchar(24) NOT NULL,
	
                Item_SK                    int                NOT NULL,      
	Item_Number            varchar(24) NULL,
		
                Pack                           int NULL,
	Bottle_Volume_ml       int NULL,
	State_Bottle_Cost      numeric(19,4) NULL,
	State_Bottle_Retail    numeric(19,4) NULL,

	Bottles_Sold           int NULL,		
	Sale_Dollars           numeric(19,4) NULL,
	Volume_Sold_Liters     numeric(19,4) NULL,
	Volume_Sold_Gallons    numeric(19,4) NULL,
	
	
	DI_JobID varchar(256)   NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Invoice_Item_Number)
);

CREATE TABLE Dim_Iowa_Liquor_Products (

    Item_SK int NOT NULL identity(1,1), -- Piyush updated
	Item_Number int NOT NULL,
	Item_Number_C varchar(20) NULL,
	Item_Description varchar(80) NULL,
		
	Category_SK int NULL,
	Vendor_SK int NOT NULL,
	
	Bottle_Volume_ml int NULL,
	Pack int NULL,
	Inner_Pack int NULL,
	Age int NULL,
	Proof int NULL,
	List_Date date NULL,
	
	UPC varchar(20) NULL,
	SCC varchar(20) NULL,
	
	State_Bottle_Cost decimal(19,4) NULL,
	State_Case_Cost decimal(19,4) NULL,
	State_Bottle_Retail decimal(19,4) NULL,
	
	Report_Date date NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Item_SK)
);

CREATE TABLE Dim_Iowa_Liquor_Vendors (
	-- Vendor_SK int NOT NULL, -- piyush commented and added insert for SK column on 4/3/2023
	Vendor_SK int NOT NULL identity(1,1), -- Piyush updated
	Vendor_Number int NOT NULL,
	Vendor_Name   varchar(80) NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Vendor_SK)
);

CREATE TABLE Dim_Iowa_Liquor_Product_Categories (
	
	Category_SK     int NOT NULL identity(1,1),
	Category_Number int NOT NULL,
	Category_Name   varchar(40) NULL,
		
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Category_SK)
);

CREATE TABLE Dim_Iowa_Liquor_Stores (

	-- Store_SK int NOT NULL, -- Piyush commented to add identity(1,1)
	Store_SK int NOT NULL identity(1,1),
	Store_ID int NOT NULL,
	Store_Name varchar(80) NULL,
	Store_Status char(1) NULL,
	Address varchar(80) NULL,
	Zip_Code int NULL,
	City_SK int NOT NULL,        -- added 2022-11-09
	County_SK int NOT NULL,   -- added 2022-11-09
	-- Geo_SK int  null,    -- use city_sk and county_sk instead 2022-11-09
	--  Store_Address varchar(80) NULL,   -- skip? 2022-11-09
	Report_Date datetime NULL,
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Store_SK)
);

CREATE TABLE Dim_Iowa_Liquor_Geo (    -- do not use  2022-11-09
	Geo_SK int not null identity(1,1),
	-- City_SK int UNIQUE NOT NULL,    -- added 2022-11-07
	City_SK int NOT NULL,
	City     varchar(20) NULL,   
	Zip_Code int NULL,
	-- County_SK int UNIQUE NOT NULL,   -- added 2022-11-07
	County_SK int NOT NULL,
	County  varchar(24) NULL,
	State    varchar(20) NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Geo_SK)
);


CREATE TABLE FCT_Iowa_City_Population_By_Year (

                City_Pop_SK int not null identity(1,1),
	City_SK int not null,
	City varchar(24) NULL,
	FIPS int NULL,
	DataAsOf datetime NULL,
	Population_Year int NULL,
	Population int NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (City_Pop_SK)
);

CREATE TABLE FCT_Iowa_County_Population_By_Year (

                County_Pop_SK int not null identity(1,1),
	County_SK int not null,
	County varchar(80) NULL,
	FIPS int NULL,
	DateAsOf date NULL,
	Population_Year int NULL,
	Population int NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (County_Pop_SK)
);

CREATE TABLE Dim_Date(

                Date_SK int not null,  -- YYYMMDD
	Date_NK date NULL,     -- date
	Date_Year int NULL,    -- YYYY

	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (Date_SK)
);

------------------- 2022-11-07

CREATE TABLE Dim_Iowa_County (

	County_SK int not null identity(1,1),
	County varchar(80) NULL,
	FIPS int NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (County_SK)
);

CREATE TABLE Dim_Iowa_City(

	City_SK int not null identity(1,1),
	City varchar(24) NULL,
	FIPS int NULL,
	
	DI_JobID varchar(256) NULL,
	DI_CreateDate datetime not NULL default getdate(),
	PRIMARY KEY (City_SK)
);
GO

-- Constraints

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_Header
-- ADD CONSTRAINT Store_FK FOREIGN KEY (Store_SK) REFERENCES Dim_Iowa_Liquor_Stores (Store_SK)
-- ON DELETE CASCADE ON UPDATE CASCADE;
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_Header
-- ADD CONSTRAINT Invoice_Date_FK FOREIGN KEY (InvoiceDate_SK) REFERENCES Dim_Date (Date_SK)
-- ON DELETE CASCADE ON UPDATE CASCADE;
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Stores
-- ADD CONSTRAINT City_FK_1 FOREIGN KEY (City_SK) REFERENCES Dim_Iowa_Liquor_Geo (City_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Stores
-- ADD CONSTRAINT County_FK_1 FOREIGN KEY (County_SK) REFERENCES Dim_Iowa_Liquor_Geo (County_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Geo
-- ADD CONSTRAINT City_FK_2 FOREIGN KEY (City_SK) REFERENCES Dim_Iowa_City (City_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Geo
-- ADD CONSTRAINT County_FK_2 FOREIGN KEY (County_SK) REFERENCES Dim_Iowa_County (County_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.FCT_Iowa_City_Population_By_Year
-- ADD CONSTRAINT City_FK_3 FOREIGN KEY (City_SK) REFERENCES Dim_Iowa_City (City_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.FCT_Iowa_County_Population_By_Year
-- ADD CONSTRAINT County_FK_3 FOREIGN KEY (County_SK) REFERENCES Dim_Iowa_County (County_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_lineitem
-- ADD CONSTRAINT Invoice_Number_FK FOREIGN KEY (Invoice_Number) REFERENCES FCT_Iowa_Liquor_Sales_Invoice_Header (Invoice_Number)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_lineitem
-- ADD CONSTRAINT Item_Number_FK FOREIGN KEY (Item_SK) REFERENCES Dim_Iowa_Liquor_Products (Item_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Products
-- ADD CONSTRAINT Category_FK FOREIGN KEY (Category_SK) REFERENCES Dim_Iowa_Liquor_Product_Categories (Category_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Products
-- ADD CONSTRAINT Vendor_FK FOREIGN KEY (Vendor_SK) REFERENCES Dim_Iowa_Liquor_Vendors (Vendor_SK)
-- ON DELETE NO ACTION ON UPDATE NO ACTION;
-- GO

-- Drop Constraints
-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_Header
-- DROP CONSTRAINT Store_FK
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_Header
-- DROP CONSTRAINT Invoice_Date_FK
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Stores
-- DROP CONSTRAINT City_FK_1
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Stores
-- DROP CONSTRAINT County_FK_1
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Geo
-- DROP CONSTRAINT City_FK_2
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Geo
-- DROP CONSTRAINT County_FK_2
-- GO

-- ALTER TABLE dbo.FCT_Iowa_City_Population_By_Year
-- DROP CONSTRAINT City_FK_3
-- GO

-- ALTER TABLE dbo.FCT_Iowa_City_Population_By_Year
-- DROP CONSTRAINT County_FK_3
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_lineitem
-- DROP CONSTRAINT Invoice_Number_FK
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_lineitem
-- DROP CONSTRAINT Item_Number_FK
-- GO

-- ALTER TABLE dbo.FCT_Iowa_Liquor_Sales_Invoice_lineitem
-- DROP CONSTRAINT Invoice_Number
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Products
-- DROP CONSTRAINT Category_FK
-- GO

-- ALTER TABLE dbo.Dim_Iowa_Liquor_Products
-- DROP CONSTRAINT Vendor_FK
-- GO

-- Views

-- create view Dim_InvoiceDate as
-- SELECT
-- 	date_sk as InvoiceDate_SK,
-- 	date_nk as Invoice_Date,
--    	Date_Year as Invoice_Year
-- FROM Iowa_Liquor_Sales_DIM.dbo.Dim_Date;