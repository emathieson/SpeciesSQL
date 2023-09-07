USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_Family_Comp_rpts]    Script Date: 9/7/2023 5:45:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [etl].[Load_Family_Comp_rpts]


AS
/*
PURPOSE:
Truncates and then loads information into ALL of the rpt.Family_Comp_PARK tables
Fancy loops in loops

--Current state, not pulling info from plants

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
DROP TABLE IF EXISTS #catList
CREATE TABLE #catList
	(
		Category VARCHAR(50),
		Class		VARCHAR(50)
	)
	INSERT INTO #catList
		(
			Category,
			Class
		)
		SELECT DISTINCT Category, Class FROM Species.All_current (NOLOCK)

DECLARE @Park VARCHAR(100)

DROP TABLE IF EXISTS #parkList
CREATE TABLE #parkList
	(
		Park	VARCHAR(40),
		Rnk		INT IDENTITY(1,1) PRIMARY KEY
	)
		INSERT INTO #parkList
			(
				Park
			)
			SELECT DISTINCT Park FROM ref.ParkNames


DECLARE @ParkRnk INT

SET @ParkRnk = 1
WHILE (@ParkRnk <= (SELECT MAX(Rnk) FROM #parkList))
	BEGIN
	
		SET @Park = (SELECT Park FROM #parkList WHERE @ParkRnk = Rnk)
		--do stuff in park loop

		DECLARE @SQL0 VARCHAR(max)
		SET @SQL0 = 'SELECT DISTINCT Class FROM Park.'+@Park+''

			DROP TABLE IF EXISTS #classList
			CREATE TABLE #classList
				(
					Class	VARCHAR(40),
					Rnk		INT IDENTITY(1,1) PRIMARY KEY
				)
					INSERT INTO #classList
						(
							Class
						)
						EXEC (@SQL0)
			

			DECLARE @SQL1 VARCHAR(max)
			SET @SQL1 = 'SELECT '''+@Park+''',Class, Family, Tally = COUNT(Family) FROM Park.'+@Park+' GROUP BY Family, Class'
			
			
			DROP TABLE IF EXISTS #tally
			CREATE TABLE #tally
				(
					Park		VARCHAR(100),
					Class		VARCHAR(50),
					Family		VARCHAR(50),
					Tally		INT
				)
				INSERT INTO #tally
					(
						Park,
						Class,
						Family,
						Tally
					)
					EXEC (@SQL1)


			DECLARE @SQL2 VARCHAR(MAX)
			SET @SQL2 = 'TRUNCATE TABLE rpt.Family_Comp_'+@Park+''

			EXEC (@SQL2)

			DECLARE @SQL3 VARCHAR(MAX)
			SET @SQL3 =	'INSERT INTO rpt.Family_Comp_'+@Park+' 			
							SELECT 
							tl.Park, 
							cl.Category,
							tl.Class, 
							tl.Family, 
							tf.FamilyTranslation,
							tl.Tally 
						FROM #tally tl
						JOIN #catList cl (NOLOCK) ON tl.Class = cl.Class
						JOIN ref.TranslateFamily tf (NOLOCK) ON tf.Family = tl.Family'
			EXEC (@SQL3)
			

		--end of park stuff loop
		SET @ParkRnk = @ParkRnk +1

	END


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


