USE [Beta]
GO

/****** Object:  Table [ref].[ParkNames]    Script Date: 9/7/2023 4:26:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [ref].[ParkNames](
	[Park] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Park] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


