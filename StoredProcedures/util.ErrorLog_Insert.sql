USE [Beta]
GO

/****** Object:  StoredProcedure [util].[ErrorLog_Insert]    Script Date: 9/7/2023 6:41:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   PROCEDURE [util].[ErrorLog_Insert]
(
	@RunLogID		BIGINT	= NULL
)


AS
/*
PURPOSE:
My version of etl logging for troubleshooting.
Based off a familiar process :)

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN

------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------
--Sanity check
IF @RunLogID IS NOT NULL

BEGIN

	UPDATE util.RunLog WITH (TABLOCK)
	SET
		 ObjectEnd				= GETDATE()
		,RunTimeSeconds			= DATEDIFF(SECOND, ObjectStart, GETDATE())
		,ErrMessage				= ERROR_MESSAGE()
		,RecordUpdateDateTime	= GETDATE()

		WHERE RunLogID = @RunLogId
END

------------------------------------------------------------------------------end yeehaw------------------------------------------------------------------------------------------------------


END 
GO


