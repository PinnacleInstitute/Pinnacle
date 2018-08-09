EXEC [dbo].pts_CheckProc 'pts_AssessChoice_Update'
 GO

CREATE PROCEDURE [dbo].pts_AssessChoice_Update ( 
   @AssessChoiceID int,
   @AssessQuestionID int,
   @Choice nvarchar (200),
   @Seq int,
   @Points int,
   @NextQuestion int,
   @Courses varchar (50),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE asmc
SET asmc.AssessQuestionID = @AssessQuestionID ,
   asmc.Choice = @Choice ,
   asmc.Seq = @Seq ,
   asmc.Points = @Points ,
   asmc.NextQuestion = @NextQuestion ,
   asmc.Courses = @Courses
FROM AssessChoice AS asmc
WHERE asmc.AssessChoiceID = @AssessChoiceID

GO