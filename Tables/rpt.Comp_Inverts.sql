USE [Beta]
GO

/****** Object:  Table [rpt].[Comp_Inverts]    Script Date: 9/7/2023 4:28:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [rpt].[Comp_Inverts](
	[Park] [varchar](40) NOT NULL,
	[Category] [varchar](40) NOT NULL,
	[Count] [float] NOT NULL,
	[Park Composition %] [float] NOT NULL,
	[UniqueToPark] [int] NOT NULL
) ON [PRIMARY]
GO


