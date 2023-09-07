USE [Beta]
GO

/****** Object:  Table [ref].[TranslateOrder]    Script Date: 9/7/2023 4:26:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [ref].[TranslateOrder](
	[Order] [varchar](50) NOT NULL,
	[OrderTranslation] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


