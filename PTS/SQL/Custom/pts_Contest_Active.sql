EXEC [dbo].pts_CheckProc 'pts_Contest_Active'
GO
--DECLARE @Result int EXEC pts_Contest_Active 6528, @Result output print @result

CREATE PROCEDURE [dbo].pts_Contest_Active
   @MemberID int ,
   @ContestID int OUTPUT
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @GroupID int, @cnt int

SELECT @CompanyID = CompanyID, @GroupID = GroupID FROM Member WHERE MemberID = @MemberID

-- Get the most current active public contest

SET @ContestID = 0
SELECT TOP 1 @ContestID = ContestID FROM Contest 
WHERE CompanyID = @CompanyID AND IsPrivate = 0 AND (MemberID = 0 OR MemberID = @GroupID) AND Status = 2
ORDER BY StartDate DESC

--If no locked public contests, check for private registered contests
IF @ContestID = 0
BEGIN
	SELECT TOP 1 @ContestID = con.ContestID FROM Contest AS con
	JOIN MemberContest AS mcn ON con.ContestID = mcn.ContestID
	WHERE mcn.MemberID = @MemberID AND con.IsPrivate <> 0 AND con.Status = 2
	ORDER BY con.StartDate DESC
END

GO