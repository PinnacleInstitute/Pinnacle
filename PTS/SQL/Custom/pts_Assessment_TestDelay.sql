EXEC [dbo].pts_CheckProc 'pts_Assessment_TestDelay'
GO

CREATE PROCEDURE [dbo].pts_Assessment_TestDelay
   @AssessmentID int ,
   @MemberID int ,
   @Delay int ,
   @Result int OUTPUT
AS

DECLARE @CompleteDate datetime

SET         NOCOUNT ON

SET @Result = 0

--test if the most recent assessment for this member has been less than specified days (Delay)
SELECT TOP 1 @CompleteDate = ISNULL(CompleteDate,0) 
FROM MemberAssess WHERE AssessmentID = @AssessmentID AND MemberID = @MemberID 
ORDER BY CompleteDate DESC

IF @CompleteDate > 0
BEGIN
	DECLARE @Days int
	SET @Days = DATEDIFF(day, @CompleteDate, getdate()) 
	IF @Days < @Delay
		SET @Result = @Delay - @Days
END

GO

