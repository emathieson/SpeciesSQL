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
--My variation of etl logging for troubleshooting
--ProcRunLog DECLARES
DECLARE @ObjectName			SYSNAME		= OBJECT_NAME(@@PROCID)
DECLARE @ObjectStart		DATETIME2	= GETDATE()
DECLARE @RowsReturned		INT			= NULL
DECLARE @ObjectEnd			DATETIME2	= NULL
DECLARE @RunLogID			BIGINT		= NULL

--ProcRunLog START
EXEC util.RunLog_Insert @ObjectName,@ObjectStart,@ObjectEnd,@RowsReturned,@RunLogID,@RunLogIdOutput = @RunLogID OUTPUT

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

--ProcRunLog SET after values
SET @RowsReturned		= @@ROWCOUNT
SET @ObjectEnd			= GETDATE()

--ProcRunLog "UPDATE" logs via RunLog_Insert
EXEC util.RunLog_Insert @ObjectName,@ObjectStart,@ObjectEnd,@RowsReturned,@RunLogID

END TRY

BEGIN CATCH
	--ProcErrLog "UPDATE" logs via ErrorLog_Insert
	EXEC util.ErrorLog_Insert @RunLogID

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH

