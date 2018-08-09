EXEC [dbo].pts_CheckProc 'pts_Contest_ListMember'
GO
--EXEC pts_Contest_ListMember 7, 6528, 6708
--select * from contest
--update contest set memberid = 0 where contestid = 2

CREATE PROCEDURE [dbo].pts_Contest_ListMember
   @MemberID int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @GroupID int, @EndDate datetime

SELECT @CompanyID = CompanyID, @GroupID = GroupID FROM Member WHERE MemberID = @MemberID
SET @EndDate = DATEADD(m,-2,GETDATE())

(
	SELECT con.ContestID, con.ContestName, con.Description, con.Status, con.Metric, con.StartDate, con.EndDate, con.IsPrivate, 0 'MemberContestID'
	FROM Contest AS con (NOLOCK)
	WHERE con.CompanyID = @CompanyID AND con.IsPrivate = 0 AND (con.MemberID = 0 OR con.MemberID = @GroupID)
	AND ( con.Status = 2 OR (con.Status > 2 AND (con.StartDate = 0 OR con.EndDate > @EndDate) ) )
)
UNION (
	SELECT con.ContestID, con.ContestName, con.Description, con.Status, con.Metric, con.StartDate, con.EndDate, con.IsPrivate, mcn.MemberContestID
	FROM Contest AS con (NOLOCK)
	JOIN MemberContest AS mcn ON con.ContestID = mcn.ContestID
	WHERE mcn.MemberID = @MemberID AND con.IsPrivate <> 0
	AND ( con.Status = 2 OR (con.Status > 2 AND (con.StartDate = 0 OR con.EndDate > @EndDate) ) )
)
ORDER BY StartDate DESC

GO
