USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_Park_GreatSmokyMountains]    Script Date: 9/7/2023 6:20:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [etl].[Load_Park_GreatSmokyMountains]


AS
/*
PURPOSE:
Truncates and then loads information into the Park.GreatSmokyMountains table
Pulls essential info from Species Tables and inserts it to the Park table.

--Current state, not pulling info from plants

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--Herp information
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS #herp_base
CREATE TABLE #herp_base
	(
		UniqueID			VARCHAR(5),
		CommonName			VARCHAR(100),
		Class				VARCHAR(50),
		[Order]				VARCHAR(50),
		Family				VARCHAR(50),
		Abundance			VARCHAR(50),
		DailyActivity		VARCHAR(50),
		YearlyActivity		VARCHAR(50),
		IUCN				VARCHAR(50),
		Habitat				VARCHAR(max)
	)
	INSERT INTO #herp_base
		(
			 UniqueID
			,CommonName
			,Class
			,[Order]
			,Family
			,Abundance
			,DailyActivity
			,YearlyActivity
			,IUCN
			,Habitat
		)
		SELECT 
			 hps.UniqueID
			,hps.CommonName
			,hps.Class
			,hps.[Order]
			,hps.Family
			,hps.GreatSmokyMountains
			,hps.DailyActivity
			,hps.YearlyActivity
			,hps.IUCN
			,hps.Habitat
		FROM Species.Herps_current (NOLOCK) hps
		WHERE hps.GreatSmokyMountains IS NOT NULL

--------------------------------------------------------------------------------
--Fish information
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Fish_base
CREATE TABLE #Fish_base
	(
		UniqueID			VARCHAR(5),
		CommonName			VARCHAR(100),
		Class				VARCHAR(50),
		[Order]				VARCHAR(50),
		Family				VARCHAR(50),
		Abundance			VARCHAR(50),
		DailyActivity		VARCHAR(50),
		YearlyActivity		VARCHAR(50),
		IUCN				VARCHAR(50),
		Habitat				VARCHAR(max)
	)
	INSERT INTO #Fish_base
		(
			 UniqueID
			,CommonName
			,Class
			,[Order]
			,Family
			,Abundance
			,DailyActivity
			,YearlyActivity
			,IUCN
			,Habitat
		)
		SELECT 
			 fsh.UniqueID
			,fsh.CommonName
			,fsh.Class
			,fsh.[Order]
			,fsh.Family
			,fsh.GreatSmokyMountains
			,fsh.DailyActivity
			,fsh.YearlyActivity
			,fsh.IUCN
			,fsh.Habitat
		FROM Species.Fish_current (NOLOCK) fsh
		WHERE fsh.GreatSmokyMountains IS NOT NULL

--------------------------------------------------------------------------------
--Mammal information
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Mammals_base
CREATE TABLE #Mammals_base
	(
		UniqueID			VARCHAR(5),
		CommonName			VARCHAR(100),
		Class				VARCHAR(50),
		[Order]				VARCHAR(50),
		Family				VARCHAR(50),
		Abundance			VARCHAR(50),
		DailyActivity		VARCHAR(50),
		YearlyActivity		VARCHAR(50),
		IUCN				VARCHAR(50),
		Habitat				VARCHAR(max)
	)
	INSERT INTO #Mammals_base
		(
			 UniqueID
			,CommonName
			,Class
			,[Order]
			,Family
			,Abundance
			,DailyActivity
			,YearlyActivity
			,IUCN
			,Habitat
		)
		SELECT 
			 mam.UniqueID
			,mam.CommonName
			,mam.Class
			,mam.[Order]
			,mam.Family
			,mam.GreatSmokyMountains
			,mam.DailyActivity
			,mam.YearlyActivity
			,mam.IUCN
			,mam.Habitat
		FROM Species.Mammals_current (NOLOCK) mam
		WHERE mam.GreatSmokyMountains IS NOT NULL

--------------------------------------------------------------------------------
--Invert information
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Inverts_base
CREATE TABLE #Inverts_base
	(
		UniqueID			VARCHAR(5),
		CommonName			VARCHAR(100),
		Class				VARCHAR(50),
		[Order]				VARCHAR(50),
		Family				VARCHAR(50),
		Abundance			VARCHAR(50),
		DailyActivity		VARCHAR(50),
		YearlyActivity		VARCHAR(50),
		IUCN				VARCHAR(50),
		Habitat				VARCHAR(max)
	)
	INSERT INTO #Inverts_base
		(
			 UniqueID
			,CommonName
			,Class
			,[Order]
			,Family
			,Abundance
			,DailyActivity
			,YearlyActivity
			,IUCN
			,Habitat
		)
		SELECT 
			 inv.UniqueID
			,inv.CommonName
			,inv.Class
			,inv.[Order]
			,inv.Family
			,inv.GreatSmokyMountains
			,inv.DailyActivity
			,inv.YearlyActivity
			,inv.IUCN
			,inv.Habitat
		FROM Species.Inverts_current (NOLOCK) inv
		WHERE inv.GreatSmokyMountains IS NOT NULL

--------------------------------------------------------------------------------
--Bird information
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Birds_base
CREATE TABLE #Birds_base
	(
		UniqueID			VARCHAR(5),
		CommonName			VARCHAR(100),
		Class				VARCHAR(50),
		[Order]				VARCHAR(50),
		Family				VARCHAR(50),
		Abundance			VARCHAR(50),
		DailyActivity		VARCHAR(50),
		YearlyActivity		VARCHAR(50),
		IUCN				VARCHAR(50),
		Habitat				VARCHAR(max)
	)
	INSERT INTO #Birds_base
		(
			 UniqueID
			,CommonName
			,Class
			,[Order]
			,Family
			,Abundance
			,DailyActivity
			,YearlyActivity
			,IUCN
			,Habitat
		)
		SELECT 
			 brd.UniqueID
			,brd.CommonName
			,brd.Class
			,brd.[Order]
			,brd.Family
			,brd.GreatSmokyMountains
			,brd.DailyActivity
			,brd.YearlyActivity
			,brd.IUCN
			,brd.Habitat
		FROM Species.Birds_current (NOLOCK) brd
		WHERE brd.GreatSmokyMountains IS NOT NULL

--------------------------------------------------------------------------------
--Putting it all together, weeee
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS #temp_union
CREATE TABLE #temp_union
	(
		UniqueID			VARCHAR(5),
		CommonName			VARCHAR(100),
		Class				VARCHAR(50),
		[Order]				VARCHAR(50),
		Family				VARCHAR(50),
		Abundance			VARCHAR(50),
		DailyActivity		VARCHAR(50),
		YearlyActivity		VARCHAR(50),
		IUCN				VARCHAR(50),
		Habitat				VARCHAR(max)
	)
	INSERT INTO #temp_union
		(
			 UniqueID
			,CommonName
			,Class
			,[Order]
			,Family
			,Abundance
			,DailyActivity
			,YearlyActivity
			,IUCN
			,Habitat
		)
		SELECT * FROM #Herp_base
		UNION
		SELECT * FROM #Birds_base
		UNION
		SELECT * FROM #Inverts_base
		UNION
		SELECT * FROM #Mammals_base
		UNION
		SELECT * FROM #Fish_base

--Clear out whats in the table now, this is not a merge
TRUNCATE TABLE Park.GreatSmokyMountains
INSERT INTO Park.GreatSmokyMountains
SELECT * FROM #temp_union

--Display table after insert
SELECT * FROM Park.GreatSmokyMountains

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH