EXEC [dbo].pts_CheckProc 'pts_Contest_EnumContestList'
GO
--EXEC pts_Contest_EnumContestList 6599, 1
--EXEC pts_Contest_EnumContestList 6528, 1

CREATE PROCEDURE [dbo].pts_Contest_EnumContestList
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @GroupID int, @EndDate datetime

SELECT @CompanyID = CompanyID, @GroupID = GroupID FROM Member WHERE MemberID = @MemberID
SET @EndDate = DATEADD(m,-2,GETDATE())
(
	SELECT con.ContestID AS 'ID', con.ContestName AS 'Name'
	FROM Contest AS con (NOLOCK)
	WHERE con.CompanyID = @CompanyID AND con.IsPrivate = 0 AND (con.MemberID = 0 OR con.MemberID = @GroupID)
	AND ( con.Status = 2 OR (con.Status > 2 AND (con.StartDate = 0 OR con.EndDate > @EndDate) ) )
)
UNION (
	SELECT con.ContestID AS 'ID', con.ContestName AS 'Name'
	FROM Contest AS con (NOLOCK)
	JOIN MemberContest AS mcn ON con.ContestID = mcn.ContestID
	WHERE mcn.MemberID = @MemberID AND con.IsPrivate <> 0
	AND ( con.Status = 2 OR (con.Status > 2 AND (con.StartDate = 0 OR con.EndDate > @EndDate) ) )
)
ORDER BY ContestID DESC

GO