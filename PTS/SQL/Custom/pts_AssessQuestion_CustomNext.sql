EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_CustomNext'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_CustomNext
   @CustomCode int ,
   @AssessQuestionID int ,
   @MemberAssessID int ,
   @NextQuestion int OUTPUT
AS

SET         NOCOUNT ON

--IF @CustomCode = 1 EXEC pts_AssessQuestion_CustomNext_1_  @AssessQuestionID, @MemberAssessID, @NextQuestion OUTPUT

GO