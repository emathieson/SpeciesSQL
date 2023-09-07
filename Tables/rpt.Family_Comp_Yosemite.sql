USE [Beta]
GO

/****** Object:  Table [rpt].[Family_Comp_Yosemite]    Script Date: 9/7/2023 4:35:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [rpt].[Family_Comp_Yosemite](
	[Park] [varchar](100) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[Class] [varchar](40) NOT NULL,
	[Family] [varchar](40) NOT NULL,
	[FamilyTranslated] [varchar](100) NOT NULL,
	[Tally] [int] NULL
) ON [PRIMARY]
GO


