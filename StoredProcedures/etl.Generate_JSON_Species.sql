USE [Beta]
GO
/****** Object:  StoredProcedure [etl].[Generate_JSON_Species]    Script Date: 9/7/2023 5:16:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [etl].[Generate_JSON_Species]

(
@UniqueIDStartsWith VARCHAR(1)
)

AS


/*
PURPOSE:
Generates JSON for Species data. 
Run in an execute window, and set the UniqueIDStartsWith variable to either M, F, H, B, I , or P (Categories of Species)
You must piece together the JSON after each section is created, as the JSON becomes TOO LONG.
I've created a template for this in google sheets, not included here, that dynamically pieces the results together.
This JSON is used in the Unity game engine to load the data for the database I created INSIDE the game engine, :)

--IMPORTANT: Current state, not pulling info from plants

LOG:
Date		Owner		Message
09.04.23	EMathieson	Push to Beta/ITFProd
09.07.23	EMathieson	Cleanup for GIT

*/

BEGIN TRY
------------------------------------------------------------------------------yeehaw------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #BasePop
	CREATE TABLE #BasePop
		(
		SpeciesType					VARCHAR(20),
		UniqueID					VARCHAR(10),
		ObjectSlug					VARCHAR(200),
		Experience					INT,
		ResearchPoints				INT,
		UniqueToParkFlag			INT,
		ExpansionOnlyFlag			INT,
		CommonName					VARCHAR(80),
		ScientificName				VARCHAR(80),
		Class						VARCHAR(30),
		[Order]						VARCHAR(30),
		Family						VARCHAR(30),
		IUCN						VARCHAR(30),
		SizeMinimumInches			VARCHAR(20),
		SizeMaximumInches			VARCHAR(20),
		LengthInches				VARCHAR(20),
		WingspanInches				VARCHAR(20),
		Measurements				VARCHAR(200),
		DailyActivity				VARCHAR(100),
		YearlyActivity				VARCHAR(100),
		MichiganSleepingBear		VARCHAR(80),
		GreatSmokyMountains			VARCHAR(80),
		Acadia						VARCHAR(80),
		YellowstoneGrandTeton		VARCHAR(80),
		Glacier						VARCHAR(80),
		JoshuaTree					VARCHAR(80),
		Zion						VARCHAR(80),
		Saguaro						VARCHAR(80),
		MichiganIsleRoyale			VARCHAR(80),
		Everglades					VARCHAR(80),
		NorthCascadesOlympic		VARCHAR(80),
		Redwoods					VARCHAR(80),
		Yosemite					VARCHAR(80),
		HabitatDescription			VARCHAR(max),
		Notes						VARCHAR(max),
		)
		INSERT INTO #BasePop
			(
				 SpeciesType				
				,UniqueID				
				,ObjectSlug				
				,Experience				
				,ResearchPoints			
				,UniqueToParkFlag		
				,ExpansionOnlyFlag		
				,CommonName				
				,ScientificName			
				,Class					
				,[Order]					
				,Family					
				,IUCN						
				,SizeMinimumInches		
				,SizeMaximumInches
				,LengthInches			
				,WingspanInches			
				,Measurements			
				,DailyActivity			
				,YearlyActivity			
				,MichiganSleepingBear	
				,GreatSmokyMountains		
				,Acadia					
				,YellowstoneGrandTeton	
				,Glacier					
				,JoshuaTree				
				,Zion					
				,Saguaro					
				,MichiganIsleRoyale		
				,Everglades				
				,NorthCascadesOlympic	
				,Redwoods				
				,Yosemite				
				,HabitatDescription		
				,Notes
			)
			SELECT
				 ac.Category
				,ac.UniqueID
				,LOWER(REPLACE(ac.CommonName, ' ', ''))						--objectSlug needs to be lowercase common name with no spaces
				,0															--link to ref table later for experience points
				,0															--link to ref table later for research points
				,CASE WHEN utp.UniquePark IS NOT NULL THEN 1 ELSE 0 END
				,CASE WHEN ute.UniqueID IS NOT NULL THEN 1 ELSE 0 END
				,ac.CommonName
				,ac.ScientificName
				,ac.Class
				,ac.[Order]
				,ac.Family
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.IUCN,'missing data') 
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.IUCN,'missing data')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.IUCN,'missing data')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.IUCN,'missing data')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.IUCN,'missing data') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(CAST(hrp.SizeMinimumInches AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Birds'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Fish'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(CAST(inv.SizeMinimumInches AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(NULL, '') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(CAST(hrp.SizeMaximumInches AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Birds'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Fish'		THEN ISNULL(CAST(fsh.SizeMaximumInches AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(CAST(inv.SizeMaximumInches AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(NULL, '') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Birds'		THEN ISNULL(CAST(brd.[LengthInches] AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Fish'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(NULL, '') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Birds'		THEN ISNULL(CAST(brd.[WingspanInches] AS VARCHAR), 'missing data')
						WHEN ac.Category = 'Fish'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(NULL, '') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Birds'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Fish'		THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(NULL, '')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Measurements, 'missing data') ELSE 'error' END
				,ISNULL(ac.DailyActivity, 'missing data')
				,ISNULL(ac.YearlyActivity, 'missing data')
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.MichiganSleepingBear, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.MichiganSleepingBear, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.MichiganSleepingBear, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.MichiganSleepingBear, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.MichiganSleepingBear, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.GreatSmokyMountains, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.GreatSmokyMountains, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.GreatSmokyMountains, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.GreatSmokyMountains, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.GreatSmokyMountains, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Acadia, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Acadia, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Acadia, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Acadia, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Acadia, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.YellowstoneGrandTeton, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.YellowstoneGrandTeton, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.YellowstoneGrandTeton, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.YellowstoneGrandTeton, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.YellowstoneGrandTeton, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Glacier, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Glacier, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Glacier, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Glacier, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Glacier, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.JoshuaTree, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.JoshuaTree, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.JoshuaTree, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.JoshuaTree, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.JoshuaTree, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Zion, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Zion, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Zion, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Zion, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Zion, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Saguaro, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Saguaro, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Saguaro, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Saguaro, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Saguaro, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.MichiganIsleRoyale, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.MichiganIsleRoyale, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.MichiganIsleRoyale, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.MichiganIsleRoyale, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.MichiganIsleRoyale, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Everglades, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Everglades, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Everglades, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Everglades, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Everglades, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.NorthCascadesOlympic, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.NorthCascadesOlympic, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.NorthCascadesOlympic, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.NorthCascadesOlympic, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.NorthCascadesOlympic, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Redwoods, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Redwoods, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Redwoods, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Redwoods, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Redwoods, 'NOT PRESENT') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Yosemite, 'NOT PRESENT')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Yosemite, 'NOT PRESENT')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Yosemite, 'NOT PRESENT')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Yosemite, 'NOT PRESENT')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Yosemite, 'NOT PRESENT') ELSE 'error' END
				,ac.Habitat
				--,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Habitat, 'missing data')
				--		WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Habitat, 'missing data')
				--		WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Habitat, 'missing data')
				--		WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Habitat, 'missing data')
				--		WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Habitat, 'missing data') ELSE 'error' END
				,CASE	WHEN ac.Category = 'Herp'		THEN ISNULL(hrp.Notes, 'missing data')
						WHEN ac.Category = 'Birds'		THEN ISNULL(brd.Notes, 'missing data')
						WHEN ac.Category = 'Fish'		THEN ISNULL(fsh.Notes, 'missing data')
						WHEN ac.Category = 'Inverts'	THEN ISNULL(inv.Notes, 'missing data')
						WHEN ac.Category = 'Mammals'	THEN ISNULL(mam.Notes, 'missing data') ELSE 'error' END
			FROM Species.All_current (NOLOCK) ac
			FULL OUTER JOIN rpt.SpeciesUniqueToParks		(NOLOCK) utp ON utp.UniqueID  = ac.UniqueID
			FULL OUTER JOIN rpt.SpeciesUniqueToExpansion	(NOLOCK) ute ON ute.UniqueID = ac.UniqueID
			LEFT JOIN Species.Herps_current					(NOLOCK) hrp ON hrp.UniqueID = ac.UniqueID
			LEFT JOIN Species.Birds_current					(NOLOCK) brd ON brd.UniqueID = ac.UniqueID
			LEFT JOIN Species.Fish_current					(NOLOCK) fsh ON fsh.UniqueID = ac.UniqueID
			LEFT JOIN Species.Inverts_current				(NOLOCK) inv ON inv.UniqueID = ac.UniqueID
			LEFT JOIN Species.Mammals_current				(NOLOCK) mam ON mam.UniqueID = ac.UniqueID

