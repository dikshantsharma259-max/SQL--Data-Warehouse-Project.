--Create Database and schemas--
--The scripts contains the creation of database 'DATAWAREHOUSE' --
--with Three Schemas ='Bronze','Gold','silver'
--Each represent the level of Data cleaning and modification --

USE MASTER;
GO


IF EXIST(SELECT 1 FROM sys.database WHERE name='DATAWAREHOUSE')
  BEGIN
  ALTER  DATABASE DATAWAREHOUSE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE DATAWAREHOUSE;
END;
GO
  
  
CREATE DATABASE DATAWAREHOUSE;

USE DATAWAREHOUSE;
GO

CREATE SCHEMA Bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA Gold;
GO
