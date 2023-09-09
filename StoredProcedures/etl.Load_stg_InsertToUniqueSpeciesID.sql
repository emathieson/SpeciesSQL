USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_stg_InsertToUniqueSpeciesID]    Script Date: 9/7/2023 4:48:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER PROCEDURE [etl].[Load_stg_InsertToUniqueSpeciesID]


AS
/*
PURPOSE:
This finds any species in any of the Species.####_current tables that is MISSING from the ref.UniqueSpeciesID table.
Loads these species into the stg.InsertToUniqueSpeciesID.
Then the stage table data is inserted into the reference table, ref.UniqueSpeciesID
(Was originally two separate etls, now combined)


LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------


--HERPS--------------------------------------------------------------------------
DROP TABLE IF EXISTS #MissingHerps
CREATE TABLE #MissingHerps
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100),
		Category		VARCHAR(20)
	)
	INSERT INTO #MissingHerps
		(
			UniqueID,
			CommonName,
			ScientificName,
			Category
		)
		SELECT	UniqueID,
				CommonName,
				ScientificName,
				'Herp'
				
		FROM Species.Herps_current (NOLOCK) hpc
			WHERE NOT EXISTS (
								SELECT UniqueID 
								FROM ref.UniqueSpeciesID (NOLOCK) spID
									WHERE hpc.UniqueID  = spID.UniqueID)


--FISH----------------------------------------------------------------------------
DROP TABLE IF EXISTS #MissingFish
CREATE TABLE #MissingFish
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100),
		Category		VARCHAR(20)
	)
	INSERT INTO #MissingFish
		(
			UniqueID,
			CommonName,
			ScientificName,
			Category
		)
		SELECT	UniqueID,
				CommonName,
				ScientificName,
				'Fish'
				
		FROM Species.Fish_current (NOLOCK) fsh
			WHERE NOT EXISTS (
								SELECT UniqueID 
								FROM ref.UniqueSpeciesID (NOLOCK) spID
									WHERE fsh.UniqueID  = spID.UniqueID)

--INVERTS------------------------------------------------------------------------
DROP TABLE IF EXISTS #MissingInverts
CREATE TABLE #MissingInverts
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100),
		Category		VARCHAR(20)
	)
	INSERT INTO #MissingInverts
		(
			UniqueID,
			CommonName,
			ScientificName,
			Category
		)
		SELECT	UniqueID,
				CommonName,
				ScientificName,
				'Invert'
				
		FROM Species.Inverts_current (NOLOCK) inv
			WHERE NOT EXISTS (
								SELECT UniqueID 
								FROM ref.UniqueSpeciesID (NOLOCK) spID
									WHERE inv.UniqueID  = spID.UniqueID)

--MAMMALS-------------------------------------------------------------------------
DROP TABLE IF EXISTS #MissingMammals
CREATE TABLE #MissingMammals
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100),
		Category		VARCHAR(20)
	)
	INSERT INTO #MissingMammals
		(
			UniqueID,
			CommonName,
			ScientificName,
			Category
		)
		SELECT	UniqueID,
				CommonName,
				ScientificName,
				'Mammal'
				
		FROM Species.Mammals_current (NOLOCK) mam
			WHERE NOT EXISTS (
								SELECT UniqueID 
								FROM ref.UniqueSpeciesID (NOLOCK) spID
									WHERE mam.UniqueID  = spID.UniqueID)

--PLANTS--------------------------------------------------------------------------
DROP TABLE IF EXISTS #MissingPlants
CREATE TABLE #MissingPlants
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100),
		Category		VARCHAR(20)
	)
	INSERT INTO #MissingPlants
		(
			UniqueID,
			CommonName,
			ScientificName,
			Category
		)
		SELECT	UniqueID,
				CommonName,
				ScientificName,
				'Plant'
				
		FROM Species.Plants_current (NOLOCK) plt
			WHERE NOT EXISTS (
								SELECT UniqueID 
								FROM ref.UniqueSpeciesID (NOLOCK) spID
									WHERE plt.UniqueID  = spID.UniqueID)


--BIRDS--------------------------------------------------------------------------
DROP TABLE IF EXISTS #MissingBirds
CREATE TABLE #MissingBirds
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100),
		Category		VARCHAR(20)
	)
	INSERT INTO #MissingBirds
		(
			UniqueID,
			CommonName,
			ScientificName,
			Category
		)
		SELECT	UniqueID,
				CommonName,
				ScientificName,
				'Bird'
				
		FROM Species.Birds_current (NOLOCK) bds
			WHERE NOT EXISTS (
								SELECT UniqueID 
								FROM ref.UniqueSpeciesID (NOLOCK) spID
									WHERE bds.UniqueID  = spID.UniqueID)

DROP TABLE IF EXISTS #TempToInsert
CREATE TABLE #TempToInsert
	(
		UniqueID		VARCHAR(5),
		CommonName		VARCHAR(100),
		ScientificName	VARCHAR(100)
	)
	INSERT INTO #TempToInsert
		(
			UniqueID,
			CommonName,
			ScientificName
		)
		SELECT UniqueID, CommonName, ScientificName FROM #MissingHerps
		UNION
		SELECT UniqueID, CommonName, ScientificName FROM #MissingFish
		UNION
		SELECT UniqueID, CommonName, ScientificName FROM #MissingInverts
		UNION
		SELECT UniqueID, CommonName, ScientificName FROM #MissingMammals
		UNION
		SELECT UniqueID, CommonName, ScientificName FROM #MissingPlants
		UNION
		SELECT UniqueID, CommonName, ScientificName FROM #MissingBirds

TRUNCATE TABLE stg.InsertToUniqueSpeciesID

INSERT INTO stg.InsertToUniqueSpeciesID
SELECT * FROM #TempToInsert

INSERT INTO ref.UniqueSpeciesID
SELECT * FROM stg.InsertToUniqueSpeciesID

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH