USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Refresh_ref_UniqueSpeciesID]    Script Date: 9/7/2023 6:38:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [etl].[Refresh_ref_UniqueSpeciesID]


AS
/*
PURPOSE:
Truncates ref.UniqueSpeciesID
Finds species from Species.All_current that are NOT in the ref.UniqueSpeciesID table and inserts them.
Tis just a refresh.

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------
TRUNCATE TABLE ref.UniqueSpeciesID
EXECUTE etl.Load_stg_InsertToUniqueSpeciesID

--show results  for ref.UniqueSpeciesID
SELECT * FROM ref.UniqueSpeciesID

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH