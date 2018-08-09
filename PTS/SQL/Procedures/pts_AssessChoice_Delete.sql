EXEC [dbo].pts_CheckProc 'pts_AssessChoice_Delete'
 GO

CREATE PROCEDURE [dbo].pts_AssessChoice_Delete ( 
   @AssessChoiceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE asmc
FROM AssessChoice AS asmc
WHERE asmc.AssessChoiceID = @AssessChoiceID

GO