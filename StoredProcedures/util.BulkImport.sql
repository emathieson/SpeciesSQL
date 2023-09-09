USE [Beta]
GO

/****** Object:  StoredProcedure [util].[BulkImport]    Script Date: 9/7/2023 6:39:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE OR ALTER PROCEDURE [util].[BulkImport]
(
@Table VARCHAR(100),
@FileName VARCHAR(100),
@Truncate VARCHAR(5)

)

AS
/*
PURPOSE:
This is a bulk insert tool.
Fill out the variables and you can easily bulk insert into a pre-existing table

Table is the table name, including the schema, but without the database name.
FileName is the base file name WITHOUT the .csv text. Files should be placed here: C:\Users\emily\Documents\SQL\BULK INSERT FILES
Truncate is either True or False

EXAMPLE:

	USE [Beta]
	GO
	
	DECLARE @RC int
	DECLARE @Table varchar(100)
	DECLARE @FileName varchar(100)
	DECLARE @Truncate varchar(5)
	
	-- TODO: Set parameter values here.
	
	EXECUTE @RC = [util].[BulkImport] 
	   @Table		= 'Beta.Species.Fish_current'
	  ,@FileName	= 'fish.bulk.090423a'
	  ,@Truncate	= 'TRUE'
	GO



LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

DECLARE @FilePath VARCHAR(500) = 'C:\Users\emily\Documents\SQL\BULK INSERT FILES'		--Hardcoded. This is where I should place all bulk load files.
DECLARE @FullFilePath VARCHAR(100) = @FilePath + '' + '\' + '' + @FileName + '.csv'
DECLARE @TruncateDescision VARCHAR(500)
    SET @TruncateDescision = CASE WHEN @Truncate = 'TRUE'   THEN 'TRUNCATE TABLE' + ' ' + @Table 
															ELSE ''
															END


DECLARE @SQL VARCHAR(MAX)
SET @SQL = '
'+@TruncateDescision+'
BULK INSERT '+@Table+'
FROM '''+@FullFilePath+'''
WITH (
	FORMAT = ''CSV'',
	FIRSTROW=2,
	FIELDTERMINATOR='','',
	ROWTERMINATOR=''\n''
	);
	'

EXECUTE (@SQL)

DECLARE @SQL2 VARCHAR(MAX)
SET @SQL2 = 'SELECT * FROM '+@Table+''

EXEC (@SQL2)

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH