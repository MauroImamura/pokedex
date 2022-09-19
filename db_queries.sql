CREATE TABLE [dbo].[pokemon]
(
	"id" INT NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"height" INT NOT NULL,
	"weight" INT NOT NULL,
	"picture" NVARCHAR(255) NOT NULL,
)

CREATE SCHEMA [stg]
AUTHORIZATION dbo

CREATE TABLE [stg].[pokemon]
(
	"id" INT NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"height" INT NOT NULL,
	"weight" INT NOT NULL,
	"picture" NVARCHAR(255) NOT NULL,
)