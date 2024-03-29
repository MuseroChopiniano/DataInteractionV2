USE [master]
GO
/****** Object:  Database [DataInteractionV2]    Script Date: 04/08/2022 4:03:07 ******/
CREATE DATABASE [DataInteractionV2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataInteractionV2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS01\MSSQL\DATA\DataInteractionV2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DataInteractionV2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS01\MSSQL\DATA\DataInteractionV2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DataInteractionV2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataInteractionV2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataInteractionV2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataInteractionV2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataInteractionV2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataInteractionV2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataInteractionV2] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataInteractionV2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DataInteractionV2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataInteractionV2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataInteractionV2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataInteractionV2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataInteractionV2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataInteractionV2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataInteractionV2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataInteractionV2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataInteractionV2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DataInteractionV2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataInteractionV2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataInteractionV2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataInteractionV2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataInteractionV2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataInteractionV2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataInteractionV2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataInteractionV2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DataInteractionV2] SET  MULTI_USER 
GO
ALTER DATABASE [DataInteractionV2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataInteractionV2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataInteractionV2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataInteractionV2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataInteractionV2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DataInteractionV2] SET QUERY_STORE = OFF
GO
USE [DataInteractionV2]
GO
/****** Object:  UserDefinedTableType [dbo].[ChildPermissions]    Script Date: 04/08/2022 4:03:08 ******/
CREATE TYPE [dbo].[ChildPermissions] AS TABLE(
	[ChildId] [int] NOT NULL,
	[ParentId] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[CustomerSegmentTemp]    Script Date: 04/08/2022 4:03:09 ******/
CREATE TYPE [dbo].[CustomerSegmentTemp] AS TABLE(
	[SegmentId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UserPermissionsTemp]    Script Date: 04/08/2022 4:03:09 ******/
CREATE TYPE [dbo].[UserPermissionsTemp] AS TABLE(
	[UserId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL
)
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 04/08/2022 4:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[ActualCost] [decimal](16, 2) NULL,
	[BudgetedCost] [decimal](16, 2) NULL,
	[Description] [varchar](500) NULL,
	[ExpectedRevenue] [decimal](16, 2) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[LastModifiedById] [int] NOT NULL,
 CONSTRAINT [PK_Campaign] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Channel]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NULL,
	[LastModifiedById] [int] NULL,
	[CreatedById] [int] NULL,
 CONSTRAINT [PK_Channel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedById] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[ExternalId] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerSegment]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerSegment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[SegmentId] [int] NOT NULL,
 CONSTRAINT [PK_CustomerSegment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interaction]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NULL,
	[ChannelId] [int] NULL,
	[CampaignId] [int] NULL,
	[CustomerId] [int] NULL,
	[Date] [datetime] NULL,
	[Revenue] [decimal](18, 2) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[CreatedById] [int] NULL,
	[LastModifiedById] [int] NULL,
 CONSTRAINT [PK_Interaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [varchar](50) NOT NULL,
	[Message] [varchar](250) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[LastModifiedById] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[Entity] [varchar](50) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[LastModifiedById] [int] NOT NULL,
	[Description] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermissionToPermission]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionToPermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChildPermissionId] [int] NOT NULL,
	[ParentPermissionId] [int] NOT NULL,
 CONSTRAINT [PK_PermissionToPermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Segment]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Segment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[Type] [varchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[CreatedById] [int] NULL,
	[LastModifiedById] [int] NULL,
 CONSTRAINT [PK_Segmentation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](64) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[BlockCounter] [int] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[LastModifiedById] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPermission]    Script Date: 04/08/2022 4:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL,
 CONSTRAINT [PK_UserPermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Campaign] ON 

INSERT [dbo].[Campaign] ([Id], [Name], [Status], [ActualCost], [BudgetedCost], [Description], [ExpectedRevenue], [StartDate], [EndDate], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (5, N'Campaign 1', N'Active', CAST(100000.00 AS Decimal(16, 2)), CAST(200000.00 AS Decimal(16, 2)), N'Campaign designed for our new Product', CAST(400000.00 AS Decimal(16, 2)), CAST(N'2021-06-15T00:00:00.000' AS DateTime), CAST(N'2022-06-15T00:00:00.000' AS DateTime), 0, CAST(N'2022-07-14T17:25:58.877' AS DateTime), CAST(N'2022-07-14T17:25:58.877' AS DateTime), 2, 2)
INSERT [dbo].[Campaign] ([Id], [Name], [Status], [ActualCost], [BudgetedCost], [Description], [ExpectedRevenue], [StartDate], [EndDate], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (6, N'Campaign 2', N'Active', CAST(50000.00 AS Decimal(16, 2)), CAST(150000.00 AS Decimal(16, 2)), N'Campaign for our Product 2', CAST(350000.00 AS Decimal(16, 2)), CAST(N'2021-09-15T00:00:00.000' AS DateTime), CAST(N'2022-10-15T00:00:00.000' AS DateTime), 0, CAST(N'2022-07-14T17:26:57.370' AS DateTime), CAST(N'2022-07-14T17:26:57.370' AS DateTime), 2, 2)
INSERT [dbo].[Campaign] ([Id], [Name], [Status], [ActualCost], [BudgetedCost], [Description], [ExpectedRevenue], [StartDate], [EndDate], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (7, N'Campaign 3', N'Draft', CAST(0.00 AS Decimal(16, 2)), CAST(400000.00 AS Decimal(16, 2)), N'Campaign for our most awesome product', CAST(800000.00 AS Decimal(16, 2)), CAST(N'2022-12-15T00:00:00.000' AS DateTime), CAST(N'2023-12-15T00:00:00.000' AS DateTime), 0, CAST(N'2022-07-14T17:28:02.233' AS DateTime), CAST(N'2022-07-14T17:28:02.233' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Campaign] OFF
GO
SET IDENTITY_INSERT [dbo].[Channel] ON 

INSERT [dbo].[Channel] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [LastModifiedById], [CreatedById]) VALUES (6, N'Email', N'Digital', 0, CAST(N'2022-07-14T17:34:17.033' AS DateTime), CAST(N'2022-07-14T17:34:17.033' AS DateTime), 2, 2)
INSERT [dbo].[Channel] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [LastModifiedById], [CreatedById]) VALUES (7, N'Web', N'Digital', 0, CAST(N'2022-07-14T17:34:55.510' AS DateTime), CAST(N'2022-07-14T17:34:55.510' AS DateTime), 2, 2)
INSERT [dbo].[Channel] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [LastModifiedById], [CreatedById]) VALUES (8, N'Instagram', N'Digital', 0, CAST(N'2022-07-14T17:35:20.687' AS DateTime), CAST(N'2022-07-14T17:35:20.687' AS DateTime), 2, 2)
INSERT [dbo].[Channel] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [LastModifiedById], [CreatedById]) VALUES (9, N'Newspaper', N'Non digital', 1, CAST(N'2022-07-17T20:22:07.520' AS DateTime), CAST(N'2022-07-17T20:31:53.110' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Channel] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (7, N'Gaston Suarez', N'suarez.gastonalejandro@gmail.com', CAST(N'2022-07-14T17:29:09.660' AS DateTime), 2, CAST(N'2022-07-14T17:29:09.660' AS DateTime), 2, 0, CAST(N'1995-10-15T00:00:00.000' AS DateTime), N'00512341234')
INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (8, N'Ingrid Mancera', N'mancera.ingridsofia@gmail.com', CAST(N'2022-07-14T17:29:40.217' AS DateTime), 2, CAST(N'2022-07-14T17:29:40.217' AS DateTime), 2, 0, CAST(N'1996-01-20T00:00:00.000' AS DateTime), N'00512341235')
INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (9, N'Juan Perez', N'juan.perez@gmail.com', CAST(N'2022-07-14T17:30:14.433' AS DateTime), 2, CAST(N'2022-07-14T17:30:14.433' AS DateTime), 2, 0, CAST(N'1989-07-13T00:00:00.000' AS DateTime), N'00512341236')
INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (10, N'Alejandro Diaz', N'alejandro.diaz@gmail.com', CAST(N'2022-07-14T17:30:54.530' AS DateTime), 2, CAST(N'2022-07-14T17:30:54.530' AS DateTime), 2, 0, CAST(N'1978-12-30T00:00:00.000' AS DateTime), N'00512341237')
INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (11, N'Alejandra Suarez', N'alejandra.suarez@gmail.com', CAST(N'2022-07-14T17:31:25.697' AS DateTime), 2, CAST(N'2022-07-14T17:31:25.697' AS DateTime), 2, 0, CAST(N'1981-04-23T00:00:00.000' AS DateTime), N'00512341238')
INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (12, N'Herminio Suarez', N'herminio.suarez@gmail.com', CAST(N'2022-07-14T17:32:15.993' AS DateTime), 2, CAST(N'2022-07-14T17:32:15.993' AS DateTime), 2, 0, CAST(N'1951-06-01T00:00:00.000' AS DateTime), N'00512341239')
INSERT [dbo].[Customer] ([Id], [Name], [Email], [CreatedDate], [CreatedById], [LastModifiedDate], [LastModifiedById], [IsDeleted], [DateOfBirth], [ExternalId]) VALUES (13, N'Angelica Diaz', N'angelica.diaz@gmail.com', CAST(N'2022-07-14T17:32:53.480' AS DateTime), 2, CAST(N'2022-07-14T17:32:53.480' AS DateTime), 2, 0, CAST(N'1955-09-08T00:00:00.000' AS DateTime), N'00512341210')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerSegment] ON 

INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (1, 7, 5)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (2, 8, 5)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (3, 12, 6)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (4, 13, 6)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (5, 9, 7)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (6, 10, 7)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (7, 11, 7)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (8, 7, 8)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (9, 12, 9)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (10, 13, 9)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (11, 8, 10)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (12, 9, 10)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (13, 10, 10)
INSERT [dbo].[CustomerSegment] ([Id], [CustomerId], [SegmentId]) VALUES (14, 11, 10)
SET IDENTITY_INSERT [dbo].[CustomerSegment] OFF
GO
SET IDENTITY_INSERT [dbo].[Interaction] ON 

INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1313, N'Open Email', 6, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1314, N'View Page', 7, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1315, N'Add To Cart', 7, 5, 7, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1316, N'Purchase', 7, 5, 7, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1317, N'Click Ad', 8, 5, 7, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1318, N'Add To Cart', 7, 5, 7, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1319, N'Purchase', 7, 5, 7, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1320, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1321, N'Click Ad', 8, 5, 7, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1322, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1323, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1324, N'Click Ad', 8, 5, 7, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1325, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1326, N'Add To Cart', 7, 5, 7, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1327, N'Purchase', 8, 5, 7, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1328, N'Click Ad', 8, 5, 7, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1329, N'View Page', 7, 5, 7, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1330, N'Click Ad', 8, 5, 7, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1331, N'View Page', 7, 5, 7, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1332, N'Click Ad', 8, 5, 7, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1333, N'View Page', 7, 5, 7, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1334, N'Click Ad', 8, 5, 7, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1335, N'Click Ad', 8, 5, 7, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1336, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1337, N'View Page', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1338, N'Add To Cart', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1339, N'Purchase', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1340, N'Click Ad', 8, 6, 8, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1341, N'View Page', 7, 5, 8, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1342, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1343, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1344, N'Open Email', 6, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1345, N'View Page', 7, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1346, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1347, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1348, N'Click Ad', 8, 5, 9, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1349, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1350, N'Purchase', 7, 5, 9, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1351, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1352, N'Click Ad', 8, 5, 9, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1353, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1354, N'Add To Cart', 7, 5, 8, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1355, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1356, N'View Page', 7, 5, 8, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1357, N'Add To Cart', 7, 5, 8, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1358, N'Purchase', 8, 5, 8, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1359, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1360, N'View Page', 7, 6, 10, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1361, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1362, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1363, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1364, N'View Page', 7, 6, 10, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1365, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1366, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1367, N'Click Ad', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1368, N'View Page', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1369, N'Add To Cart', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1370, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1371, N'Click Ad', 8, 6, 10, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1372, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1373, N'Add To Cart', 7, 5, 10, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1374, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1375, N'Open Email', 6, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1376, N'View Page', 7, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1377, N'Add To Cart', 7, 5, 7, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1378, N'Purchase', 7, 5, 7, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1379, N'Click Ad', 8, 5, 7, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1380, N'Add To Cart', 7, 5, 7, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1381, N'Purchase', 7, 5, 7, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1382, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1383, N'Click Ad', 8, 5, 7, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1384, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1385, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1386, N'Click Ad', 8, 5, 7, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1387, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1388, N'Add To Cart', 7, 5, 7, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1389, N'Purchase', 8, 5, 7, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1390, N'Click Ad', 8, 5, 11, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1391, N'View Page', 7, 5, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1392, N'Click Ad', 8, 5, 11, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1393, N'View Page', 7, 5, 11, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1394, N'Click Ad', 8, 5, 7, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1395, N'View Page', 7, 5, 7, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1396, N'Click Ad', 8, 5, 7, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1397, N'Click Ad', 8, 5, 11, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1398, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1399, N'View Page', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1400, N'Add To Cart', 7, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1401, N'Purchase', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1402, N'Click Ad', 8, 6, 11, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1403, N'View Page', 7, 5, 8, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1404, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1405, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1406, N'Open Email', 6, 5, 11, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1407, N'View Page', 7, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1408, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1409, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1410, N'Click Ad', 8, 5, 11, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1411, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
GO
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1412, N'Purchase', 7, 5, 9, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1413, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1414, N'Click Ad', 8, 5, 11, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1415, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1416, N'Add To Cart', 7, 5, 8, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1417, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1418, N'View Page', 7, 5, 11, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1419, N'Add To Cart', 7, 5, 8, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1420, N'Purchase', 8, 5, 8, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1421, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1422, N'View Page', 7, 6, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1423, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1424, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1425, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1426, N'View Page', 7, 6, 12, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1427, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1428, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1429, N'Click Ad', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1430, N'View Page', 7, 5, 12, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1431, N'Add To Cart', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1432, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1433, N'Click Ad', 8, 6, 12, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1434, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1435, N'Add To Cart', 7, 5, 10, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1436, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1437, N'Open Email', 6, 5, 13, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1438, N'View Page', 7, 5, 13, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1439, N'Add To Cart', 7, 5, 13, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1440, N'Purchase', 7, 5, 13, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1441, N'Click Ad', 8, 5, 13, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1442, N'Add To Cart', 7, 5, 13, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1443, N'Purchase', 7, 5, 13, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1444, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1445, N'Click Ad', 8, 5, 11, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1446, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1447, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1448, N'Click Ad', 8, 5, 12, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1449, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1450, N'Add To Cart', 7, 5, 12, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1451, N'Purchase', 8, 5, 12, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1452, N'Click Ad', 8, 5, 7, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1453, N'View Page', 7, 5, 7, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1454, N'Click Ad', 8, 5, 12, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1455, N'View Page', 7, 5, 7, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1456, N'Click Ad', 8, 5, 8, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1457, N'View Page', 7, 5, 8, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1458, N'Click Ad', 8, 5, 8, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1459, N'Click Ad', 8, 5, 7, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1460, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1461, N'View Page', 7, 5, 8, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1462, N'Add To Cart', 7, 5, 8, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1463, N'Purchase', 8, 5, 9, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1464, N'Click Ad', 8, 6, 9, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1465, N'View Page', 7, 5, 9, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1466, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1467, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1468, N'Open Email', 6, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1469, N'View Page', 7, 5, 10, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1470, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1471, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1472, N'Click Ad', 8, 5, 9, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1473, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1474, N'Purchase', 7, 5, 11, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1475, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1476, N'Click Ad', 8, 5, 9, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1477, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1478, N'Add To Cart', 7, 5, 13, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1479, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1480, N'View Page', 7, 5, 8, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1481, N'Add To Cart', 7, 5, 13, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1482, N'Purchase', 8, 5, 13, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1483, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1484, N'View Page', 7, 6, 10, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1485, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1486, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1487, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1488, N'View Page', 7, 6, 10, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1489, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1490, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1491, N'Click Ad', 8, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1492, N'View Page', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1493, N'Add To Cart', 7, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1494, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1495, N'Click Ad', 8, 6, 10, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1496, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1497, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1498, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1499, N'Open Email', 6, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1500, N'View Page', 7, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1501, N'Add To Cart', 7, 5, 7, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1502, N'Purchase', 7, 5, 7, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1503, N'Click Ad', 8, 5, 7, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1504, N'Add To Cart', 7, 5, 7, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1505, N'Purchase', 7, 5, 7, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1506, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1507, N'Click Ad', 8, 5, 7, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1508, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1509, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1510, N'Click Ad', 8, 5, 7, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1511, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
GO
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1512, N'Add To Cart', 7, 5, 7, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1513, N'Purchase', 8, 5, 7, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1514, N'Click Ad', 8, 5, 11, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1515, N'View Page', 7, 5, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1516, N'Click Ad', 8, 5, 11, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1517, N'View Page', 7, 5, 11, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1518, N'Click Ad', 8, 5, 7, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1519, N'View Page', 7, 5, 7, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1520, N'Click Ad', 8, 5, 7, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1521, N'Click Ad', 8, 5, 11, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1522, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1523, N'View Page', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1524, N'Add To Cart', 7, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1525, N'Purchase', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1526, N'Click Ad', 8, 6, 11, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1527, N'View Page', 7, 5, 8, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1528, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1529, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1530, N'Open Email', 6, 5, 11, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1531, N'View Page', 7, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1532, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1533, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1534, N'Click Ad', 8, 5, 11, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1535, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1536, N'Purchase', 7, 5, 9, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1537, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1538, N'Click Ad', 8, 5, 11, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1539, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1540, N'Add To Cart', 7, 5, 8, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1541, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1542, N'View Page', 7, 5, 11, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1543, N'Add To Cart', 7, 5, 8, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1544, N'Purchase', 8, 5, 8, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1545, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1546, N'View Page', 7, 6, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1547, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1548, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1549, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1550, N'View Page', 7, 6, 12, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1551, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1552, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1553, N'Click Ad', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1554, N'View Page', 7, 5, 12, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1555, N'Add To Cart', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1556, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1557, N'Click Ad', 8, 6, 12, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1558, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1559, N'Add To Cart', 7, 5, 10, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1560, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-07-14T17:58:29.877' AS DateTime), CAST(N'2022-07-14T17:58:29.877' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1561, N'Open Email', 6, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1562, N'View Page', 7, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1563, N'Add To Cart', 7, 5, 7, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1564, N'Purchase', 7, 5, 7, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1565, N'Click Ad', 8, 5, 7, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1566, N'Add To Cart', 7, 5, 7, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1567, N'Purchase', 7, 5, 7, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1568, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1569, N'Click Ad', 8, 5, 7, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1570, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1571, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1572, N'Click Ad', 8, 5, 7, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1573, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1574, N'Add To Cart', 7, 5, 7, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1575, N'Purchase', 8, 5, 7, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1576, N'Click Ad', 8, 5, 7, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1577, N'View Page', 7, 5, 7, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1578, N'Click Ad', 8, 5, 7, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1579, N'View Page', 7, 5, 7, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1580, N'Click Ad', 8, 5, 7, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1581, N'View Page', 7, 5, 7, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1582, N'Click Ad', 8, 5, 7, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1583, N'Click Ad', 8, 5, 7, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1584, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1585, N'View Page', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1586, N'Add To Cart', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1587, N'Purchase', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1588, N'Click Ad', 8, 6, 8, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1589, N'View Page', 7, 5, 8, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1590, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1591, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1592, N'Open Email', 6, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1593, N'View Page', 7, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1594, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1595, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1596, N'Click Ad', 8, 5, 9, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1597, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1598, N'Purchase', 7, 5, 9, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1599, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1600, N'Click Ad', 8, 5, 9, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1601, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1602, N'Add To Cart', 7, 5, 8, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1603, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1604, N'View Page', 7, 5, 8, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1605, N'Add To Cart', 7, 5, 8, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1606, N'Purchase', 8, 5, 8, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1607, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1608, N'View Page', 7, 6, 10, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1609, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1610, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1611, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
GO
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1612, N'View Page', 7, 6, 10, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1613, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1614, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1615, N'Click Ad', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1616, N'View Page', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1617, N'Add To Cart', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1618, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1619, N'Click Ad', 8, 6, 10, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1620, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1621, N'Add To Cart', 7, 5, 10, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1622, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1623, N'Open Email', 6, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1624, N'View Page', 7, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1625, N'Add To Cart', 7, 5, 7, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1626, N'Purchase', 7, 5, 7, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1627, N'Click Ad', 8, 5, 7, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1628, N'Add To Cart', 7, 5, 7, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1629, N'Purchase', 7, 5, 7, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1630, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1631, N'Click Ad', 8, 5, 7, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1632, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1633, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1634, N'Click Ad', 8, 5, 7, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1635, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1636, N'Add To Cart', 7, 5, 7, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1637, N'Purchase', 8, 5, 7, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1638, N'Click Ad', 8, 5, 11, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1639, N'View Page', 7, 5, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1640, N'Click Ad', 8, 5, 11, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1641, N'View Page', 7, 5, 11, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1642, N'Click Ad', 8, 5, 7, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1643, N'View Page', 7, 5, 7, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1644, N'Click Ad', 8, 5, 7, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1645, N'Click Ad', 8, 5, 11, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1646, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1647, N'View Page', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1648, N'Add To Cart', 7, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1649, N'Purchase', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1650, N'Click Ad', 8, 6, 11, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1651, N'View Page', 7, 5, 8, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1652, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1653, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1654, N'Open Email', 6, 5, 11, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1655, N'View Page', 7, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1656, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1657, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1658, N'Click Ad', 8, 5, 11, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1659, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1660, N'Purchase', 7, 5, 9, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1661, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1662, N'Click Ad', 8, 5, 11, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1663, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1664, N'Add To Cart', 7, 5, 8, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1665, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1666, N'View Page', 7, 5, 11, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1667, N'Add To Cart', 7, 5, 8, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1668, N'Purchase', 8, 5, 8, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1669, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1670, N'View Page', 7, 6, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1671, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1672, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1673, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1674, N'View Page', 7, 6, 12, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1675, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1676, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1677, N'Click Ad', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1678, N'View Page', 7, 5, 12, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1679, N'Add To Cart', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1680, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1681, N'Click Ad', 8, 6, 12, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1682, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1683, N'Add To Cart', 7, 5, 10, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1684, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1685, N'Open Email', 6, 5, 13, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1686, N'View Page', 7, 5, 13, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1687, N'Add To Cart', 7, 5, 13, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1688, N'Purchase', 7, 5, 13, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1689, N'Click Ad', 8, 5, 13, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1690, N'Add To Cart', 7, 5, 13, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1691, N'Purchase', 7, 5, 13, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1692, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1693, N'Click Ad', 8, 5, 11, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1694, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1695, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1696, N'Click Ad', 8, 5, 12, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1697, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1698, N'Add To Cart', 7, 5, 12, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1699, N'Purchase', 8, 5, 12, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1700, N'Click Ad', 8, 5, 7, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1701, N'View Page', 7, 5, 7, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1702, N'Click Ad', 8, 5, 12, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1703, N'View Page', 7, 5, 7, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1704, N'Click Ad', 8, 5, 8, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1705, N'View Page', 7, 5, 8, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1706, N'Click Ad', 8, 5, 8, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1707, N'Click Ad', 8, 5, 7, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1708, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1709, N'View Page', 7, 5, 8, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1710, N'Add To Cart', 7, 5, 8, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1711, N'Purchase', 8, 5, 9, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
GO
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1712, N'Click Ad', 8, 6, 9, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1713, N'View Page', 7, 5, 9, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1714, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1715, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1716, N'Open Email', 6, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1717, N'View Page', 7, 5, 10, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1718, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1719, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1720, N'Click Ad', 8, 5, 9, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1721, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1722, N'Purchase', 7, 5, 11, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1723, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1724, N'Click Ad', 8, 5, 9, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1725, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1726, N'Add To Cart', 7, 5, 13, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1727, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1728, N'View Page', 7, 5, 8, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1729, N'Add To Cart', 7, 5, 13, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1730, N'Purchase', 8, 5, 13, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1731, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1732, N'View Page', 7, 6, 10, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1733, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1734, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1735, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1736, N'View Page', 7, 6, 10, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1737, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1738, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1739, N'Click Ad', 8, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1740, N'View Page', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1741, N'Add To Cart', 7, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1742, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1743, N'Click Ad', 8, 6, 10, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1744, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1745, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1746, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1747, N'Open Email', 6, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1748, N'View Page', 7, 5, 7, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1749, N'Add To Cart', 7, 5, 7, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1750, N'Purchase', 7, 5, 7, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1751, N'Click Ad', 8, 5, 7, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1752, N'Add To Cart', 7, 5, 7, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1753, N'Purchase', 7, 5, 7, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1754, N'Open Email', 6, 5, 7, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1755, N'Click Ad', 8, 5, 7, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1756, N'View Page', 7, 5, 7, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1757, N'Add To Cart', 7, 5, 7, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1758, N'Click Ad', 8, 5, 7, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1759, N'View Page', 7, 5, 7, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1760, N'Add To Cart', 7, 5, 7, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1761, N'Purchase', 8, 5, 7, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1762, N'Click Ad', 8, 5, 11, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1763, N'View Page', 7, 5, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1764, N'Click Ad', 8, 5, 11, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1765, N'View Page', 7, 5, 11, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1766, N'Click Ad', 8, 5, 7, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1767, N'View Page', 7, 5, 7, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1768, N'Click Ad', 8, 5, 7, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1769, N'Click Ad', 8, 5, 11, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1770, N'Click Ad', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1771, N'View Page', 7, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1772, N'Add To Cart', 7, 5, 11, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1773, N'Purchase', 8, 5, 7, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1774, N'Click Ad', 8, 6, 11, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1775, N'View Page', 7, 5, 8, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1776, N'Add To Cart', 7, 5, 8, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1777, N'Purchase', 8, 5, 8, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1778, N'Open Email', 6, 5, 11, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1779, N'View Page', 7, 5, 9, CAST(N'2021-07-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1780, N'Add To Cart', 7, 5, 9, CAST(N'2021-07-09T17:41:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1781, N'Purchase', 7, 5, 9, CAST(N'2021-07-09T17:45:29.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1782, N'Click Ad', 8, 5, 11, CAST(N'2021-08-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1783, N'Add To Cart', 7, 5, 9, CAST(N'2021-08-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1784, N'Purchase', 7, 5, 9, CAST(N'2021-08-09T17:49:29.000' AS DateTime), CAST(7000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1785, N'Open Email', 6, 5, 9, CAST(N'2021-09-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1786, N'Click Ad', 8, 5, 11, CAST(N'2021-10-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1787, N'View Page', 7, 5, 8, CAST(N'2021-10-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1788, N'Add To Cart', 7, 5, 8, CAST(N'2021-10-09T17:48:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1789, N'Click Ad', 8, 5, 8, CAST(N'2021-11-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1790, N'View Page', 7, 5, 11, CAST(N'2021-11-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1791, N'Add To Cart', 7, 5, 8, CAST(N'2021-11-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1792, N'Purchase', 8, 5, 8, CAST(N'2021-11-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1793, N'Click Ad', 8, 5, 8, CAST(N'2021-12-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1794, N'View Page', 7, 6, 11, CAST(N'2021-12-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1795, N'Click Ad', 8, 6, 10, CAST(N'2022-01-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1796, N'View Page', 7, 6, 10, CAST(N'2022-01-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1797, N'Click Ad', 8, 6, 10, CAST(N'2022-02-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1798, N'View Page', 7, 6, 12, CAST(N'2022-02-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1799, N'Click Ad', 8, 6, 10, CAST(N'2022-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1800, N'Click Ad', 8, 6, 10, CAST(N'2022-04-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1801, N'Click Ad', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1802, N'View Page', 7, 5, 12, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1803, N'Add To Cart', 7, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1804, N'Purchase', 8, 5, 10, CAST(N'2022-06-09T17:40:29.000' AS DateTime), CAST(13000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1805, N'Click Ad', 8, 6, 12, CAST(N'2021-03-09T17:40:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1806, N'View Page', 7, 5, 10, CAST(N'2021-03-09T17:42:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1807, N'Add To Cart', 7, 5, 10, CAST(N'2021-03-09T17:46:29.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
INSERT [dbo].[Interaction] ([Id], [Type], [ChannelId], [CampaignId], [CustomerId], [Date], [Revenue], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1808, N'Purchase', 8, 5, 10, CAST(N'2021-03-09T17:49:29.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)), 0, CAST(N'2022-08-04T03:34:28.657' AS DateTime), CAST(N'2022-08-04T03:34:28.657' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Interaction] OFF
GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (2, N'ObjectUpdate', N'The User 2has been upserted by 2', CAST(N'2022-07-11T21:53:44.983' AS DateTime), 2, 2, CAST(N'2022-07-11T21:53:44.983' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (3, N'ObjectUpdate', N'The User 5has been upserted by 2', CAST(N'2022-07-11T21:54:13.317' AS DateTime), 2, 2, CAST(N'2022-07-11T21:54:13.317' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (4, N'ObjectUpdate', N'The User 5has been upserted by 2', CAST(N'2022-07-11T21:56:55.467' AS DateTime), 2, 2, CAST(N'2022-07-11T21:56:55.467' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (5, N'ObjectInsert', N'The User 6 has been upserted by 2', CAST(N'2022-07-11T22:00:18.673' AS DateTime), 2, 2, CAST(N'2022-07-11T22:00:18.673' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (6, N'ObjectUpdate', N'The User with Id 2 has been upserted by 2', CAST(N'2022-07-11T22:30:40.537' AS DateTime), 2, 2, CAST(N'2022-07-11T22:30:40.537' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (7, N'ObjectUpdate', N'The User with Id 2 has been upserted by 2', CAST(N'2022-07-11T23:10:06.793' AS DateTime), 2, 2, CAST(N'2022-07-11T23:10:06.793' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (8, N'ObjectInsert', N'The Channel with Id 0 has been upserted by 0', CAST(N'2022-07-11T23:10:27.900' AS DateTime), 0, 0, CAST(N'2022-07-11T23:10:27.900' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (9, N'ObjectUpdate', N'The Channel with Id 4 has been upserted by 2', CAST(N'2022-07-11T23:10:35.510' AS DateTime), 2, 2, CAST(N'2022-07-11T23:10:35.510' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (10, N'ObjectDelete', N'The Channel with Id 4 has been deleted by 2', CAST(N'2022-07-11T23:10:36.930' AS DateTime), 2, 2, CAST(N'2022-07-11T23:10:36.930' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (11, N'ObjectInsert', N'The Channel with Id 5 has been upserted by 2', CAST(N'2022-07-11T23:15:34.527' AS DateTime), 2, 2, CAST(N'2022-07-11T23:15:34.527' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (12, N'ObjectUpdate', N'The Channel with Id 5 has been upserted by 2', CAST(N'2022-07-11T23:15:39.013' AS DateTime), 2, 2, CAST(N'2022-07-11T23:15:39.013' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (13, N'ObjectDelete', N'The Channel with Id 5 has been deleted by 2', CAST(N'2022-07-11T23:15:41.447' AS DateTime), 2, 2, CAST(N'2022-07-11T23:15:41.447' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (14, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-11T23:56:58.870' AS DateTime), 2, 2, CAST(N'2022-07-11T23:56:58.870' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (15, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-12T23:31:13.317' AS DateTime), 2, 2, CAST(N'2022-07-12T23:31:13.317' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (16, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-13T00:51:21.860' AS DateTime), 2, 2, CAST(N'2022-07-13T00:51:21.860' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (17, N'ObjectUpdate', N'The Permission with Id 13 has been upserted by User with Id 2', CAST(N'2022-07-13T00:53:35.380' AS DateTime), 2, 2, CAST(N'2022-07-13T00:53:35.380' AS DateTime), N'Permission')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (18, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-13T20:17:31.393' AS DateTime), 2, 2, CAST(N'2022-07-13T20:17:31.393' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (19, N'ObjectUpdate', N'The Permission with Id 13 has been upserted by User with Id 2', CAST(N'2022-07-13T21:28:36.533' AS DateTime), 2, 2, CAST(N'2022-07-13T21:28:36.533' AS DateTime), N'Permission')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (20, N'ObjectInsert', N'The Campaign with Id 4 has been upserted by User with Id 2', CAST(N'2022-07-13T22:09:42.883' AS DateTime), 2, 2, CAST(N'2022-07-13T22:09:42.883' AS DateTime), N'Campaign')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (21, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T00:15:16.870' AS DateTime), 2, 2, CAST(N'2022-07-14T00:15:16.870' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (22, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T01:22:02.933' AS DateTime), 2, 2, CAST(N'2022-07-14T01:22:02.933' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (23, N'ObjectUpdate', N'The Permission with Id 13 has been upserted by User with Id 2', CAST(N'2022-07-14T01:42:45.667' AS DateTime), 2, 2, CAST(N'2022-07-14T01:42:45.667' AS DateTime), N'Permission')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (24, N'ObjectUpdate', N'The Interaction with Id 1 has been upserted by User with Id 2', CAST(N'2022-07-14T02:20:47.953' AS DateTime), 2, 2, CAST(N'2022-07-14T02:20:47.953' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (25, N'ObjectUpdate', N'The Interaction with Id 1 has been upserted by User with Id 2', CAST(N'2022-07-14T02:23:06.100' AS DateTime), 2, 2, CAST(N'2022-07-14T02:23:06.100' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (26, N'ObjectUpdate', N'The Interaction with Id 1 has been upserted by User with Id 2', CAST(N'2022-07-14T02:24:57.027' AS DateTime), 2, 2, CAST(N'2022-07-14T02:24:57.027' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (27, N'ObjectInsert', N'The Interaction with Id 1302 has been upserted by User with Id 2', CAST(N'2022-07-14T02:34:21.027' AS DateTime), 2, 2, CAST(N'2022-07-14T02:34:21.027' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (28, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T11:17:52.067' AS DateTime), 2, 2, CAST(N'2022-07-14T11:17:52.067' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (29, N'ObjectUpdate', N'The Permission with Id 13 has been upserted by User with Id 2', CAST(N'2022-07-14T11:22:09.427' AS DateTime), 2, 2, CAST(N'2022-07-14T11:22:09.427' AS DateTime), N'Permission')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (30, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T11:59:57.607' AS DateTime), 2, 2, CAST(N'2022-07-14T11:59:57.607' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (31, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T12:50:23.597' AS DateTime), 2, 2, CAST(N'2022-07-14T12:50:23.597' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (32, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T14:26:51.243' AS DateTime), 2, 2, CAST(N'2022-07-14T14:26:51.243' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (33, N'ObjectUpdate', N'The Permission with Id 13 has been upserted by User with Id 2', CAST(N'2022-07-14T14:30:25.487' AS DateTime), 2, 2, CAST(N'2022-07-14T14:30:25.487' AS DateTime), N'Permission')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (34, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T14:49:07.577' AS DateTime), 2, 2, CAST(N'2022-07-14T14:49:07.577' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (35, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T15:24:18.930' AS DateTime), 2, 2, CAST(N'2022-07-14T15:24:18.930' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (36, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-14T15:27:58.950' AS DateTime), 2, 2, CAST(N'2022-07-14T15:27:58.950' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (37, N'ObjectDelete', N'The Segment with Id 1 has been deleted by 2', CAST(N'2022-07-14T15:56:27.673' AS DateTime), 2, 2, CAST(N'2022-07-14T15:56:27.673' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (38, N'BulkOperation', N'A Bulk Interaction Upsert has been made by the user with Id 2', CAST(N'2022-07-14T16:22:12.887' AS DateTime), 2, 2, CAST(N'2022-07-14T16:22:12.887' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (39, N'BulkOperation', N'A Bulk Interaction Upsert has been made by the user with Id 2', CAST(N'2022-07-14T16:23:20.010' AS DateTime), 2, 2, CAST(N'2022-07-14T16:23:20.010' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (40, N'BulkOperation', N'A Bulk Interaction Upsert has been made by the user with Id 2', CAST(N'2022-07-14T17:03:41.927' AS DateTime), 2, 2, CAST(N'2022-07-14T17:03:41.927' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (41, N'ObjectInsert', N'The Campaign with Id 5 has been upserted by User with Id 2', CAST(N'2022-07-14T17:25:58.890' AS DateTime), 2, 2, CAST(N'2022-07-14T17:25:58.890' AS DateTime), N'Campaign')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (42, N'ObjectInsert', N'The Campaign with Id 6 has been upserted by User with Id 2', CAST(N'2022-07-14T17:26:57.380' AS DateTime), 2, 2, CAST(N'2022-07-14T17:26:57.380' AS DateTime), N'Campaign')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (43, N'ObjectInsert', N'The Campaign with Id 7 has been upserted by User with Id 2', CAST(N'2022-07-14T17:28:02.240' AS DateTime), 2, 2, CAST(N'2022-07-14T17:28:02.240' AS DateTime), N'Campaign')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (44, N'ObjectInsert', N'The Channel with Id 6 has been upserted by User with Id  2', CAST(N'2022-07-14T17:34:17.047' AS DateTime), 2, 2, CAST(N'2022-07-14T17:34:17.047' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (45, N'ObjectInsert', N'The Channel with Id 7 has been upserted by User with Id  2', CAST(N'2022-07-14T17:34:55.520' AS DateTime), 2, 2, CAST(N'2022-07-14T17:34:55.520' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (46, N'ObjectInsert', N'The Channel with Id 8 has been upserted by User with Id  2', CAST(N'2022-07-14T17:35:20.690' AS DateTime), 2, 2, CAST(N'2022-07-14T17:35:20.690' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (47, N'BulkOperation', N'A Bulk Interaction Upsert has been made by the user with Id 2', CAST(N'2022-07-14T17:58:29.997' AS DateTime), 2, 2, CAST(N'2022-07-14T17:58:29.997' AS DateTime), N'Interaction')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (48, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-17T14:31:06.870' AS DateTime), 2, 2, CAST(N'2022-07-17T14:31:06.870' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (49, N'ObjectInsert', N'The Segment with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-17T15:23:22.317' AS DateTime), 2, 2, CAST(N'2022-07-17T15:23:22.317' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (50, N'ObjectInsert', N'The Segment with Id 3 has been upserted by User with Id 2', CAST(N'2022-07-17T15:23:22.340' AS DateTime), 2, 2, CAST(N'2022-07-17T15:23:22.340' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (51, N'ObjectInsert', N'The Segment with Id 4 has been upserted by User with Id 2', CAST(N'2022-07-17T15:23:22.353' AS DateTime), 2, 2, CAST(N'2022-07-17T15:23:22.353' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (52, N'ObjectDelete', N'The Segment with Id 2 has been deleted by 2', CAST(N'2022-07-17T15:25:53.770' AS DateTime), 2, 2, CAST(N'2022-07-17T15:25:53.770' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (53, N'ObjectDelete', N'The Segment with Id 3 has been deleted by 2', CAST(N'2022-07-17T15:25:55.587' AS DateTime), 2, 2, CAST(N'2022-07-17T15:25:55.587' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (54, N'ObjectDelete', N'The Segment with Id 4 has been deleted by 2', CAST(N'2022-07-17T15:25:56.573' AS DateTime), 2, 2, CAST(N'2022-07-17T15:25:56.573' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (55, N'ObjectInsert', N'The Segment with Id 5 has been upserted by User with Id 2', CAST(N'2022-07-17T15:26:01.090' AS DateTime), 2, 2, CAST(N'2022-07-17T15:26:01.090' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (56, N'ObjectInsert', N'The Segment with Id 6 has been upserted by User with Id 2', CAST(N'2022-07-17T15:26:01.377' AS DateTime), 2, 2, CAST(N'2022-07-17T15:26:01.377' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (57, N'ObjectInsert', N'The Segment with Id 7 has been upserted by User with Id 2', CAST(N'2022-07-17T15:26:01.470' AS DateTime), 2, 2, CAST(N'2022-07-17T15:26:01.470' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (58, N'ObjectInsert', N'The Segment with Id 8 has been upserted by User with Id 2', CAST(N'2022-07-17T15:27:25.310' AS DateTime), 2, 2, CAST(N'2022-07-17T15:27:25.310' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (59, N'ObjectInsert', N'The Segment with Id 9 has been upserted by User with Id 2', CAST(N'2022-07-17T15:27:25.320' AS DateTime), 2, 2, CAST(N'2022-07-17T15:27:25.320' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (60, N'ObjectInsert', N'The Segment with Id 10 has been upserted by User with Id 2', CAST(N'2022-07-17T15:27:25.327' AS DateTime), 2, 2, CAST(N'2022-07-17T15:27:25.327' AS DateTime), N'Segment')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (61, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-17T17:36:18.747' AS DateTime), 2, 2, CAST(N'2022-07-17T17:36:18.747' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (62, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-07-17T19:48:04.523' AS DateTime), 2, 2, CAST(N'2022-07-17T19:48:04.523' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (63, N'ObjectInsert', N'The Channel with Id 9 has been upserted by User with Id  2', CAST(N'2022-07-17T20:22:07.533' AS DateTime), 2, 2, CAST(N'2022-07-17T20:22:07.533' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (64, N'ObjectDelete', N'The Channel with Id 9 has been deleted by 2', CAST(N'2022-07-17T20:22:11.750' AS DateTime), 2, 2, CAST(N'2022-07-17T20:22:11.750' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (65, N'ObjectDelete', N'The Channel with Id 9 has been deleted by 2', CAST(N'2022-07-17T20:22:19.020' AS DateTime), 2, 2, CAST(N'2022-07-17T20:22:19.020' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (66, N'ObjectDelete', N'The Channel with Id 9 has been deleted by 2', CAST(N'2022-07-17T20:22:21.293' AS DateTime), 2, 2, CAST(N'2022-07-17T20:22:21.293' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (67, N'ObjectDelete', N'The Channel with Id 9 has been deleted by 2', CAST(N'2022-07-17T20:23:15.887' AS DateTime), 2, 2, CAST(N'2022-07-17T20:23:15.887' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (68, N'ObjectDelete', N'The Channel with Id 9 has been deleted by 2', CAST(N'2022-07-17T20:31:53.137' AS DateTime), 2, 2, CAST(N'2022-07-17T20:31:53.137' AS DateTime), N'Channel')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (69, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-03T22:34:29.857' AS DateTime), 2, 2, CAST(N'2022-08-03T22:34:29.857' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (70, N'ObjectDelete', N'The User with Id 6 has been deleted by 2', CAST(N'2022-08-03T22:56:27.417' AS DateTime), 2, 2, CAST(N'2022-08-03T22:56:27.417' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (71, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-03T22:56:51.513' AS DateTime), 2, 2, CAST(N'2022-08-03T22:56:51.513' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (72, N'ObjectUpdate', N'The Permission with Id 13 has been upserted by User with Id 2', CAST(N'2022-08-03T23:10:35.663' AS DateTime), 2, 2, CAST(N'2022-08-03T23:10:35.663' AS DateTime), N'Permission')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (73, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-03T23:32:02.793' AS DateTime), 2, 2, CAST(N'2022-08-03T23:32:02.793' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (74, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:07:44.623' AS DateTime), 2, 2, CAST(N'2022-08-04T02:07:44.623' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (75, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:07:48.133' AS DateTime), 2, 2, CAST(N'2022-08-04T02:07:48.133' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (76, N'Logout', N'The User with Id 2 has logged out', CAST(N'2022-08-04T02:20:41.003' AS DateTime), 2, 2, CAST(N'2022-08-04T02:20:41.003' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (77, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:20:46.567' AS DateTime), 2, 2, CAST(N'2022-08-04T02:20:46.567' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (78, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T02:20:46.567' AS DateTime), 2, 2, CAST(N'2022-08-04T02:20:46.567' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (79, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:20:53.133' AS DateTime), 2, 2, CAST(N'2022-08-04T02:20:53.133' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (80, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T02:20:53.160' AS DateTime), 2, 2, CAST(N'2022-08-04T02:20:53.160' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (81, N'Logout', N'The User with Id 2 has logged out', CAST(N'2022-08-04T02:53:05.450' AS DateTime), 2, 2, CAST(N'2022-08-04T02:53:05.450' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (82, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:53:13.627' AS DateTime), 2, 2, CAST(N'2022-08-04T02:53:13.627' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (83, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T02:53:13.740' AS DateTime), 2, 2, CAST(N'2022-08-04T02:53:13.740' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (84, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:53:21.253' AS DateTime), 2, 2, CAST(N'2022-08-04T02:53:21.253' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (85, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T02:53:21.260' AS DateTime), 2, 2, CAST(N'2022-08-04T02:53:21.260' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (86, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:58:18.157' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:18.157' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (87, N'Logout', N'The User with Id 2 has logged out', CAST(N'2022-08-04T02:58:27.760' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:27.760' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (88, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:58:34.837' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:34.837' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (89, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:58:38.800' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:38.800' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (90, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T02:58:38.807' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:38.807' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (91, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T02:58:56.517' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:56.517' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (92, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T02:58:56.520' AS DateTime), 2, 2, CAST(N'2022-08-04T02:58:56.520' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (93, N'ObjectUpdate', N'The User with Id 2 has been upserted by User with Id 2', CAST(N'2022-08-04T03:33:23.473' AS DateTime), 2, 2, CAST(N'2022-08-04T03:33:23.473' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (94, N'Login', N'The User with Id 2 has logged in', CAST(N'2022-08-04T03:33:23.477' AS DateTime), 2, 2, CAST(N'2022-08-04T03:33:23.477' AS DateTime), N'User')
INSERT [dbo].[Log] ([Id], [EventType], [Message], [CreatedDate], [CreatedById], [LastModifiedById], [LastModifiedDate], [Entity]) VALUES (95, N'BulkOperation', N'A Bulk Interaction Upsert has been made by the user with Id 2', CAST(N'2022-08-04T03:34:28.817' AS DateTime), 2, 2, CAST(N'2022-08-04T03:34:28.817' AS DateTime), N'Interaction')
SET IDENTITY_INSERT [dbo].[Log] OFF
GO
SET IDENTITY_INSERT [dbo].[Permission] ON 

INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (3, N'Interaction-Create', N'Regular', 1, CAST(N'2022-07-09T16:46:00.087' AS DateTime), CAST(N'2022-07-09T16:46:00.087' AS DateTime), 1, 1, N'Permission to Create Interactions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (5, N'Interaction-Edit', N'Regular', 1, CAST(N'2022-07-09T18:07:11.800' AS DateTime), CAST(N'2022-07-09T18:07:11.800' AS DateTime), 1, 1, N'Permission to Edit Interactions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (6, N'Test', N'Group', 1, CAST(N'2022-07-09T21:02:35.720' AS DateTime), CAST(N'2022-07-10T12:02:09.393' AS DateTime), 2, 2, N'Test')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (8, N'Administrator', N'Group', 1, CAST(N'2022-07-10T15:56:07.217' AS DateTime), CAST(N'2022-07-10T15:56:15.497' AS DateTime), 2, 2, N'Admin Profile that can do anything! ')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (9, N'Administrator', N'Group', 1, CAST(N'2022-07-10T15:59:41.950' AS DateTime), CAST(N'2022-07-10T15:59:45.757' AS DateTime), 2, 2, N'Some Description')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (10, N'Administrator', N'Group', 1, CAST(N'2022-07-10T16:02:50.243' AS DateTime), CAST(N'2022-07-10T16:21:27.960' AS DateTime), 2, 2, N'13')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (11, N'Administrator', N'Group', 1, CAST(N'2022-07-10T16:21:42.050' AS DateTime), CAST(N'2022-07-10T16:22:10.337' AS DateTime), 2, 2, N'1234')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (12, N'Administrator', N'Group', 1, CAST(N'2022-07-10T16:25:51.920' AS DateTime), CAST(N'2022-07-10T16:29:08.000' AS DateTime), 2, 2, N'asdasd')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (13, N'Administrator', N'Group', 0, CAST(N'2022-07-10T16:29:47.550' AS DateTime), CAST(N'2022-08-03T23:10:35.597' AS DateTime), 2, 2, N'asfasdf')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (14, N'Analista', N'Group', 0, CAST(N'2022-07-10T20:23:55.023' AS DateTime), CAST(N'2022-07-10T20:23:55.023' AS DateTime), 2, 2, N'Permisos para analistas! :D ')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (15, N'User-Read', N'Regular', 0, CAST(N'2022-07-10T22:06:45.630' AS DateTime), CAST(N'2022-07-10T22:06:45.630' AS DateTime), 1, 1, N'Permission to Read Users')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (16, N'User-Delete', N'Regular', 0, CAST(N'2022-07-10T22:07:20.133' AS DateTime), CAST(N'2022-07-10T22:07:20.133' AS DateTime), 1, 1, N'Permission to Delete Users')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (17, N'User-Create', N'Regular', 0, CAST(N'2022-07-10T22:12:53.400' AS DateTime), CAST(N'2022-07-10T22:12:53.400' AS DateTime), 1, 1, N'Permission to Create Users')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (18, N'User-Edit', N'Regular', 0, CAST(N'2022-07-11T00:34:39.047' AS DateTime), CAST(N'2022-07-11T00:34:39.047' AS DateTime), 1, 1, N'Permission to Edit Users')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (19, N'Channel-Read', N'Regular', 0, CAST(N'2022-07-11T22:33:13.410' AS DateTime), CAST(N'2022-07-11T22:33:13.410' AS DateTime), 1, 1, N'Permission to Read Channels')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (20, N'Channel-Delete', N'Regular', 0, CAST(N'2022-07-11T22:33:38.743' AS DateTime), CAST(N'2022-07-11T22:33:38.743' AS DateTime), 1, 1, N'Permission to Delete Channels')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (21, N'Channel-Create', N'Regular', 0, CAST(N'2022-07-11T22:34:01.510' AS DateTime), CAST(N'2022-07-11T22:34:01.510' AS DateTime), 1, 1, N'Permission to Create Channels')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (22, N'Channel-Edit', N'Regular', 0, CAST(N'2022-07-11T22:34:17.197' AS DateTime), CAST(N'2022-07-11T22:34:17.197' AS DateTime), 1, 1, N'Permission to Edit Channels')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (23, N'Permission-Read', N'Regular', 0, CAST(N'2022-07-11T23:54:13.307' AS DateTime), CAST(N'2022-07-11T23:54:13.307' AS DateTime), 1, 1, N'Permission to Read Permissions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (24, N'Permission-Delete', N'Regular', 0, CAST(N'2022-07-11T23:54:46.197' AS DateTime), CAST(N'2022-07-11T23:54:46.197' AS DateTime), 1, 1, N'Permission to Delete Group Permissions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (25, N'Permission-Create', N'Regular', 0, CAST(N'2022-07-11T23:55:12.633' AS DateTime), CAST(N'2022-07-11T23:55:12.633' AS DateTime), 1, 1, N'Permission to Create Group Permissions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (26, N'Permission-Edit', N'Regular', 0, CAST(N'2022-07-11T23:55:34.150' AS DateTime), CAST(N'2022-07-11T23:55:34.150' AS DateTime), 1, 1, N'Permission to Edit Group Permissions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (27, N'Log-Read', N'Regular', 0, CAST(N'2022-07-12T23:15:23.753' AS DateTime), CAST(N'2022-07-12T23:15:23.753' AS DateTime), 1, 1, N'Permission to Read Logs')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (28, N'Customer-Read', N'Regular', 0, CAST(N'2022-07-13T00:52:25.443' AS DateTime), CAST(N'2022-07-13T00:52:25.443' AS DateTime), 1, 1, N'Permission to Read Customers')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (29, N'Customer-Delete', N'Regular', 0, CAST(N'2022-07-13T00:52:51.710' AS DateTime), CAST(N'2022-07-13T00:52:51.710' AS DateTime), 1, 1, N'Permission to Delete Customers')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (30, N'Customer-Create', N'Regular', 0, CAST(N'2022-07-13T00:53:05.520' AS DateTime), CAST(N'2022-07-13T00:53:05.520' AS DateTime), 1, 1, N'Permission to Create Customers')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (31, N'Customer-Edit', N'Regular', 0, CAST(N'2022-07-13T00:53:23.173' AS DateTime), CAST(N'2022-07-13T00:53:23.173' AS DateTime), 1, 1, N'Permission to Edit Customers')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (32, N'Campaign-Read', N'Regular', 0, CAST(N'2022-07-13T21:23:43.593' AS DateTime), CAST(N'2022-07-13T21:23:43.593' AS DateTime), 1, 1, N'Permission to Read Campaigns')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (33, N'Campaign-Delete', N'Regular', 0, CAST(N'2022-07-13T21:23:58.917' AS DateTime), CAST(N'2022-07-13T21:23:58.917' AS DateTime), 1, 1, N'Permission to Delete Campaigns')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (34, N'Campaign-Create', N'Regular', 0, CAST(N'2022-07-13T21:24:13.297' AS DateTime), CAST(N'2022-07-13T21:24:13.297' AS DateTime), 1, 1, N'Permission to Create Campaigns')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (35, N'Campaign-Edit', N'Regular', 0, CAST(N'2022-07-13T21:24:28.953' AS DateTime), CAST(N'2022-07-13T21:24:28.953' AS DateTime), 1, 1, N'Permission to Edit Campaigns')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (36, N'Interaction-Read', N'Regular', 0, CAST(N'2022-07-14T00:49:39.710' AS DateTime), CAST(N'2022-07-14T00:49:39.710' AS DateTime), 1, 1, N'Permission to Read Interactions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (37, N'Interaction-Delete', N'Regular', 0, CAST(N'2022-07-14T00:49:59.487' AS DateTime), CAST(N'2022-07-14T00:49:59.487' AS DateTime), 1, 1, N'Permission to Delete Interactions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (38, N'Interaction-Create', N'Regular', 0, CAST(N'2022-07-14T00:50:16.873' AS DateTime), CAST(N'2022-07-14T00:50:16.873' AS DateTime), 1, 1, N'Permission to Create Interactions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (39, N'Interaction-Edit', N'Regular', 0, CAST(N'2022-07-14T00:50:42.730' AS DateTime), CAST(N'2022-07-14T00:50:42.730' AS DateTime), 1, 1, N'Permission to Edit Interactions')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (40, N'Interaction-Bulk Create', N'Regular', 0, CAST(N'2022-07-14T00:52:14.757' AS DateTime), CAST(N'2022-07-14T00:52:14.757' AS DateTime), 1, 1, N'Permission to Create Interactions by CSV upload')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (41, N'Segment-Read', N'Regular', 0, CAST(N'2022-07-14T02:51:41.673' AS DateTime), CAST(N'2022-07-14T02:51:41.673' AS DateTime), 1, 1, N'Permission to Read Segments')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (42, N'Segment-Delete', N'Regular', 0, CAST(N'2022-07-14T02:51:57.907' AS DateTime), CAST(N'2022-07-14T02:51:57.907' AS DateTime), 1, 1, N'Permission to Delete Segments')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (43, N'Segment-Create', N'Regular', 0, CAST(N'2022-07-14T02:52:10.827' AS DateTime), CAST(N'2022-07-14T02:52:10.827' AS DateTime), 1, 1, N'Permission to Create Segments')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (44, N'Segment-Edit', N'Regular', 0, CAST(N'2022-07-14T02:52:25.987' AS DateTime), CAST(N'2022-07-14T02:52:25.987' AS DateTime), 1, 1, N'Permission to Edit Segments')
INSERT [dbo].[Permission] ([Id], [Name], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById], [Description]) VALUES (45, N'Journey-Read', N'Regular', 0, CAST(N'2022-07-14T14:30:09.097' AS DateTime), CAST(N'2022-07-14T14:30:09.097' AS DateTime), 1, 1, N'Permission to Read Journey')
SET IDENTITY_INSERT [dbo].[Permission] OFF
GO
SET IDENTITY_INSERT [dbo].[PermissionToPermission] ON 

INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (12, 3, 14)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (212, 15, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (213, 16, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (214, 17, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (215, 18, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (216, 19, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (217, 20, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (218, 21, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (219, 22, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (220, 23, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (221, 24, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (222, 25, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (223, 26, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (224, 27, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (225, 28, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (226, 29, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (227, 30, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (228, 31, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (229, 32, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (230, 33, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (231, 34, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (232, 35, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (233, 36, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (234, 37, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (235, 40, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (236, 41, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (237, 42, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (238, 43, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (239, 44, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (240, 45, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (241, 38, 13)
INSERT [dbo].[PermissionToPermission] ([Id], [ChildPermissionId], [ParentPermissionId]) VALUES (242, 39, 13)
SET IDENTITY_INSERT [dbo].[PermissionToPermission] OFF
GO
SET IDENTITY_INSERT [dbo].[Segment] ON 

INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (1, N'1', N'some test', N'Demographic', 1, CAST(N'2022-06-27T01:09:21.417' AS DateTime), CAST(N'2022-07-14T15:56:27.627' AS DateTime), 0, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (2, N'Auto generated segment 0 17/7/2022 15:23:22', N'Auto generated segment', N'Auto generated', 1, CAST(N'2022-07-17T15:23:22.180' AS DateTime), CAST(N'2022-07-17T15:25:53.740' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (3, N'Auto generated segment 1 17/7/2022 15:23:22', N'Auto generated segment', N'Auto generated', 1, CAST(N'2022-07-17T15:23:22.320' AS DateTime), CAST(N'2022-07-17T15:25:55.583' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (4, N'Auto generated segment 2 17/7/2022 15:23:22', N'Auto generated segment', N'Auto generated', 1, CAST(N'2022-07-17T15:23:22.343' AS DateTime), CAST(N'2022-07-17T15:25:56.487' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (5, N'Auto generated segment 0 17/7/2022 15:26:00', N'Auto generated segment', N'Auto generated', 0, CAST(N'2022-07-17T15:26:00.967' AS DateTime), CAST(N'2022-07-17T15:26:00.967' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (6, N'Auto generated segment 1 17/7/2022 15:26:00', N'Auto generated segment', N'Auto generated', 0, CAST(N'2022-07-17T15:26:01.110' AS DateTime), CAST(N'2022-07-17T15:26:01.110' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (7, N'Auto generated segment 2 17/7/2022 15:26:00', N'Auto generated segment', N'Auto generated', 0, CAST(N'2022-07-17T15:26:01.403' AS DateTime), CAST(N'2022-07-17T15:26:01.403' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (8, N'Auto generated segment 0 17/7/2022 15:27:25', N'Auto generated segment', N'Auto generated', 0, CAST(N'2022-07-17T15:27:25.290' AS DateTime), CAST(N'2022-07-17T15:27:25.290' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (9, N'Auto generated segment 1 17/7/2022 15:27:25', N'Auto generated segment', N'Auto generated', 0, CAST(N'2022-07-17T15:27:25.313' AS DateTime), CAST(N'2022-07-17T15:27:25.313' AS DateTime), 2, 2)
INSERT [dbo].[Segment] ([Id], [Name], [Description], [Type], [IsDeleted], [CreatedDate], [LastModifiedDate], [CreatedById], [LastModifiedById]) VALUES (10, N'Auto generated segment 2 17/7/2022 15:27:25', N'Auto generated segment', N'Auto generated', 0, CAST(N'2022-07-17T15:27:25.320' AS DateTime), CAST(N'2022-07-17T15:27:25.320' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Segment] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Username], [Password], [Email], [BlockCounter], [Status], [IsDeleted], [CreatedById], [LastModifiedById], [CreatedDate], [LastModifiedDate], [FirstName], [LastName]) VALUES (2, N'admin@admin.com', N'5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5', N'suarez.gastonalejandro@gmail.com', 0, N'Active', 0, 2, 2, CAST(N'2022-06-13T20:27:00.000' AS DateTime), CAST(N'2022-08-04T03:33:23.393' AS DateTime), N'Gastón', N'Suárez')
INSERT [dbo].[User] ([Id], [Username], [Password], [Email], [BlockCounter], [Status], [IsDeleted], [CreatedById], [LastModifiedById], [CreatedDate], [LastModifiedDate], [FirstName], [LastName]) VALUES (4, N'hola@hola.com', N'03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', N'suarez.gastonalejandro@gmail.com', 0, N'Active', 1, 2, 2, CAST(N'2022-06-14T23:35:02.160' AS DateTime), CAST(N'2022-06-14T23:37:44.740' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([Id], [Username], [Password], [Email], [BlockCounter], [Status], [IsDeleted], [CreatedById], [LastModifiedById], [CreatedDate], [LastModifiedDate], [FirstName], [LastName]) VALUES (5, N'ingrid@ingrid.com', N'03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', N'mancera.ingridsofia@gmail.com', 0, N'Blocked', 0, 2, 2, CAST(N'2022-07-10T23:52:20.377' AS DateTime), CAST(N'2022-07-11T21:56:55.457' AS DateTime), N'Ingrid', N'Mancera')
INSERT [dbo].[User] ([Id], [Username], [Password], [Email], [BlockCounter], [Status], [IsDeleted], [CreatedById], [LastModifiedById], [CreatedDate], [LastModifiedDate], [FirstName], [LastName]) VALUES (6, N'test@test.com', N'03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', N'test@test.com', 0, N'Active', 1, 2, 2, CAST(N'2022-07-11T22:00:18.633' AS DateTime), CAST(N'2022-08-03T22:56:27.350' AS DateTime), N'test', N'test')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserPermission] ON 

INSERT [dbo].[UserPermission] ([Id], [UserId], [PermissionId]) VALUES (21, 5, 13)
INSERT [dbo].[UserPermission] ([Id], [UserId], [PermissionId]) VALUES (22, 6, 13)
INSERT [dbo].[UserPermission] ([Id], [UserId], [PermissionId]) VALUES (23, 6, 14)
INSERT [dbo].[UserPermission] ([Id], [UserId], [PermissionId]) VALUES (67, 2, 13)
INSERT [dbo].[UserPermission] ([Id], [UserId], [PermissionId]) VALUES (68, 2, 14)
SET IDENTITY_INSERT [dbo].[UserPermission] OFF
GO
ALTER TABLE [dbo].[Campaign] ADD  CONSTRAINT [DF_Campaign_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Campaign] ADD  CONSTRAINT [DF_Campaign_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [dbo].[Channel] ADD  CONSTRAINT [DF_Channel_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Interaction] ADD  CONSTRAINT [DF_Interaction_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Interaction] ADD  CONSTRAINT [DF_Interaction_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Interaction] ADD  CONSTRAINT [DF_Interaction_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [dbo].[Segment] ADD  CONSTRAINT [DF_Segmentation_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_BlockCounter]  DEFAULT ((0)) FOR [BlockCounter]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
ALTER TABLE [dbo].[Interaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Interaction_Campaign] FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaign] ([Id])
GO
ALTER TABLE [dbo].[Interaction] CHECK CONSTRAINT [FK_Interaction_Campaign]
GO
ALTER TABLE [dbo].[Interaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Interaction_Channel] FOREIGN KEY([ChannelId])
REFERENCES [dbo].[Channel] ([Id])
GO
ALTER TABLE [dbo].[Interaction] CHECK CONSTRAINT [FK_Interaction_Channel]
GO
ALTER TABLE [dbo].[Interaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Interaction_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Interaction] CHECK CONSTRAINT [FK_Interaction_Customer]
GO
ALTER TABLE [dbo].[Interaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Interaction_Interaction] FOREIGN KEY([Id])
REFERENCES [dbo].[Interaction] ([Id])
GO
ALTER TABLE [dbo].[Interaction] CHECK CONSTRAINT [FK_Interaction_Interaction]
GO
ALTER TABLE [dbo].[PermissionToPermission]  WITH CHECK ADD  CONSTRAINT [FK_ChildPermission] FOREIGN KEY([ChildPermissionId])
REFERENCES [dbo].[Permission] ([Id])
GO
ALTER TABLE [dbo].[PermissionToPermission] CHECK CONSTRAINT [FK_ChildPermission]
GO
ALTER TABLE [dbo].[PermissionToPermission]  WITH CHECK ADD  CONSTRAINT [FK_ParentPermission] FOREIGN KEY([ParentPermissionId])
REFERENCES [dbo].[Permission] ([Id])
GO
ALTER TABLE [dbo].[PermissionToPermission] CHECK CONSTRAINT [FK_ParentPermission]
GO
ALTER TABLE [dbo].[UserPermission]  WITH CHECK ADD  CONSTRAINT [FK_UserPermission_Permission] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permission] ([Id])
GO
ALTER TABLE [dbo].[UserPermission] CHECK CONSTRAINT [FK_UserPermission_Permission]
GO
ALTER TABLE [dbo].[UserPermission]  WITH CHECK ADD  CONSTRAINT [FK_UserPermission_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserPermission] CHECK CONSTRAINT [FK_UserPermission_User]
GO
/****** Object:  StoredProcedure [dbo].[CreateLog]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateLog]
@EventType varchar(50),
@Entity varchar(50) Null,
@Message varchar(250),
@CreatedById int,
@LastModifiedById int

AS
BEGIN
	INSERT INTO [dbo].[Log] (Entity, EventType,Message,CreatedById,LastModifiedById,CreatedDate,LastModifiedDate)
	VALUES (@Entity, @EventType,@Message,@CreatedById,@LastModifiedById,GETDATE(),GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCampaign]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCampaign]
@Id varchar(50),
@LastModifiedById int
AS
BEGIN
	UPDATE  [dbo].[Campaign]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(),LastModifiedById = @LastModifiedById
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteChannel]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteChannel]
@Id varchar(50),
@LastModifiedById int
AS
BEGIN
	UPDATE  [dbo].[Channel]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCustomer]
@Id varchar(50),
@LastModifiedById int
AS
BEGIN
	UPDATE  [dbo].[Customer]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id;
	UPDATE [dbo].[Interaction]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(), LastModifiedById = @LastModifiedById
	WHERE CustomerId = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteInteraction]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteInteraction]
@Id varchar(50),
@LastModifiedById int
AS
BEGIN
	UPDATE  [dbo].[Interaction]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeletePermission]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePermission]
@Id varchar(50),
@LastModifiedById int
AS
BEGIN
	DELETE From PermissionToPermission Where ParentPermissionId = @Id OR ChildPermissionId = @Id;
	DELETE FROM UserPermission WHERE PermissionId = @Id;
	UPDATE  [dbo].[Permission]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteSegment]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteSegment]
@Id varchar(50),
@LastModifiedById int null
AS
BEGIN
	UPDATE  [dbo].[Segment]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUser]
@Id int,
@LastModifiedById int
AS
BEGIN
	UPDATE  [dbo].[User]
	SET IsDeleted = 1, LastModifiedDate = GETDATE(),LastModifiedById = @LastModifiedById
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetCampaigns]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCampaigns]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	

SELECT [Id]
      ,[Name]
      ,[Status]
      ,[ActualCost]
      ,[BudgetedCost]
      ,[Description]
      ,[ExpectedRevenue]
      ,[StartDate]
      ,[EndDate]
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[CreatedById]
      ,[LastModifiedById]
  FROM [dbo].[Campaign]

 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetChannels]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetChannels]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	

SELECT [Id]
      ,[Name]
      ,[Type]
    
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[LastModifiedById]
      ,[CreatedById]
  FROM [dbo].[Channel]



 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetChildPermissions]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetChildPermissions]
	-- Add the parameters for the stored procedure here
@Id int 
	
AS
BEGIN
	

SELECT [Id]
      ,[Name]
      ,[Type]
	  ,[Description]
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[CreatedById]
      ,[LastModifiedById]
  FROM [dbo].[Permission]
  WHERE Id IN (
	SELECT ChildPermissionId FROM PermissionToPermission
	WHERE ParentPermissionId = @Id)
 And IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomers]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT[Id]
      ,[Name]
      ,[Email]
      ,[DateOfBirth]
	  ,[ExternalId]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
	  
  FROM [dbo].[Customer]
 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetInteractions]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetInteractions]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN

SELECT [Id]
      ,[Type]
      ,[ChannelId]
      ,[CampaignId]
      ,[CustomerId]
      ,[Date]
      ,[Revenue]
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[CreatedById]
      ,[LastModifiedById]
  FROM [dbo].[Interaction]





 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetLogs]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLogs]

AS
BEGIN
	Select Id,Entity, EventType, Message, CreatedDate,CreatedById,LastModifiedDate,LastModifiedById
	From Log ORDER BY CreatedDate DESC 
END
GO
/****** Object:  StoredProcedure [dbo].[GetPermissions]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPermissions]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	

SELECT [Id]
      ,[Name]
      ,[Type]
	  ,[Description]
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[CreatedById]
      ,[LastModifiedById]
  FROM [dbo].[Permission]

 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetSegmentCustomers]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSegmentCustomers]
	-- Add the parameters for the stored procedure here
@SegmentId int 
	
AS
BEGIN
	

SELECT[Id]
      ,[Name]
      ,[Email]
      ,[DateOfBirth]
	  ,[ExternalId]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
	  
  FROM [dbo].[Customer]
  WHERE Id IN (
	SELECT CustomerId FROM CustomerSegment
	WHERE SegmentId = @SegmentId)
 And IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetSegments]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetSegments]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN

SELECT [Id]
      ,[Type]
      ,[Name]
      ,[Description]
     
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[CreatedById]
      ,[LastModifiedById]
  FROM [dbo].[Segment]





 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsername]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserByUsername]
	-- Add the parameters for the stored procedure here
	@Username varchar(50)
AS
BEGIN
	SELECT [Id]
      ,[Username]
      ,[Password]
      ,[Email]
	  ,[Status]
	  ,[FirstName]
	  ,[LastName]
	  ,[CreatedDate]
	  ,[CreatedById]
	  ,[LastModifiedDate]
	  ,[LastModifiedById]
	  ,[BlockCounter]
	  
  FROM [dbo].[User] WHERE [Username] = @Username
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserPermissions]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserPermissions]
	-- Add the parameters for the stored procedure here
@UserId int 
	
AS
BEGIN
	

SELECT [Id]
      ,[Name]
      ,[Type]
	  ,[Description]
      ,[CreatedDate]
      ,[LastModifiedDate]
      ,[CreatedById]
      ,[LastModifiedById]
  FROM [dbo].[Permission]
  WHERE Id IN (
	SELECT PermissionId FROM UserPermission
	WHERE UserId = @UserId)
 And IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUsers]
AS
BEGIN
	SELECT [Id]
      ,[Username]
      ,[Email]
	  ,[Status]
	  ,[Password]
	  ,[FirstName]
	  ,[LastName]
	  ,[CreatedById]
	  ,[CreatedDate]
	  ,[LastModifiedDate]
	  ,[LastModifiedById]
	  ,[BlockCounter]
  FROM [dbo].[User]
  WHERE [IsDeleted] = 0
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertCampaign]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertCampaign]
@Id int = NULL,
@Name varchar(50),
@Status varchar(50),
@ActualCost decimal(16,2) = null,
@BudgetedCost decimal(16,2) = null,
@Description varchar(500) = null,
@ExpectedRevenue decimal(16,2) = null,
@StartDate datetime = null ,
@EndDate datetime = null,
@LastModifiedById int = null,
@CreatedById int = null
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Campaign] 
	SET Name = @Name, Status = @Status, ActualCost = @ActualCost,BudgetedCost = @BudgetedCost,
	Description = @Description, ExpectedRevenue = @ExpectedRevenue, StartDate = @StartDate,
	EndDate = @EndDate, LastModifiedDate=GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
    IF @@ROWCOUNT = 0
	INSERT INTO [dbo].[Campaign] (Name,Status,ActualCost,BudgetedCost
	,Description
	,ExpectedRevenue
	,StartDate
	,EndDate
	,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById)
	VALUES (@Name,@Status,@ActualCost,@BudgetedCost,@Description, @ExpectedRevenue, @StartDate, @EndDate
	,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById)
	  SET NOCOUNT OFF;
	  SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertChannel]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertChannel]
@Id int = NULL,
@Name varchar(50)=Null,
@Type varchar(50)=Null,
@CreatedById int = Null,
@LastModifiedById int = Null
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Channel] 
	SET Name = @Name, Type = @Type, LastModifiedDate=GETDATE(),LastModifiedById = @LastModifiedById
	WHERE Id = @Id
    IF @@ROWCOUNT = 0
	INSERT INTO [dbo].[Channel] (Name,Type
	,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById)
	VALUES (@Name,@Type
	,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById);
	SElect SCOPE_IDENTITY();
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertChildrenPermissions]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertChildrenPermissions]
    @PermTable dbo.ChildPermissions READONLY,
	@Parent int
AS
BEGIN
	DELETE FROM dbo.PermissionToPermission WHERE ParentPermissionId = @Parent
    INSERT INTO dbo.PermissionToPermission (ParentPermissionId, ChildPermissionId) SELECT ParentId,ChildId FROM @PermTable
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertCustomer]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertCustomer]
@Id int = NULL,
@Name varchar(50),
@Email varchar(50),
@DateOfBirth DateTime NULL,
@ExternalId varchar(50) Null,
@CreatedById int Null,
@LastModifiedById int null
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Customer] 
	SET Name = @Name, Email = @Email,DateOfBirth = @DateOfBirth,ExternalId =@ExternalId , LastModifiedDate=GETDATE()
	WHERE Id = @Id
    IF @@ROWCOUNT = 0
	INSERT INTO [dbo].[Customer] (Name,Email,DateOfBirth,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById,ExternalId)
	VALUES (@Name,@Email,@DateOfBirth,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById,@ExternalId);
	SELECT SCOPE_IDENTITY();
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertInteraction]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertInteraction]
@Id int = NULL,
@Type varchar(50),
@ChannelId int =null,
@CampaignId int= null,
@CustomerId int = null,
@Date datetime = null,
@Revenue decimal(16,2) = null,
@LastModifiedById int null,
@CreatedById int null
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Interaction] 
	SET Type = @Type, ChannelId = @ChannelId, CampaignId = @CampaignId,CustomerId = @CustomerId,
	Date = @Date, Revenue = @Revenue,
	LastModifiedDate=GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
    IF @@ROWCOUNT = 0
	INSERT INTO [dbo].[Interaction] (Type,ChannelId,CampaignId,CustomerId
	,Date
	,Revenue
	,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById)
	VALUES (@Type,@ChannelId,@CampaignId,@CustomerId,@Date, @Revenue
	,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById)
	  SET NOCOUNT OFF;
	  SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertPermission]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpsertPermission]
@Id int = NULL,
@Name varchar(50),
@Description varchar(500),
@Type varchar(50),
@CreatedById int,
@LastModifiedById int



AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Permission] 
	SET Name = @Name,Description = @Description, Type = @Type, @LastModifiedById = @LastModifiedById, LastModifiedDate=GETDATE()
	WHERE Id = @Id
IF @@ROWCOUNT = 0
  INSERT INTO [dbo].[Permission] (
	Name
	,Description	
	,Type
	,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById
  ) VALUES (
      @Name
    , @Description
    , @Type
	,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById
  );
 SELECT SCOPE_IDENTITY();
  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertSegment]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertSegment]
@Id int = NULL,
@Type varchar(50),
@Name varchar(50) =null,
@Description varchar(500) = null,
@CreatedById int = null,
@LastModifiedById int null

AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Segment] 
	SET Type = @Type, Name = @Name, Description = @Description,
	LastModifiedDate=GETDATE(), LastModifiedById = @LastModifiedById
	WHERE Id = @Id
    IF @@ROWCOUNT = 0
	INSERT INTO [dbo].[Segment] (Type,Name,Description
	,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById)
	VALUES (@Type,@Name,@Description
	,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById);
	SELECT SCOPE_IDENTITY();
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertSegmentCustomers]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertSegmentCustomers]
    @PermTable dbo.CustomerSegmentTemp READONLY,
	@Parent int
AS
BEGIN
	DELETE FROM dbo.CustomerSegment WHERE SegmentId = @Parent
    INSERT INTO dbo.CustomerSegment(SegmentId, CustomerId) SELECT SegmentId,CustomerId FROM @PermTable
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertUser]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpsertUser]
@Id int = NULL,
@Username varchar(50),
@Email varchar(50),
@Status varchar(50),
@FirstName varchar(50),
@LastName varchar(50),
@CreatedById int,
@LastModifiedById int,
@BlockCounter int,
@Password varchar(64) = NULL



AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[User] 
	SET Username = @Username,Email = @Email, Status = @Status, 
	BlockCounter = @BlockCounter, Password =ISNULL(@Password,Password),
	FirstName =  @FirstName, LastName = @LastName,
	LastModifiedDate=GETDATE(), LastModifiedById = @LastModifiedById 
	WHERE Id = @Id
IF @@ROWCOUNT = 0
  INSERT INTO [dbo].[User] (
     Username
    ,Email
	,Status
	,BlockCounter
	,Password
	,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById
	,FirstName
	,LastName

  ) VALUES (
      @Username
    , @Email
    , @Status
	,@BlockCounter
	,@Password
	,GETDATE()
	,GETDATE()
	,@CreatedById,@LastModifiedById,@FirstName,@LastName
  );
  SELECT SCOPE_IDENTITY();
  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertUserPermissions]    Script Date: 04/08/2022 4:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertUserPermissions]
    @PermTable dbo.UserPermissionsTemp READONLY,
	@Parent int
AS
BEGIN
	DELETE FROM dbo.UserPermission WHERE UserId = @Parent
    INSERT INTO dbo.UserPermission(UserId, PermissionId) SELECT UserId,PermissionId FROM @PermTable
END
GO
USE [master]
GO
ALTER DATABASE [DataInteractionV2] SET  READ_WRITE 
GO
