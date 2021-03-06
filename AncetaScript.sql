USE [master]
GO
/****** Object:  Database [AncetaHost]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE DATABASE [AncetaHost]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'net_set', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AncetaHost.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'net_set_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AncetaHost_1.ldf' , SIZE = 20096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AncetaHost] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AncetaHost].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AncetaHost] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AncetaHost] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AncetaHost] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AncetaHost] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AncetaHost] SET ARITHABORT OFF 
GO
ALTER DATABASE [AncetaHost] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AncetaHost] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AncetaHost] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AncetaHost] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AncetaHost] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AncetaHost] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AncetaHost] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AncetaHost] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AncetaHost] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AncetaHost] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AncetaHost] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AncetaHost] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AncetaHost] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AncetaHost] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AncetaHost] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AncetaHost] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AncetaHost] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AncetaHost] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AncetaHost] SET  MULTI_USER 
GO
ALTER DATABASE [AncetaHost] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AncetaHost] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AncetaHost] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AncetaHost] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AncetaHost] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AncetaHost] SET QUERY_STORE = OFF
GO
USE [AncetaHost]
GO
/****** Object:  User [sanketa243]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE USER [sanketa243] FOR LOGIN [sanketa243] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [muftio11]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE USER [muftio11] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [anketa]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE USER [anketa] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sanketa243]
GO
ALTER ROLE [db_owner] ADD MEMBER [muftio11]
GO
ALTER ROLE [db_owner] ADD MEMBER [anketa]
GO
/****** Object:  UserDefinedTableType [dbo].[CouplesIdents]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE TYPE [dbo].[CouplesIdents] AS TABLE(
	[Idents] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[CouplIdents]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE TYPE [dbo].[CouplIdents] AS TABLE(
	[Idents] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[get_vot_counts]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Ilia Shterev>
-- Create date: <Create Date, Long ago>
-- Description:	<Description, Returns count votes from WedVotes teble for the sent
-- @coupl_ident>
-- =============================================
CREATE FUNCTION  [dbo].[get_vot_counts] 
(
	@coupl_ident Int
)
RETURNS int
AS
BEGIN

DECLARE @counts Int

	Select @counts= Count(0) from [dbo].[WedVotes] WHERE coupl_ident = @coupl_ident;

RETURN @counts

END
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[UserVotingId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WedCouples]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WedCouples](
	[ident] [int] IDENTITY(1001,1) NOT NULL,
	[names] [nvarchar](120) NULL,
	[votes] [int] NOT NULL,
	[pic] [nvarchar](50) NULL,
	[set_on] [smalldatetime] NULL,
	[linkk] [varchar](50) NULL,
 CONSTRAINT [PK_WedCouples] PRIMARY KEY CLUSTERED 
(
	[ident] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WedVotes]    Script Date: 6.5.2020 г. 7:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WedVotes](
	[coupl_ident] [int] NULL,
	[a_guid] [varchar](40) NULL,
	[ip1] [varchar](20) NULL,
	[ip2] [varchar](60) NULL,
	[_host] [nvarchar](40) NULL,
	[reff] [nvarchar](50) NULL,
	[vote_on] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 6.5.2020 г. 7:09:41 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  DEFAULT ((0)) FOR [UserVotingId]
GO
ALTER TABLE [dbo].[WedCouples] ADD  CONSTRAINT [DF_WedCouples_votes]  DEFAULT ((0)) FOR [votes]
GO
ALTER TABLE [dbo].[WedCouples] ADD  CONSTRAINT [DF_a_anketa_set_on]  DEFAULT (getdate()) FOR [set_on]
GO
ALTER TABLE [dbo].[WedCouples] ADD  CONSTRAINT [DF__a_anketa__linkk__1DE57479]  DEFAULT ('') FOR [linkk]
GO
ALTER TABLE [dbo].[WedVotes] ADD  CONSTRAINT [DF__a_votes__a_guid__1CF15040]  DEFAULT ('') FOR [a_guid]
GO
ALTER TABLE [dbo].[WedVotes] ADD  CONSTRAINT [DF_votess_ip1]  DEFAULT ('') FOR [ip1]
GO
ALTER TABLE [dbo].[WedVotes] ADD  CONSTRAINT [DF_votess_ip2]  DEFAULT ('') FOR [ip2]
GO
ALTER TABLE [dbo].[WedVotes] ADD  CONSTRAINT [DF_votess__host]  DEFAULT ('') FOR [_host]
GO
ALTER TABLE [dbo].[WedVotes] ADD  CONSTRAINT [DF__a_votes__reff__3B75D760]  DEFAULT ('') FOR [reff]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[WedVotes]  WITH CHECK ADD  CONSTRAINT [FK_WedVotes_WedCouples] FOREIGN KEY([coupl_ident])
REFERENCES [dbo].[WedCouples] ([ident])
GO
ALTER TABLE [dbo].[WedVotes] CHECK CONSTRAINT [FK_WedVotes_WedCouples]
GO
/****** Object:  StoredProcedure [dbo].[WedAllCouplesIdents]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WedAllCouplesIdents]
AS
BEGIN

SET NOCOUNT ON;

SELECT Cast(ROW_NUMBER() OVER (ORDER BY set_on DESC) As Integer) AS Row, [ident] 
FROM [AncetaHost].[dbo].[WedCouples]

END
GO
/****** Object:  StoredProcedure [dbo].[WedCheckInsertVote]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Ilia Shterev>
-- Create date: <Create Date, Long time ago in a galaxu far away>
-- Description:	<Description, Checks if for the sent @coupl_ident exist vote
-- within the last 24 hours If exists, i.e. if @LastVoteDate is not null
-- nothing more is done. @LastVoteDate is exported as output var.
-- If no vote is found within 24 hours a new one is inserted in the WedVotes
-- table and WedCouples table gets its votes column inrceased by one.>
-- =============================================
CREATE PROCEDURE [dbo].[WedCheckInsertVote]
(
		@a_guid nvarchar(40),
		@ip1 varchar(20),
		@ip2 varchar(60),
        @reff nvarchar(50),
		@hostt nvarchar(40),

	@coupl_ident Int,
	@CurrentDateTime datetime, 
	@LastVoteDate datetime OUTPUT
)
AS BEGIN SET NOCOUNT ON;

	Declare @ShiftedBackDate datetime = dateadd(hour,-24, @CurrentDateTime);

	SELECT TOP 1 @LastVoteDate=vote_on from [dbo].[WedVotes]
  
    WHERE ((coupl_ident = @coupl_ident) And  (@ip1 = ip1) And (@ip2 = ip2) And (@ShiftedBackDate < vote_on))
	ORDER BY vote_on DESC

					if (@LastVoteDate IS NOT NULL)
					BEGIN
						return;
					END

BEGIN TRY
	BEGIN TRANSACTION MakeAVote

    INSERT INTO [dbo].[WedVotes]
	(
        a_guid,
		ip1,
		ip2,
        reff,
		_host,
		coupl_ident,
		vote_on

    )
    VALUES
    (
        @a_guid,
		@ip1,
		@ip2,
		@reff,
        @hostt,
		@coupl_ident,
		@CurrentDateTime
	)

	Update [dbo].[WedCouples] set votes = votes + 1 WHERE [ident] = @coupl_ident;

	COMMIT TRANSACTION MakeAVote

END TRY
BEGIN CATCH

	ROLLBACK TRANSACTION MakeAVote
	
END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[WedInsertVote]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [dbo].[WedInsertVote]
    (
		@a_guid nvarchar(40),
		@ip1 varchar(20),
		@ip2 varchar(60),
        @reff nvarchar(50),
		@_host nvarchar(40),
		@coupl_ident int,
		@date_on DateTime
   )
   AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO [dbo].[WedVotes]
	(
        a_guid,
		ip1,
		ip2,
        reff,
		_host,
		coupl_ident,
		vote_on

    )
    VALUES
    (
        @a_guid,
		@ip1,
		@ip2,
		@reff,
        @_host,
		@coupl_ident,
		@date_on
	)
END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectAllVoteForCouple]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectAllVoteForCouple]
(
	@CoupleIdent Int
)
AS BEGIN SET NOCOUNT ON;

	SELECT ip1, ip2, vote_on from [dbo].[WedVotes]
  
    WHERE (coupl_ident = @CoupleIdent) ORDER BY vote_on DESC
END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectCouple]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectCouple]

    @CoupleIdent INT	

AS BEGIN SET NOCOUNT ON;

SELECT names, linkk, pic, Cast(ident As varchar(8)) As identu, Cast([votes] As varchar(8)) As votess FROM [WedCouples]  

WHERE ident = @CoupleIdent

END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectCoupleNames]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectCoupleNames]

    @CoupleIdent INT,	
	@CouplesNames NVarChar(100) OUTPUT

AS BEGIN SET NOCOUNT ON;

Select  @CouplesNames = UPPER(names) FROM [dbo].[WedCouples]

WHERE ident = @CoupleIdent

END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectCouples]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectCouples]
    @PageStart INT, 
    @PageEnd INT	
AS
BEGIN SET NOCOUNT ON;

WITH InitAnketa AS (
SELECT ROW_NUMBER() OVER (ORDER BY set_on DESC) AS Row, ident FROM [WedCouples])

SELECT names, linkk, pic, Cast(wCpls.ident As varchar(8)) As identu 
,Cast([votes] As varchar(8)) As votess FROM [WedCouples] wCpls 

--Inner Join InitAnketa  

--on wCpls.ident = InitAnketa.ident

--WHERE (InitAnketa.Row between @PageStart and @PageEnd)

WHERE ident IN (Select ident from InitAnketa where Row between @PageStart and @PageEnd) 

ORDER BY set_on DESC

----------------------  Region Counting F - n Joins  ---------------------------

--SELECT names, linkk, pic, Cast(wCpls.ident As varchar(8)) As identu 
--,Cast([dbo].[get_vot_counts](ident)  As varchar(8)) As votess FROM [WedCouples] wCpls 

--WHERE ident IN (Select ident from InitAnketa where Row between @PageStart and @PageEnd) 

--ORDER BY set_on DESC

----------------------  Region Counting F - n Joins  -----------------------

----------------------  Region Two Joins  ---------------------------
--SELECT wCpls.names, wCpls.linkk, wCpls.pic, Cast(wCpls.ident As varchar(8)) As identu 
--,Cast(COALESCE(Count(wVоts.coupl_ident), 0) As varchar(8)) As votess FROM [WedCouples]  

--wCpls LEFT JOIN [WedVotes] wVоts 
--on wVоts.coupl_ident = wCpls.ident

--Inner Join InitAnketa  
--on wCpls.ident = InitAnketa.ident
--WHERE (InitAnketa.Row between @PageStart and @PageEnd)

--Group BY wCpls.ident, wCpls.names, wCpls.linkk, wCpls.pic, wCpls.set_on
--ORDER BY wCpls.set_on DESC
----------------------  END Region Two Joins  ---------------------------
END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectCouplesCount]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectCouplesCount]
(
	@TotalCount Int OUTPUT
)
AS BEGIN SET NOCOUNT ON;

	SELECT @TotalCount=COUNT(0) from [dbo].[WedCouples]
	
END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectCouplesFromDataTable]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ilia Shterev>
-- Create date: <Create Date,,>
-- Description:	<Takes small number of couples based on input C# data table>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectCouplesFromDataTable]
	@CouplesIdents CouplIdents READONLY
AS
BEGIN

SET NOCOUNT ON;

SELECT names, linkk, pic, Cast(ident As varchar(8)) As identu, Cast([votes] As varchar(8)) As votess FROM [WedCouples]  

-- First version is with WHERE IN clause, the other is with Inner Join. 
-- So If you comment out the line bellow
where ident in (select Idents from @CouplesIdents)

-- And uncomment the line bellow 
--Inner Join @CouplesIdents on ident = Idents

END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectCouplesVotesOrdered]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<EXPERIMENTAL>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectCouplesVotesOrdered]

    @PageStart INT, 
    @PageEnd INT,	
	@pic_domain VarChar(100),
	@MainDomain VarChar(120)

AS BEGIN SET NOCOUNT ON;

WITH a_init_anketa AS (
SELECT ROW_NUMBER() OVER (ORDER BY [dbo].[get_vot_counts](ident) DESC)
AS Row, names, pic, ident, set_on
FROM [WedCouples])

Select  UPPER(names) As names, 

@pic_domain + pic + N'" alt="СВАТБАТА НА ' + names + '" class="pic_bord" />' As pic,ident As identu,

'<a href="' + @MainDomain + '?cplid=' + CONVERT(varchar(10), ident) + N'" class="PicAdminn" target="_blank"><strong> Подробно &#62;&#62;</strong></a>' as linkk,

 [dbo].[get_vot_counts](ident) As votess FROM a_init_anketa

WHERE Row between @PageStart and @PageEnd

order by votess DESC

END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectGroupedVotesForCouple]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Ilia Shterev
-- Create date: <Create Date, Long time ago in a galaxu far away>
-- Description:	<Description, Selects votes per coupleIdent grupped by IP1 and IP2>
-- =============================================
CREATE PROCEDURE [dbo].[WedSelectGroupedVotesForCouple]
(
	@CoupleIdent Int
)
AS BEGIN SET NOCOUNT ON;

	SELECT ip1, ip2, Cast(COUNT(0) As varchar(8)) As Votes from [dbo].[WedVotes]
 
    WHERE (coupl_ident = @CoupleIdent)
    	
	GROUP BY ip1, ip2 
	Order By Votes Desc
    
END
GO
/****** Object:  StoredProcedure [dbo].[WedSelectLastVoteForCouple]    Script Date: 6.5.2020 г. 7:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================  LastVoteDate
CREATE PROCEDURE [dbo].[WedSelectLastVoteForCouple]
(
	@coupl_ident Int,
	@ip1 varchar(20),
	@ip2 varchar(60),
	@CurrentDateTime datetime, 
	@LastVoteDate datetime OUTPUT
)
AS BEGIN SET NOCOUNT ON;

	SELECT TOP 1 @LastVoteDate=vote_on from [dbo].[WedVotes]
  
    WHERE (coupl_ident = @coupl_ident And  @ip1=ip1 And @ip2=ip2 And @CurrentDateTime<vote_on)
                    ORDER BY vote_on DESC
END
GO
USE [master]
GO
ALTER DATABASE [AncetaHost] SET  READ_WRITE 
GO
