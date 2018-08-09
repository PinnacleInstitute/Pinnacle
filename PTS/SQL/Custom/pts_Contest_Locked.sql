EXEC [dbo].pts_CheckProc 'pts_Contest_Locked'
GO
--DECLARE @Result int EXEC pts_Contest_Locked 7, 6528, 6708, '2/1/13', @Result output print @result

CREATE PROCEDURE [dbo].pts_Contest_Locked
   @MemberID int ,
   @StartDate datetime ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @GroupID int, @cnt int

SELECT @CompanyID = CompanyID, @GroupID = GroupID FROM Member WHERE MemberID = @MemberID

-- Check if any public contests are locked for this date
SET @Result = 0
SELECT TOP 1 @Result = ContestID FROM Contest 
WHERE CompanyID = @CompanyID AND IsPrivate = 0 AND (MemberID = 0 OR MemberID = @GroupID)
AND Status = 4 AND StartDate > 0 AND @StartDate >= StartDate AND @StartDate <= EndDate

--If no locked public contests, check for private registered contests
IF @Result = 0
BEGIN
	SELECT TOP 1 @Result = con.ContestID FROM Contest AS con
	JOIN MemberContest AS mcn ON con.ContestID = mcn.ContestID
	WHERE mcn.MemberID = @MemberID AND con.IsPrivate <> 0
	AND con.Status = 4 AND con.StartDate > 0 AND @StartDate >= con.StartDate AND @StartDate <= con.EndDate
END

GO