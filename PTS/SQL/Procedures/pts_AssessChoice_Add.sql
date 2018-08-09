EXEC [dbo].pts_CheckProc 'pts_AssessChoice_Add'
 GO

CREATE PROCEDURE [dbo].pts_AssessChoice_Add ( 
   @AssessChoiceID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM AssessChoice (NOLOCK)
   WHERE AssessQuestionID = @AssessQuestionID
   SET @Seq = @Seq + 10
END

INSERT INTO AssessChoice (
            AssessQuestionID , 
            Choice , 
            Seq , 
            Points , 
            NextQuestion , 
            Courses
            )
VALUES (
            @AssessQuestionID ,
            @Choice ,
            @Seq ,
            @Points ,
            @NextQuestion ,
            @Courses            )

SET @mNewID = @@IDENTITY

SET @AssessChoiceID = @mNewID

GO