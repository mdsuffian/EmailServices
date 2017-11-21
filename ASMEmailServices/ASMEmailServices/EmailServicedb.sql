USE [master]
GO
/****** Object:  Database [ASMEmailServices]    Script Date: 20/11/2017 17:19:04 ******/
CREATE DATABASE [ASMEmailServices]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ASMEmailServices', FILENAME = N'D:\Microsoft SQL Server\Data\ASMEmailServices.mdf' , SIZE = 4186112KB , MAXSIZE = UNLIMITED, FILEGROWTH = 4184064KB )
 LOG ON 
( NAME = N'ASMEmailServices_log', FILENAME = N'J:\Microsoft SQL Server\Log\ASMEmailServices_log.ldf' , SIZE = 4185088KB , MAXSIZE = 2048GB , FILEGROWTH = 4184064KB )
GO
ALTER DATABASE [ASMEmailServices] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ASMEmailServices].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ASMEmailServices] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ASMEmailServices] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ASMEmailServices] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ASMEmailServices] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ASMEmailServices] SET ARITHABORT OFF 
GO
ALTER DATABASE [ASMEmailServices] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ASMEmailServices] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ASMEmailServices] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ASMEmailServices] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ASMEmailServices] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ASMEmailServices] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ASMEmailServices] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ASMEmailServices] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ASMEmailServices] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ASMEmailServices] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ASMEmailServices] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ASMEmailServices] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ASMEmailServices] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ASMEmailServices] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ASMEmailServices] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ASMEmailServices] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ASMEmailServices] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ASMEmailServices] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ASMEmailServices] SET  MULTI_USER 
GO
ALTER DATABASE [ASMEmailServices] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ASMEmailServices] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ASMEmailServices] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ASMEmailServices] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ASMEmailServices', N'ON'
GO
USE [ASMEmailServices]
GO
/****** Object:  User [ATMKANBAN]    Script Date: 20/11/2017 17:19:04 ******/
CREATE USER [ATMKANBAN] FOR LOGIN [ATMKANBAN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ATMEX\sql_service]    Script Date: 20/11/2017 17:19:05 ******/
CREATE USER [ATMEX\sql_service] FOR LOGIN [ATMEX\sql_service] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ATMEX\mopadib]    Script Date: 20/11/2017 17:19:05 ******/
CREATE USER [ATMEX\mopadib] FOR LOGIN [ATMEX\mopadib] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ATMKANBAN]
GO
ALTER ROLE [db_owner] ADD MEMBER [ATMEX\sql_service]
GO
/****** Object:  Table [dbo].[tblmsglist]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblmsglist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Source] [nvarchar](50) NULL,
	[Subject] [nvarchar](255) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[From] [nvarchar](50) NULL,
	[To] [nvarchar](255) NULL,
	[cc] [nvarchar](255) NULL,
	[bcc] [nvarchar](255) NULL,
	[MsgBody] [nvarchar](max) NULL,
	[LastAttempt] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CustomFooter] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblmsglist] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblScheduler]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblScheduler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchedulerName] [nvarchar](500) NULL,
	[Description] [nvarchar](1000) NULL,
	[SprocName] [nvarchar](100) NULL,
	[recurrency] [nvarchar](100) NULL,
	[Subject] [nvarchar](3000) NULL,
	[From] [nvarchar](2000) NULL,
	[To] [nvarchar](3000) NULL,
	[cc] [nvarchar](3000) NULL,
	[bcc] [nvarchar](3000) NULL,
	[MsgBody] [nvarchar](max) NULL,
	[LastAttempt] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[LastSuccessAttempt] [datetime] NULL,
	[CustomFooter] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_tblScheduler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblmsglist] ON 

GO
INSERT [dbo].[tblmsglist] ([ID], [Source], [Subject], [Status], [From], [To], [cc], [bcc], [MsgBody], [LastAttempt], [CreatedDate], [CustomFooter]) VALUES (1, N'ASMCanteen', N'Subject Test', N'Completed', N'mopsuffian@atm.asmpt.com', N'mopsuffian@atm.asmpt.com', NULL, NULL, N'<h1 style="color: #5e9ca0;">This is a test <span style="color: #2b2301;">text</span> for testing purpose!</h1>', CAST(N'2017-10-11T10:51:06.470' AS DateTime), CAST(N'2017-10-10T10:35:51.450' AS DateTime), NULL)
GO
INSERT [dbo].[tblmsglist] ([ID], [Source], [Subject], [Status], [From], [To], [cc], [bcc], [MsgBody], [LastAttempt], [CreatedDate], [CustomFooter]) VALUES (8, N'e-SMS', N'subject test', N'Completed', N'mopsuffian@atm.asmpt.com', N'mopsuffian@atm.asmpt.com', NULL, NULL, N'<h1 style="color: #5e9ca0;">Test <span style="color: #2b2301;">text</span> for testing purpose!</h1>', CAST(N'2017-10-11T14:55:47.727' AS DateTime), CAST(N'2017-10-11T14:55:46.863' AS DateTime), NULL)
GO
INSERT [dbo].[tblmsglist] ([ID], [Source], [Subject], [Status], [From], [To], [cc], [bcc], [MsgBody], [LastAttempt], [CreatedDate], [CustomFooter]) VALUES (9, N'ATMKANBAN', N'Test Email', N'Completed', N'atmmisadmin@atm.asmpt.com', N'mopsuffian@atm.asmpt.com', NULL, NULL, N'<h1 style="color: #5e9ca0;">Test <span style="color: #2b2301;">text</span> for testing purpose!</h1>', CAST(N'2017-11-20T16:33:23.947' AS DateTime), CAST(N'2017-10-13T09:51:22.630' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[tblmsglist] OFF
GO
SET IDENTITY_INSERT [dbo].[tblScheduler] ON 

GO
INSERT [dbo].[tblScheduler] ([ID], [SchedulerName], [Description], [SprocName], [recurrency], [Subject], [From], [To], [cc], [bcc], [MsgBody], [LastAttempt], [CreatedDate], [LastSuccessAttempt], [CustomFooter], [Active]) VALUES (1, N'myscheduler', N'to email reminder overdue project', N'usp_Scheduler_SPshortlisttest', N'Thursday', N'reminder for [status] overdue', N'[From]', N'[To]', NULL, NULL, N'this is for testing [MsgBody]', NULL, CAST(N'2017-11-15T15:50:38.367' AS DateTime), NULL, NULL, 0)
GO
INSERT [dbo].[tblScheduler] ([ID], [SchedulerName], [Description], [SprocName], [recurrency], [Subject], [From], [To], [cc], [bcc], [MsgBody], [LastAttempt], [CreatedDate], [LastSuccessAttempt], [CustomFooter], [Active]) VALUES (2, N'SharePoint Equipment Calibration Reminder', N'Reminder Replacement for sharepoint for Equipment Calibration', N'usp_Scheduler_SPCalibrationReminder', N'*', N'Equipment Calibration Reminder - [Equipment No] [Equipment]', N'atmmisadmin@atm.asmpt.com', N'mopsuffian@atm.asmpt.com', NULL, NULL, N'<p>Dear all,</p>
<p>Kindly be informed that the calibration for below equipment will be due on [Calibration Due Date].</p>
<p>Below are the details:<br />Equipment No: [Equipment No]<br />Old Equipment No: [Old Equipment No]<br />Equipment Name: [Equipment]<br />Model: [Model]<br />Serial No: [Serial No]<br />Location: [Location]<br />Last Calibration Date: [Last Cal Date]<br />Calibration Due Date: [Calibration Due Date]<br />Class of Calibration: [Class]</p>
<p>Remarks:<br />C1- External Calibration<br />C2 -Internal Calibration</p>
<p>For external calibration, please issue PR for the calibration job.<br />Equipment must be calibrated at least one day before calibration due date.</p>
<p>Thank you.<br />From: QA</p>', CAST(N'2017-11-20T16:43:23.613' AS DateTime), CAST(N'2017-11-15T00:00:00.000' AS DateTime), CAST(N'2017-11-20T16:43:23.613' AS DateTime), NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[tblScheduler] OFF
GO
ALTER TABLE [dbo].[tblmsglist] ADD  CONSTRAINT [DF_tblmsglist_Status]  DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[tblmsglist] ADD  CONSTRAINT [DF_tblmsglist_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblScheduler] ADD  CONSTRAINT [DF_tblScheduler_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblScheduler] ADD  CONSTRAINT [DF_tblScheduler_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetPendingMsgList]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mohamed Suffian Bin Salehin
-- Create date:     11-10-2017
-- Description:	Get Pending List
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetPendingMsgList] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT      ID, Source, Subject, Status, [From], [To], cc, bcc, MsgBody, LastAttempt, CreatedDate FROM tblmsglist 
	WHERE Status <> 'Completed' 
	      --AND LastAttempt < DATEADD(minute, -5, GETDATE() ); -- only retry after 5 minutes
END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetSchedulerList]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mohamed Suffian Bin Salehin
-- Create date:     11-10-2017
-- Description:	Get Pending List
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetSchedulerList] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  [ID]
      ,[SchedulerName]
      ,[Description]
      ,[SprocName]
      ,[recurrency]
      ,[Subject]
      ,[From]
      ,[To]
      ,[cc]
      ,[bcc]
      ,[MsgBody]
      ,[LastAttempt]
      ,[CreatedDate]
      ,[LastSuccessAttempt]
      ,[CustomFooter]
	 ,[Active]
  FROM [ASMEmailServices].[dbo].[tblScheduler]
  Where active = 1
  AND (DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())) <> DATEADD(dd, 0, DATEDIFF(dd, 0, [LastSuccessAttempt]))  OR [LastAttempt] IS NULL)
	      --AND LastAttempt < DATEADD(minute, -5, GETDATE() ); -- only retry after 5 minutes
END


GO
/****** Object:  StoredProcedure [dbo].[usp_Scheduler_SPCalibrationReminder]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mohamed Suffian Bin Salehin
-- Create date:     11-10-2017
-- Description:	Calibration Reminder Email Scheduler
-- =============================================
CREATE PROCEDURE [dbo].[usp_Scheduler_SPCalibrationReminder] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT        ad.nvarchar1 AS [Equipment No], ad.nvarchar15 AS [Old Equipment No], ad.nvarchar3 AS Equipment, ad.nvarchar4 AS Manufacturer, ad.nvarchar5 AS Model, 
                         ad.nvarchar6 AS [Serial No], ad.nvarchar7 AS [Group], ad.nvarchar8 AS Department, ad.nvarchar9 AS Location, ad.nvarchar10 AS [Calibration By], 
                         ad.nvarchar11 AS [Certificate No], ad.nvarchar12 AS Class, ad.float1 AS [Cal Interval (Month)], ui.tp_Title AS [Responsibility Person], ui2.tp_Title AS Manager, 
                         ad.nvarchar13 AS Remark, ad.nvarchar14 AS Status, ad.nvarchar14 AS Active, ad.datetime1 AS [Last Cal Date], ad.datetime2 AS [Calibration Due Date], 
                         ad.sql_variant2 AS [Quarantine Date], ad.sql_variant1 AS [Reminder Date], ui3.tp_Title AS [QA Personnel], ui4.tp_Title AS [PR Created By], 
                         ui.tp_Email AS [Responsibility Person Email], ui3.tp_Email AS [QA Personnel Email], ui4.tp_Email AS [PR Created By Email]
FROM            atmnts32.WSS_Content_ATMNTS36.dbo.AllUserData AS ad LEFT OUTER JOIN
                         atmnts32.WSS_Content_ATMNTS36.dbo.UserInfo AS ui ON ui.tp_ID = ad.int1 LEFT OUTER JOIN
                         atmnts32.WSS_Content_ATMNTS36.dbo.UserInfo AS ui2 ON ui2.tp_ID = ad.int2 LEFT OUTER JOIN
                         atmnts32.WSS_Content_ATMNTS36.dbo.UserInfo AS ui3 ON ui3.tp_ID = ad.int3 LEFT OUTER JOIN
                         atmnts32.WSS_Content_ATMNTS36.dbo.UserInfo AS ui4 ON ui4.tp_ID = ad.int4
WHERE        (ad.tp_DirName = 'ATMLeadframe/Lists/Equipment Calibration') AND (CONVERT(datetime, ad.sql_variant1) <= GETDATE()) AND (ad.ntext2 LIKE '%yes%') AND 
                         (ad.tp_IsCurrent = 1)
ORDER BY ad.tp_Modified DESC
END


GO
/****** Object:  StoredProcedure [dbo].[usp_spformat]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mohamed Suffian Bin Salehin
-- Create date:     11-10-2017
-- Description:	Update Last Attempt field and Status if completed
-- =============================================
CREATE PROCEDURE [dbo].[usp_spformat] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [Source]
      ,[Subject]
      ,[Status]
      ,[From]
      ,[To]
      ,[cc]
      ,[bcc]
      ,[MsgBody]
      ,[LastAttempt]
      ,[CreatedDate]
      ,[CustomFooter]
  FROM [ASMEmailServices].[dbo].[tblmsglist]
  where status = 'Completed'



   
END


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateMsgStatus]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mohamed Suffian Bin Salehin
-- Create date:     11-10-2017
-- Description:	Update Last Attempt field and Status if completed
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateMsgStatus] 
@Status bit ,	
@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Update tblmsglist Set [LastAttempt] = GETDATE() Where ID = @ID

	IF (@Status = 1)
	BEGIN
	Update tblmsglist Set Status = 'Completed' Where ID = @ID
	END



   
END


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateSchedulerStatus]    Script Date: 20/11/2017 17:19:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mohamed Suffian Bin Salehin
-- Create date:     11-10-2017
-- Description:	Update Last Attempt field and Status if completed
-- =============================================
Create PROCEDURE [dbo].[usp_UpdateSchedulerStatus] 
@Status bit ,	
@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Update tblScheduler Set [LastAttempt] = GETDATE() Where ID = @ID

	IF (@Status = 1)
	BEGIN
	Update tblScheduler Set LastSuccessAttempt =  GETDATE()  Where ID = @ID
	END



   
END


GO
USE [master]
GO
ALTER DATABASE [ASMEmailServices] SET  READ_WRITE 
GO
