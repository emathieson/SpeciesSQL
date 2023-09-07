USE [Beta]
GO

/****** Object:  Table [Species].[Plants_current]    Script Date: 9/7/2023 4:37:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Species].[Plants_current](
	[UniqueID] [varchar](5) NOT NULL,
	[Class] [varchar](50) NOT NULL,
	[Order] [varchar](50) NOT NULL,
	[Family] [varchar](50) NOT NULL,
	[ScientificName] [varchar](100) NOT NULL,
	[CommonName] [varchar](100) NOT NULL,
	[Plate] [varchar](30) NULL,
	[Ref] [varchar](10) NULL,
	[MichiganSleepingBear] [varchar](10) NULL,
	[GreatSmokyMountains] [varchar](10) NULL,
	[Acadia] [varchar](10) NULL,
	[YellowstoneGrandTeton] [varchar](30) NULL,
	[Glacier] [varchar](10) NULL,
	[JoshuaTree] [varchar](10) NULL,
	[Zion] [varchar](10) NULL,
	[Saguaro] [varchar](10) NULL,
	[MichiganIsleRoyale] [varchar](10) NULL,
	[Everglades] [varchar](10) NULL,
	[NorthCascadesOlympic] [varchar](30) NULL,
	[Redwoods] [varchar](10) NULL,
	[Yosemite] [varchar](10) NULL,
	[RockyCoast] [int] NULL,
	[CoastalSaltMarsh] [int] NULL,
	[LakePond] [int] NULL,
	[MountainStream] [int] NULL,
	[InlandMarshWetlandSwamp] [int] NULL,
	[MountainMeadow] [int] NULL,
	[PlainsGrassland] [int] NULL,
	[SonoranCactusDesert] [int] NULL,
	[SagebrushDesert] [int] NULL,
	[PinyonJuniperWoodland] [int] NULL,
	[AspenForest] [int] NULL,
	[LowlandRiverForest] [int] NULL,
	[RedwoodForest] [int] NULL,
	[PonderosaPineForest] [int] NULL,
	[OldGrowthDouglasFirForest] [int] NULL,
	[LodgepolePineForest] [int] NULL,
	[SubalpineForest] [int] NULL,
	[SandyBeachAndDune] [int] NULL,
	[SaltMarsh] [int] NULL,
	[MangroveForest] [int] NULL,
	[RiverAndStream] [int] NULL,
	[CattailMarsh] [int] NULL,
	[EvergladesHabitat] [int] NULL,
	[SedgeMeadow] [int] NULL,
	[ShrubSwamp] [int] NULL,
	[BogAndBogForest] [int] NULL,
	[NorthernFloodplainForest] [int] NULL,
	[SouthernFloodplainForest] [int] NULL,
	[GrassyField] [int] NULL,
	[ShrubSaplingOpeningEdge] [int] NULL,
	[AspenBirchForest] [int] NULL,
	[TransitionForest] [int] NULL,
	[AppalachianCoveForest] [int] NULL,
	[OakHickoryForest] [int] NULL,
	[NorthernNeedleleafForest] [int] NULL,
	[Habitat] [varchar](max) NULL,
	[SizeMinimumInches] [decimal](8, 3) NULL,
	[SizeMaximumInches] [decimal](8, 3) NULL,
	[PhysicalDescription] [varchar](max) NULL,
	[Notes] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


