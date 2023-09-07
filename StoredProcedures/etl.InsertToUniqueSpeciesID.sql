USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[InsertToUniqueSpeciesID]    Script Date: 9/7/2023 4:39:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [etl].[InsertToUniqueSpeciesID]


AS
/*
Loads species into ref.UniqueSpeciesID from stg.InsertToUniqueSpeciesID

**NOTE** This is what actually inserts the missing species into the ref table.
Needs to be executed AFTER [etl].[Load_stg_InsertToUniqueSpeciesID]
*/

BEGIN TRY

--Utility RunLog declarations
DECLARE @ObjectStartDateTime			DATETIME2	= GETDATE()
DECLARE @ObjectID						INT			= @@PROCID
DECLARE @ObjectName						SYSNAME		= OBJECT_NAME(@@PROCID)
DECLARE @RowsReturned					INT			= NULL
DECLARE @ObjectEndDateTime				DATETIME2	= NULL
DECLARE @RunLogID						BIGINT		= NULL

--Utility RunLog entry
EXEC util.Insert_RunLog @ObjectName,@ObjectStartDateTime,@ObjectEndDateTime,@RowsReturned,@RunLogID,@RunLogIdOut = @RunLogID OUTPUT

------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

INSERT INTO ref.UniqueSpeciesID
SELECT * FROM stg.InsertToUniqueSpeciesID

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------

--Setting some RunLog values
SET @RowsReturned		= @@ROWCOUNT
SET @ObjectEndDateTime	= GETDATE()

--Utility RunLog update
EXEC util.Insert_RunLog @ObjectName,@ObjectStartDateTime,@ObjectEndDateTime,@RowsReturned,@RunLogID

END TRY

BEGIN CATCH
	EXEC util.Insert_ErrorLog @RunLogID

	DECLARE @ErrMessage		NVARCHAR(4000)		= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT					= ERROR_SEVERITY()
	DECLARE @ErrState		INT					= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)
END CATCH

GO