--SELECT * FROM #BasePop

DROP TABLE IF EXISTS #JsonPerRow
CREATE TABLE #JsonPerRow
	(
	UniqueID	VARCHAR(5),
	JsonValue	VARCHAR(max)
	)
	INSERT INTO	#JsonPerRow
		(
		UniqueID,
		JsonValue
		)
		SELECT
			UniqueID,
			ca_json.JsonValue
		FROM #BasePop bp
		CROSS APPLY  (SELECT JSONValue = '{'
											+ '"speciesType": "'			+ bp.SpeciesType +'",'
											+ '"uniqueID": "'				+ bp.UniqueID +'",'
											+ '"objectSlug": "'				+ bp.ObjectSlug +'",'
											+ '"experience": "'				+ CAST(bp.Experience AS varchar) + '",'
											+ '"researchPoints": "'			+ CAST(bp.ResearchPoints AS varchar) +'",'
											+ '"uniqueToParkFlag": "'		+ CAST(bp.UniqueToParkFlag AS varchar) +'",'
											+ '"expansionOnlyFlag": "'		+ CAST(bp.ExpansionOnlyFlag AS varchar) +'",'
											+ '"commonName": "'				+ bp.CommonName +'",'
											+ '"scientificName": "'			+ bp.ScientificName +'",'
											+ '"class": "'					+ bp.Class +'",'
											+ '"order": "'					+ bp.[Order] +'",'
											+ '"family": "'					+ bp.Family +'",'
											+ '"iucn": "'					+ bp.IUCN +'",'
											+ '"sizeMinimumInches": "'		+ bp.SizeMinimumInches +'",'
											+ '"sizeMaximumInches": "'		+ bp.SizeMaximumInches +'",' 
											+ '"lengthInches": "'			+ bp.LengthInches +'",'
											+ '"wingspanInches": "'			+ bp.WingspanInches +'",'
											+ '"measurements": "'			+ bp.Measurements +'",'
											+ '"dailyActivity": "'			+ bp.DailyActivity +'",'
											+ '"yearlyActivity": "'			+ bp.YearlyActivity +'",'
											+ '"michiganSleepingBear": "'	+ bp.MichiganSleepingBear +'",'
											+ '"greatSmokyMountains": "'	+ bp.GreatSmokyMountains +'",'
											+ '"acadia": "'					+ bp.Acadia +'",'
											+ '"yellowstoneGrandTeton": "'	+ bp.YellowstoneGrandTeton +'",'
											+ '"glacier": "'				+ bp.Glacier +'",'
											+ '"joshuaTree": "'				+ bp.JoshuaTree +'",'
											+ '"zion": "'					+ bp.Zion +'",'
											+ '"saguaro": "'				+ bp.Saguaro +'",'
											+ '"michiganIsleRoyale": "'		+ bp.MichiganIsleRoyale +'",'
											+ '"everglades": "'				+ bp.Everglades +'",'
											+ '"NorthCascadesOlympic": "'	+ bp.NorthCascadesOlympic +'",'
											+ '"Redwoods": "'				+ bp.Redwoods +'",'
											+ '"Yosemite": "'				+ bp.Yosemite +'",'
											+ '"habitat": "'				+ bp.HabitatDescription +'",'
											+ '"notes": "'					+ bp.Notes +

											+ '"}'
		
			) ca_json

			SELECT * FROM #JsonPerRow 
			WHERE UniqueID LIKE '%'+@UniqueIDStartsWith+'%'
			ORDER BY UniqueID


----------------------------------------------------------------------------end yeehaw----------------------------------------------------------------------------------------------------
END TRY

BEGIN CATCH

	DECLARE @ErrMessage		NVARCHAR(4000)	= ERROR_MESSAGE()
	DECLARE @ErrSeverity	INT				= ERROR_SEVERITY()
	DECLARE @ErrState		INT				= ERROR_STATE()

	RAISERROR(@ErrMessage,  @ErrSeverity, @ErrState)

END CATCH