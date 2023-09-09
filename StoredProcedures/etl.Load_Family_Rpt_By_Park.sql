USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Load_Family_Rpt_By_Park]    Script Date: 9/7/2023 5:47:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [etl].[Load_Family_Rpt_By_Park]

(
@Park VARCHAR(100)
)

AS
/*
PURPOSE:
Outputs a park report, showing the composition and count of the different families of species found witihn the park.
Not in the etl.Refresh_all as it requires a Park variable to be passed through.
Has a neat loop in it!

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT 
						Fixed so you can just pass the park name, not the park's park table name..

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

--Create temp table with distinct classes found within the park specified

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
SET @SQL1 = 'SELECT Class, Family, Tally = COUNT(Family) FROM Park.'+@Park+' GROUP BY Family, Class'


DROP TABLE IF EXISTS #tally
CREATE TABLE #tally
	(
		Class	VARCHAR(50),
		Family	VARCHAR(50),
		Tally	INT
	)
	INSERT INTO #tally
		(
			Class,
			Family,
			Tally
		)
		EXEC (@SQL1)

DECLARE @Class	VARCHAR(100)  --set dynamically in loop

--Loopy loop time
DECLARE @rnk INT

SET @rnk = 1
WHILE (@rnk <= (SELECT MAX(Rnk) FROM #classList))
	BEGIN
	
		SET @Class = (SELECT Class FROM #classList WHERE @rnk = Rnk)
		
			SELECT 
				tl.Class,
				tr.FamilyTranslation,
				tl.Tally
			FROM #tally tl
			JOIN ref.TranslateFamily tr (NOLOCK) ON tr.Family = tl.Family
			WHERE  Class = @Class
			ORDER BY Class, tl.Tally DESC
	
		SET @rnk = @rnk +1

	END

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH