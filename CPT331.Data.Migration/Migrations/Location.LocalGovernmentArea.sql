SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Location].[LocalGovernmentArea]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StateID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Area] [geography] NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_LocalGovernmentArea_IsDeleted]  DEFAULT ((0)),
	[IsVisible] [bit] NOT NULL CONSTRAINT [DF_LocalGovernmentArea_IsVisible]  DEFAULT ((1)),
	[DateCreatedUtc] [datetime] NOT NULL CONSTRAINT [DF_LocalGovernmentArea_DateCreatedUtc]  DEFAULT (getutcdate()),
	[DateUpdatedUtc] [datetime] NOT NULL CONSTRAINT [DF_LocalGovernmentArea_DateUpdatedUtc]  DEFAULT (getutcdate()),
	CONSTRAINT [PK_LocalGovernmentArea] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT [FK_LocalGovernmentArea_State] FOREIGN KEY (StateID) REFERENCES [Location].[State]([ID])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
