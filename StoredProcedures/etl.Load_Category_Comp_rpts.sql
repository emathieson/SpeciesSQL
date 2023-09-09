USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_Category_Comp_rpts]    Script Date: 9/7/2023 5:39:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [etl].[Load_Category_Comp_rpts]


AS
/*
PURPOSE:
Loads information into all of the rpt.Comp_### tables for categories of species.
Uses information from the rpt.Comp_Park reports

--IMPORTANT! Currently not loading plants.

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

----------------------------------------------
--HERPS
----------------------------------------------
DROP TABLE IF EXISTS #herps_comp
CREATE  TABLE #herps_comp
	(
		Park					VARCHAR(80),
		Category				VARCHAR(40),
		[Count]					FLOAT,
		[Park Composition %]	FLOAT,
		UniqueToPark			INT
	)
	INSERT INTO #herps_comp
	(
		Park,
		Category,
		[Count],
		[Park Composition %],
		UniqueToPark
	)
		SELECT * FROM rpt.Comp_MichiganSleepingBear
		UNION
		SELECT * FROM rpt.Comp_GreatSmokyMountains
		UNION
		SELECT * FROM rpt.Comp_Acadia
		UNION
		SELECT * FROM rpt.Comp_YellowstoneGrandTeton
		UNION
		SELECT * FROM rpt.Comp_Glacier
		UNION
		SELECT * FROM rpt.Comp_JoshuaTree
		UNION
		SELECT * FROM rpt.Comp_Zion
		UNION
		SELECT * FROM rpt.Comp_Saguaro
		UNION
		SELECT * FROM rpt.Comp_MichiganIsleRoyale
		UNION
		SELECT * FROM rpt.Comp_Everglades
		UNION
		SELECT * FROM rpt.Comp_NorthCascadesOlympic
		UNION
		SELECT * FROM rpt.Comp_Redwoods
		UNION
		SELECT * FROM rpt.Comp_Yosemite
	
	-----------------------------
TRUNCATE TABLE rpt.Comp_Herps

INSERT INTO rpt.Comp_Herps
SELECT * FROM #herps_comp
WHERE Category = 'Herps'

SELECT * FROM rpt.Comp_Herps
ORDER BY [Count] DESC
--------------------------------------------------------------------------------------------

----------------------------------------------
--FISH
----------------------------------------------
DROP TABLE IF EXISTS #fish_comp
CREATE  TABLE #fish_comp
	(
		Park					VARCHAR(80),
		Category				VARCHAR(40),
		[Count]					FLOAT,
		[Park Composition %]	FLOAT,
		UniqueToPark			INT
	)
	INSERT INTO #fish_comp
	(
		Park,
		Category,
		[Count],
		[Park Composition %],
		UniqueToPark
	)
		SELECT * FROM rpt.Comp_MichiganSleepingBear
		UNION
		SELECT * FROM rpt.Comp_GreatSmokyMountains
		UNION
		SELECT * FROM rpt.Comp_Acadia
		UNION
		SELECT * FROM rpt.Comp_YellowstoneGrandTeton
		UNION
		SELECT * FROM rpt.Comp_Glacier
		UNION
		SELECT * FROM rpt.Comp_JoshuaTree
		UNION
		SELECT * FROM rpt.Comp_Zion
		UNION
		SELECT * FROM rpt.Comp_Saguaro
		UNION
		SELECT * FROM rpt.Comp_MichiganIsleRoyale
		UNION
		SELECT * FROM rpt.Comp_Everglades
		UNION
		SELECT * FROM rpt.Comp_NorthCascadesOlympic
		UNION
		SELECT * FROM rpt.Comp_Redwoods
		UNION
		SELECT * FROM rpt.Comp_Yosemite

-----------------------------
TRUNCATE TABLE rpt.Comp_Fish

INSERT INTO rpt.Comp_Fish
SELECT * FROM #fish_comp
WHERE Category = 'Fish'

SELECT * FROM rpt.Comp_Fish
ORDER BY [Count] DESC
--------------------------------------------------------------------------------------------

----------------------------------------------
--Birds
----------------------------------------------
DROP TABLE IF EXISTS #birds_comp
CREATE  TABLE #birds_comp
	(
		Park					VARCHAR(80),
		Category				VARCHAR(40),
		[Count]					FLOAT,
		[Park Composition %]	FLOAT,
		UniqueToPark			INT
	)
	INSERT INTO #birds_comp
	(
		Park,
		Category,
		[Count],
		[Park Composition %],
		UniqueToPark
	)
		SELECT * FROM rpt.Comp_MichiganSleepingBear
		UNION
		SELECT * FROM rpt.Comp_GreatSmokyMountains
		UNION
		SELECT * FROM rpt.Comp_Acadia
		UNION
		SELECT * FROM rpt.Comp_YellowstoneGrandTeton
		UNION
		SELECT * FROM rpt.Comp_Glacier
		UNION
		SELECT * FROM rpt.Comp_JoshuaTree
		UNION
		SELECT * FROM rpt.Comp_Zion
		UNION
		SELECT * FROM rpt.Comp_Saguaro
		UNION
		SELECT * FROM rpt.Comp_MichiganIsleRoyale
		UNION
		SELECT * FROM rpt.Comp_Everglades
		UNION
		SELECT * FROM rpt.Comp_NorthCascadesOlympic
		UNION
		SELECT * FROM rpt.Comp_Redwoods
		UNION
		SELECT * FROM rpt.Comp_Yosemite

-----------------------------
TRUNCATE TABLE rpt.Comp_Birds

INSERT INTO rpt.Comp_Birds
SELECT * FROM #birds_comp
WHERE Category = 'Birds'

SELECT * FROM rpt.Comp_Birds
ORDER BY [Count] DESC
--------------------------------------------------------------------------------------------

----------------------------------------------
--Inverts
----------------------------------------------
DROP TABLE IF EXISTS #inverts_comp
CREATE  TABLE #inverts_comp
	(
		Park					VARCHAR(80),
		Category				VARCHAR(40),
		[Count]					FLOAT,
		[Park Composition %]	FLOAT,
		UniqueToPark			INT
	)
	INSERT INTO #inverts_comp
	(
		Park,
		Category,
		[Count],
		[Park Composition %],
		UniqueToPark
	)
		SELECT * FROM rpt.Comp_MichiganSleepingBear
		UNION
		SELECT * FROM rpt.Comp_GreatSmokyMountains
		UNION
		SELECT * FROM rpt.Comp_Acadia
		UNION
		SELECT * FROM rpt.Comp_YellowstoneGrandTeton
		UNION
		SELECT * FROM rpt.Comp_Glacier
		UNION
		SELECT * FROM rpt.Comp_JoshuaTree
		UNION
		SELECT * FROM rpt.Comp_Zion
		UNION
		SELECT * FROM rpt.Comp_Saguaro
		UNION
		SELECT * FROM rpt.Comp_MichiganIsleRoyale
		UNION
		SELECT * FROM rpt.Comp_Everglades
		UNION
		SELECT * FROM rpt.Comp_NorthCascadesOlympic
		UNION
		SELECT * FROM rpt.Comp_Redwoods
		UNION
		SELECT * FROM rpt.Comp_Yosemite

-----------------------------
TRUNCATE TABLE rpt.Comp_Inverts

INSERT INTO rpt.Comp_Inverts
SELECT * FROM #inverts_comp
WHERE Category = 'Inverts'

SELECT * FROM rpt.Comp_Inverts
ORDER BY [Count] DESC
--------------------------------------------------------------------------------------------

----------------------------------------------
--Mammals
----------------------------------------------
DROP TABLE IF EXISTS #mammals_comp
CREATE  TABLE #mammals_comp
	(
		Park					VARCHAR(80),
		Category				VARCHAR(40),
		[Count]					FLOAT,
		[Park Composition %]	FLOAT,
		UniqueToPark			INT
	)
	INSERT INTO #mammals_comp
	(
		Park,
		Category,
		[Count],
		[Park Composition %],
		UniqueToPark
	)
		SELECT * FROM rpt.Comp_MichiganSleepingBear
		UNION
		SELECT * FROM rpt.Comp_GreatSmokyMountains
		UNION
		SELECT * FROM rpt.Comp_Acadia
		UNION
		SELECT * FROM rpt.Comp_YellowstoneGrandTeton
		UNION
		SELECT * FROM rpt.Comp_Glacier
		UNION
		SELECT * FROM rpt.Comp_JoshuaTree
		UNION
		SELECT * FROM rpt.Comp_Zion
		UNION
		SELECT * FROM rpt.Comp_Saguaro
		UNION
		SELECT * FROM rpt.Comp_MichiganIsleRoyale
		UNION
		SELECT * FROM rpt.Comp_Everglades
		UNION
		SELECT * FROM rpt.Comp_NorthCascadesOlympic
		UNION
		SELECT * FROM rpt.Comp_Redwoods
		UNION
		SELECT * FROM rpt.Comp_Yosemite

-----------------------------
TRUNCATE TABLE rpt.Comp_Mammals

INSERT INTO rpt.Comp_Mammals
SELECT * FROM #mammals_comp
WHERE Category = 'Mammals'

SELECT * FROM rpt.Comp_Mammals
ORDER BY [Count] DESC

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH