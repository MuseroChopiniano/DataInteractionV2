USE [DataInteractionV2]
GO
SET IDENTITY_INSERT [dbo].[Campaign] ON 

INSERT [dbo].[Campaign] ([Id], [Name], [Status], [ActualCost], [BudgetedCost], [Description], [ExpectedRevenue], [StartDate], [EndDate], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1, N'campaña prueba', N'Draft', CAST(1234.56 AS Decimal(16, 2)), CAST(1234567.00 AS Decimal(16, 2)), N'asdfghjkl', CAST(123456.00 AS Decimal(16, 2)), CAST(N'2022-06-17T00:00:00.000' AS DateTime), CAST(N'2022-06-23T00:00:00.000' AS DateTime), 1, CAST(N'2022-06-16T03:05:37.687' AS DateTime), CAST(N'2022-06-16T03:16:04.670' AS DateTime), 2, 2)
INSERT [dbo].[Campaign] ([Id], [Name], [Status], [ActualCost], [BudgetedCost], [Description], [ExpectedRevenue], [StartDate], [EndDate], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (2, N'test', N'Draft', CAST(123455.55 AS Decimal(16, 2)), CAST(1231231.00 AS Decimal(16, 2)), N'agasdgiasodngasdga', CAST(123123123.00 AS Decimal(16, 2)), CAST(N'2022-06-16T00:00:00.000' AS DateTime), CAST(N'2022-06-30T00:00:00.000' AS DateTime), 0, CAST(N'2022-06-16T17:36:13.823' AS DateTime), CAST(N'2022-06-16T17:36:13.823' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Campaign] OFF
GO
SET IDENTITY_INSERT [dbo].[Channel] ON 

INSERT [dbo].[Channel] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [LastModifiedById], [CreatedById]) VALUES (1, N'Email', N'Digital', 1, CAST(N'2022-06-16T17:37:29.710' AS DateTime), CAST(N'2022-06-16T17:39:23.760' AS DateTime), 2, 2)
INSERT [dbo].[Channel] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [LastModifiedById], [CreatedById]) VALUES (2, N'Email', N'Digital', 0, CAST(N'2022-06-16T17:39:31.463' AS DateTime), CAST(N'2022-06-16T17:39:31.463' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Channel] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [Name], [Email], [Age], [Gender], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted]) VALUES (1, N'Gaston Suarez', N'suarez.gastonalejandro@gmail.com', 24, N'Masculino', CAST(N'2022-06-15T00:10:18.157' AS DateTime), 2, CAST(N'2022-06-15T23:37:53.837' AS DateTime), 2, 1)
INSERT [dbo].[Customer] ([Id], [Name], [Email], [Age], [Gender], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted]) VALUES (2, N'Gaston Suarez', N'suarez.gastonalejandro@gmail.com', 26, N'Masculino', CAST(N'2022-06-16T00:28:10.533' AS DateTime), 2, CAST(N'2022-06-16T00:28:10.533' AS DateTime), 2, 0)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Interaction] ON 

INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1, N'click', 0, 0, 0, CAST(N'2022-06-15T00:00:00.000' AS DateTime), CAST(123123.00 AS Decimal(18, 2)), 0, CAST(N'2022-06-16T17:46:01.623' AS DateTime), CAST(N'2022-06-16T17:46:01.623' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Interaction] OFF
GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate]) VALUES (1, N'User CRUD', N'User administrator was modified', CAST(N'2022-06-16T01:19:44.853' AS DateTime), 2, 2, CAST(N'2022-06-16T01:19:44.853' AS DateTime))
SET IDENTITY_INSERT [dbo].[Log] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Username], [Password], [Email], [BlockCounter], [Status], [IsDeleted], [CreatedById], [LastModifiedById], [CreatedDate], [LastModifiedDate]) VALUES (2, N'administrator', N'03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', N'suarez.gastonalejandro@gmail.com', 0, N'Active', 0, 2, 2, CAST(N'2022-06-13T20:27:00.000' AS DateTime), CAST(N'2022-06-16T17:35:14.980' AS DateTime))
INSERT [dbo].[User] ([Id], [Username], [Password], [Email], [BlockCounter], [Status], [IsDeleted], [CreatedById], [LastModifiedById], [CreatedDate], [LastModifiedDate]) VALUES (4, N'hola@hola.com', N'03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', N'suarez.gastonalejandro@gmail.com', 0, N'Active', 1, 2, 2, CAST(N'2022-06-14T23:35:02.160' AS DateTime), CAST(N'2022-06-14T23:37:44.740' AS DateTime))
SET IDENTITY_INSERT [dbo].[User] OFF
GO
