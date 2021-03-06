USE [master]
GO
/****** Object:  Database [DataInteractionV2]    Script Date: 16/06/2022 19:34:49 ******/
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
/****** Object:  Table [dbo].[Campaign]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  Table [dbo].[Channel]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Age] [int] NOT NULL,
	[Gender] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedById] [int] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[LastModifiedById] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interaction]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  Table [dbo].[Log]    Script Date: 16/06/2022 19:34:50 ******/
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
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Segment]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 16/06/2022 19:34:50 ******/
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
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
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
/****** Object:  StoredProcedure [dbo].[CreateLog]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateLog]
@EventType varchar(50),
@Message varchar(250),
@CreatedById int,
@LastModifiedById int

AS
BEGIN
	INSERT INTO [dbo].[Log] (EventType,Message,CreatedById,LastModifiedById,CreatedDate,LastModifiedDate)
	VALUES (@EventType,@Message,@CreatedById,@LastModifiedById,GETDATE(),GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCampaign]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCampaign]
@Id varchar(50)
AS
BEGIN
	UPDATE  [dbo].[Campaign]
	SET IsDeleted = 1, LastModifiedDate = GETDATE()
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteChannel]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteChannel]
@Id varchar(50)
AS
BEGIN
	UPDATE  [dbo].[Channel]
	SET IsDeleted = 1, LastModifiedDate = GETDATE()
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCustomer]
@Id varchar(50)
AS
BEGIN
	UPDATE  [dbo].[Customer]
	SET IsDeleted = 1, LastModifiedDate = GETDATE()
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteInteraction]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteInteraction]
@Id varchar(50)
AS
BEGIN
	UPDATE  [dbo].[Interaction]
	SET IsDeleted = 1, LastModifiedDate = GETDATE()
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUser]
@Id varchar(50)
AS
BEGIN
	UPDATE  [dbo].[User]
	SET IsDeleted = 1, LastModifiedDate = GETDATE()
	WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetCampaigns]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  StoredProcedure [dbo].[GetChannels]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 16/06/2022 19:34:50 ******/
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
      ,[Age]
      ,[Gender]
      ,[CreatedDate]
      ,[CreatedById]
      ,[LastModifiedDate]
      ,[LastModifiedById]
	  
  FROM [dbo].[Customer]
 WHERE IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GetInteractions]    Script Date: 16/06/2022 19:34:50 ******/
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
/****** Object:  StoredProcedure [dbo].[GetLogs]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetLogs]

AS
BEGIN
	Select Id, EventType, Message, CreatedDate,CreatedById,LastModifiedDate,LastModifiedById
	From Log
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsername]    Script Date: 16/06/2022 19:34:50 ******/
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
	  ,[CreatedDate]
	  ,[CreatedById]
	  ,[LastModifiedDate]
	  ,[LastModifiedById]
	  ,[BlockCounter]
	  
  FROM [dbo].[User] WHERE [Username] = @Username
END
GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 16/06/2022 19:34:50 ******/
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
	  ,[CreatedById]
	  ,[CreatedDate]
	  ,[LastModifiedDate]
	  ,[LastModifiedById]
	  ,[BlockCounter]
  FROM [dbo].[User]
  WHERE [IsDeleted] = 0
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertCampaign]    Script Date: 16/06/2022 19:34:50 ******/
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
@EndDate datetime = null
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Campaign] 
	SET Name = @Name, Status = @Status, ActualCost = @ActualCost,BudgetedCost = @BudgetedCost,
	Description = @Description, ExpectedRevenue = @ExpectedRevenue, StartDate = @StartDate,
	EndDate = @EndDate, LastModifiedDate=GETDATE()
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
	,2,2)
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertChannel]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertChannel]
@Id int = NULL,
@Name varchar(50)=Null,
@Type varchar(50)=Null
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Channel] 
	SET Name = @Name, Type = @Type, LastModifiedDate=GETDATE()
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
	,2,2)
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertCustomer]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertCustomer]
@Id int = NULL,
@Name varchar(50),
@Email varchar(50),
@Gender varchar(50),
@Age int
AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Customer] 
	SET Name = @Name, Email = @Email, Gender = @Gender,Age = @Age, LastModifiedDate=GETDATE()
	WHERE Id = @Id
    IF @@ROWCOUNT = 0
	INSERT INTO [dbo].[Customer] (Name,Email,Gender,Age,CreatedDate
	,LastModifiedDate
	,CreatedById
	,LastModifiedById)
	VALUES (@Name,@Email,@Gender,@Age,GETDATE()
	,GETDATE()
	,2,2)
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertInteraction]    Script Date: 16/06/2022 19:34:50 ******/
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
@Revenue decimal(16,2) = null

AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[Interaction] 
	SET Type = @Type, ChannelId = @ChannelId, CampaignId = @CampaignId,CustomerId = @CustomerId,
	Date = @Date, Revenue = @Revenue,
	LastModifiedDate=GETDATE()
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
	,2,2)
	  SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UpsertUser]    Script Date: 16/06/2022 19:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpsertUser]
@Id varchar(50) = NULL,
@Username varchar(50),
@Email varchar(50),
@Status varchar(50),
@BlockCounter int,
@Password varchar(64) = NULL



AS
BEGIN
SET NOCOUNT ON;
	UPDATE [dbo].[User] 
	SET Username = @Username,Email = @Email, Status = @Status, BlockCounter = @BlockCounter, Password =ISNULL(@Password,Password), LastModifiedDate=GETDATE()
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
  ) VALUES (
      @Username
    , @Email
    , @Status
	,@BlockCounter
	,@Password
	,GETDATE()
	,GETDATE()
	,2,2
  )
  SET NOCOUNT OFF;
END
GO
USE [master]
GO
ALTER DATABASE [DataInteractionV2] SET  READ_WRITE 
GO
