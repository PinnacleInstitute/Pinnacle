EXEC [dbo].pts_CheckProc 'pts_Assessment_TestTakes'
GO

CREATE PROCEDURE [dbo].pts_Assessment_TestTakes
   @AssessmentID int ,
   @MemberID int ,
   @Takes int ,
   @Result int OUTPUT
AS

DECLARE @cnt int

SET NOCOUNT ON

SET @Result = 0

SELECT @cnt = Count(*) FROM MemberAssess WHERE AssessmentID = @AssessmentID AND MemberID = @MemberID

IF @cnt >= @Takes
	SET @Result = @cnt

GO
