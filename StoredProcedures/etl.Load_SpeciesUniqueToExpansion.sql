USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_SpeciesUniqueToExpansion]    Script Date: 9/7/2023 6:32:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [etl].[Load_SpeciesUniqueToExpansion]


AS
/*
PURPOSE:
Loads species into Species.SpeciesUniqueToExpansion

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
---------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS #Exp
CREATE TABLE #Exp
	(
		UniqueID						VARCHAR(5),
		CommonName						VARCHAR(100),
		ExpansionFlag					INT,
		MichiganIsleRoyale				VARCHAR(100),
		Everglades						VARCHAR(100),
		NorthCascadesOlympic			VARCHAR(100),
		Redwoods						VARCHAR(100),
		Yosemite						VARCHAR(100)
	)
	INSERT INTO #Exp
		(
			UniqueID,
			CommonName,
			ExpansionFlag,				
			MichiganIsleRoyale,	
			Everglades,			
			NorthCascadesOlympic,
			Redwoods,				
			Yosemite			
		)
		SELECT 
			UniqueID,
			CommonName,
			'1',
			MichiganIsleRoyale,	
			Everglades,			
			NorthCascadesOlympic,
			Redwoods,				
			Yosemite
		FROM Species.All_current
			WHERE 1=1
			AND MichiganSleepingBear IS NULL
			AND GreatSmokyMountains IS NULl
			AND Acadia IS NULL
			AND YellowstoneGrandTeton IS NULL
			AND Glacier IS NULL
			AND JoshuaTree IS NULL
			AND Zion IS NULL
			AND Saguaro IS NULL

TRUNCATE TABLE rpt.SpeciesUniqueToExpansion

INSERT INTO rpt.SpeciesUniqueToExpansion
SELECT * FROM #Exp

SELECT * FROM rpt.SpeciesUniqueToExpansion

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH