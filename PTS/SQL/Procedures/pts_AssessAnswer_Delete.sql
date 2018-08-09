EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_Delete'
 GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_Delete ( 
   @AssessAnswerID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE asa
FROM AssessAnswer AS asa
WHERE asa.AssessAnswerID = @AssessAnswerID

GO