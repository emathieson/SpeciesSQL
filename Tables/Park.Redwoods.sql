USE [Beta]
GO

/****** Object:  Table [Park].[Redwoods]    Script Date: 9/7/2023 4:25:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Park].[Redwoods](
	[UniqueID] [varchar](5) NOT NULL,
	[CommonName] [varchar](100) NOT NULL,
	[Class] [varchar](50) NOT NULL,
	[Order] [varchar](50) NOT NULL,
	[Family] [varchar](50) NOT NULL,
	[Abundance] [varchar](50) NULL,
	[DailyActivity] [varchar](100) NULL,
	[YearlyActivity] [varchar](100) NULL,
	[IUCN] [varchar](50) NULL,
	[Habitat] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


