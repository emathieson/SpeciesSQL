USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_AllParksAllCurrent]    Script Date: 9/7/2023 5:37:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [etl].[Load_AllParksAllCurrent]


AS
/*
PURPOSE:
This executes all etl.Load_Park_#### procedures.

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

EXECUTE etl.Load_Park_MichiganSleepingBear
EXECUTE etl.Load_Park_GreatSmokyMountains
EXECUTE etl.Load_Park_Acadia
EXECUTE etl.Load_Park_YellowstoneGrandTeton
EXECUTE etl.Load_Park_Glacier
EXECUTE etl.Load_Park_JoshuaTree
EXECUTE etl.Load_Park_Zion
EXECUTE etl.Load_Park_Saguaro
EXECUTE etl.Load_Park_MichiganIsleRoyale
EXECUTE etl.Load_Park_Everglades
EXECUTE etl.Load_Park_NorthCascadesOlympic
EXECUTE etl.Load_Park_Redwoods
EXECUTE etl.Load_Park_Yosemite

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------

END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH