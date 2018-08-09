EXEC [dbo].pts_CheckProc 'pts_AssessChoice_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_AssessChoice_Fetch ( 
   @AssessChoiceID int,
   @AssessQuestionID int OUTPUT,
   @Choice nvarchar (200) OUTPUT,
   @Seq int OUTPUT,
   @Points int OUTPUT,
   @NextQuestion int OUTPUT,
   @Courses varchar (50) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AssessQuestionID = asmc.AssessQuestionID ,
   @Choice = asmc.Choice ,
   @Seq = asmc.Seq ,
   @Points = asmc.Points ,
   @NextQuestion = asmc.NextQuestion ,
   @Courses = asmc.Courses
FROM AssessChoice AS asmc (NOLOCK)
WHERE asmc.AssessChoiceID = @AssessChoiceID

GO