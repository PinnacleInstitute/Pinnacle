EXEC [dbo].pts_CheckProc 'pts_Question_Add'
 GO

CREATE PROCEDURE [dbo].pts_Question_Add ( 
   @QuestionID int OUTPUT,
   @CompanyID int,
   @QuestionTypeID int,
   @QuestionDate datetime,
   @Question nvarchar (200),
   @Answer nvarchar (4000),
   @Reference nvarchar (30),
   @Seq int,
   @Status int,
   @Secure int,
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
   FROM Question (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO Question (
            CompanyID , 
            QuestionTypeID , 
            QuestionDate , 
            Question , 
            Answer , 
            Reference , 
            Seq , 
            Status , 
            Secure
            )
VALUES (
            @CompanyID ,
            @QuestionTypeID ,
            @QuestionDate ,
            @Question ,
            @Answer ,
            @Reference ,
            @Seq ,
            @Status ,
            @Secure            )

SET @mNewID = @@IDENTITY

SET @QuestionID = @mNewID

GO