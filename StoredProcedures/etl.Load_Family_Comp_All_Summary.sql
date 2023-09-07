USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_Family_Comp_All_Summary]    Script Date: 9/7/2023 5:44:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [etl].[Load_Family_Comp_All_Summary]


AS
/*
PURPOSE:
Truncates and then loads information into the rpt.Family_Comp_All_Summary


--IMPORTANT Current state, not pulling info from plants

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

TRUNCATE TABLE rpt.Family_Comp_All_Summary
INSERT INTO rpt.Family_Comp_All_Summary
		SELECT * FROM rpt.Family_Comp_Acadia
		UNION
		SELECT * FROM rpt.Family_Comp_Everglades
		UNION
		SELECT * FROM rpt.Family_Comp_Glacier
		UNION
		SELECT * FROM rpt.Family_Comp_GreatSmokyMountains
		UNION
		SELECT * FROM rpt.Family_Comp_JoshuaTree
		UNION
		SELECT * FROM rpt.Family_Comp_MichiganIsleRoyale
		UNION
		SELECT * FROM rpt.Family_Comp_MichiganSleepingBear
		UNION
		SELECT * FROM rpt.Family_Comp_NorthCascadesOlympic
		UNION
		SELECT * FROM rpt.Family_Comp_Redwoods
		UNION
		SELECT * FROM rpt.Family_Comp_Saguaro
		UNION
		SELECT * FROM rpt.Family_Comp_YellowstoneGrandTeton
		UNION
		SELECT * FROM rpt.Family_Comp_Yosemite
		UNION
		SELECT * FROM rpt.Family_Comp_Zion

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
