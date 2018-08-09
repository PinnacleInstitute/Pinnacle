EXEC [dbo].pts_CheckProc 'pts_QuestionType_Add'
 GO

CREATE PROCEDURE [dbo].pts_QuestionType_Add ( 
   @QuestionTypeID int OUTPUT,
   @CompanyID int,
   @QuestionTypeName nvarchar (40),
   @Seq int,
   @UserType int,
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
   FROM QuestionType (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO QuestionType (
            CompanyID , 
            QuestionTypeName , 
            Seq , 
            UserType , 
            Secure
            )
VALUES (
            @CompanyID ,
            @QuestionTypeName ,
            @Seq ,
            @UserType ,
            @Secure            )

SET @mNewID = @@IDENTITY

SET @QuestionTypeID = @mNewID

GO