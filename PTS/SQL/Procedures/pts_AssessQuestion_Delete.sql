EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_Delete'
 GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_Delete ( 
   @AssessQuestionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE asq
FROM AssessQuestion AS asq
WHERE asq.AssessQuestionID = @AssessQuestionID

GO