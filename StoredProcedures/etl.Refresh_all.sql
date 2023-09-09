USE [Beta]
GO

/****** Object:  StoredProcedure [etl].[Refresh_all]    Script Date: 9/7/2023 6:38:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [etl].[Refresh_all]


AS
/*
PURPOSE:
Tis a fren that kicks off a few etls.
Handy when I add/edit species in the Species.####_current  tables and I need all data refreshed for tables/reports that depend on the Species tables.
Doing this because I can't have SQL agent jobs set up.

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------

EXECUTE etl.Load_Species_All_current--MUST BE FIRST
EXECUTE etl.Load_AllParksAllCurrent
EXECUTE etl.Refresh_ref_UniqueSpeciesID
EXECUTE etl.Load_SpeciesUniqueToPark
EXECUTE etl.Load_SpeciesUniqueToExpansion
EXECUTE etl.Load_Park_Comp_rpts
EXECUTE etl.Load_Family_Comp_rpts
EXECUTE etl.Load_Category_Comp_rpts
EXECUTE etl.Load_Family_Comp_All_Summary
EXECUTE etl.Load_SpeciesUniqueToRegion

----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH