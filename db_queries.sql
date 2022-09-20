-------------------------------------------------------------------------------
--- stg schema creation
-------------------------------------------------------------------------------

CREATE SCHEMA [stg]
AUTHORIZATION dbo

-------------------------------------------------------------------------------
--- stg pokemon table creation
-------------------------------------------------------------------------------

CREATE TABLE [stg].[pokemon]
(
	"id_pokemon" INT NULL,
	"name" VARCHAR(50) NULL,
	"height_dm" INT NULL,
	"weight_hg" INT NULL,
	"picture" NVARCHAR(255) NULL,
)

-------------------------------------------------------------------------------
--- dbo pokemon table creation
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[pokemon]
(
	"id_pokemon" INT NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	"height_dm" INT NOT NULL,
	"weight_hg" INT NOT NULL,
	"picture" NVARCHAR(255) NOT NULL,
)

-------------------------------------------------------------------------------
--- pokemon table procedure creation
-------------------------------------------------------------------------------
CREATE PROCEDURE dbo.pokemon_load
AS

-- DELETE CURRENT DATA OF IDS THAT WERE FILLED IN STG TABLE
DELETE db
FROM dbo.pokemon AS db
INNER JOIN stg.pokemon AS st
	ON db.id_pokemon = st.id_pokemon
WHERE st.[name] IS NOT NULL
	AND st.[height_dm] IS NOT NULL
	AND st.[weight_hg] IS NOT NULL
	AND st.[picture] IS NOT NULL

-- INSERT NEW DATA
INSERT INTO dbo.pokemon ([id_pokemon], [name], [height_dm], [weight_hg], [picture])
SELECT st.[id_pokemon],
	   st.[name],
	   st.[height_dm],
	   st.[weight_hg],
	   st.[picture]
FROM stg.pokemon AS st
LEFT JOIN dbo.pokemon AS db
	ON db.id_pokemon = st.id_pokemon
WHERE db.id_pokemon IS NULL 
	AND st.[name] IS NOT NULL
	AND st.[height_dm] IS NOT NULL
	AND st.[weight_hg] IS NOT NULL
	AND st.[picture] IS NOT NULL

-------------------------------------------------------------------------------
--- stg type table creation
-------------------------------------------------------------------------------
CREATE TABLE [stg].[types]
(
	"id_pokemon" INT NULL,
	"type" VARCHAR(50) NULL
)

-------------------------------------------------------------------------------
--- dbo type table creation
-------------------------------------------------------------------------------

CREATE TABLE [dbo].[types]
(
	"id_types" INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	"id_pokemon" INT NOT NULL,
	"type" VARCHAR(50) NOT NULL
)

-------------------------------------------------------------------------------
--- type table procedure creation
-------------------------------------------------------------------------------
CREATE PROCEDURE dbo.types_load
AS

-- DELETE CURRENT DATA OF IDS THAT WERE FILLED IN STG TABLE
DELETE db
FROM dbo.types AS db
INNER JOIN stg.types AS st
	ON db.id_pokemon = st.id_pokemon
WHERE st.[type] IS NOT NULL

-- INSERT NEW DATA
INSERT INTO dbo.types ([id_pokemon], [type])
SELECT st.[id_pokemon],
	   st.[type]
FROM stg.types AS st
LEFT JOIN dbo.types AS db
	ON db.id_pokemon = st.id_pokemon
WHERE db.id_pokemon IS NULL 
	AND st.[type] IS NOT NULL