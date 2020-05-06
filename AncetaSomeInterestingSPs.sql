


-- Author:		<Ilia Shterev>
-- Create date: <Create Date, Long time ago in a galaxu far away>
-- Description:	<Takes smal number of couples based on input C# data table>
-- =============================================
ALTER PROCEDURE [dbo].[WedSelectCouplesFromDataTable]
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

-- This SP is using C# DataTable as an input parameter. It requires first to have 
-- User Defined Table Types as follows:

USE [AncetaHost]
GO
CREATE TYPE [dbo].[CouplesIdents] AS TABLE(
	[Idents] [int] NOT NULL
)
GO

-- =============================================
-- Author:		<Author,Ilia Shterev>
-- Create date: <Create Date, Long ago>
-- Description:	<Description, Selects row from WedSelectCouples based on 
-- @PageStart and @PageEnd for paged result. I created two other sub versions
-- working the same way but just as a proof of concept.>
-- =============================================
ALTER PROCEDURE [dbo].[WedSelectCouples]
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

----------------------  End Region Counting F - n Joins  -----------------------

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

-- I have ceated 3 paralel solutions which bring same end result. One of them uses
-- a scalar valued function:

ALTER FUNCTION  [dbo].[get_vot_counts] 
(
@coupl_ident Int
)
RETURNS int
AS
BEGIN

DECLARE @counts Int

	Select @counts= Count(0) from [dbo].[WedVotes] WHERE coupl_ident = @coupl_ident;

	Set @counts= Cast(@counts As varchar(8));

RETURN @counts

END

-- =============================================
-- Author:		<Author, Ilia Shterev>
-- Create date: <Create Date, Long time ago in a galaxu far away>
-- Description:	<Description, Checks if for the sent @coupl_ident exist vote
-- within the last 24 hours If exists, i.e. if @LastVoteDate is not null
-- nothing more is done. @LastVoteDate is exported as output var.
-- If no vote is found within 24 hours a new one is inserted in the WedVotes
-- table and WedCouples table gets its votes column inrceased by one.>
-- =============================================
ALTER PROCEDURE [dbo].[WedCheckInsertVote]
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

Set @CurrentDateTime = dateadd(hour,-24, @CurrentDateTime);

	SELECT TOP 1 @LastVoteDate=vote_on from [dbo].[WedVotes]
  
    WHERE ((coupl_ident = @coupl_ident) And  (@ip1 = ip1) And (@ip2 = ip2) And (@CurrentDateTime < vote_on))
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

-- =============================================
-- Author:		<Author, Ilia Shterev
-- Create date: <Create Date, Long time ago in a galaxu far away>
-- Description:	<Description, Selects votes per coupleIdent grupped by IP1 and IP2>
-- =============================================
ALTER PROCEDURE [dbo].[WedSelectGroupedVotesForCouple]
(
	@CoupleIdent Int
)
AS BEGIN SET NOCOUNT ON;

	SELECT ip1, ip2, Cast(COUNT(0) As varchar(8)) As Votes from [dbo].[WedVotes]
 
    WHERE (coupl_ident = @CoupleIdent)
    	
	GROUP BY ip1, ip2 
	Order By Votes Desc
    
END

