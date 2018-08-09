EXEC [dbo].pts_CheckProc 'pts_SurveyQuestion_Add'
 GO

CREATE PROCEDURE [dbo].pts_SurveyQuestion_Add ( 
   @SurveyQuestionID int OUTPUT,
   @SurveyID int,
   @Question nvarchar (1000),
   @Seq int,
   @IsText bit,
   @Total int,
   @Status int,
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
   FROM SurveyQuestion (NOLOCK)
   WHERE SurveyID = @SurveyID
   SET @Seq = @Seq + 10
END

INSERT INTO SurveyQuestion (
            SurveyID , 
            Question , 
            Seq , 
            IsText , 
            Total , 
            Status
            )
VALUES (
            @SurveyID ,
            @Question ,
            @Seq ,
            @IsText ,
            @Total ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @SurveyQuestionID = @mNewID

GO