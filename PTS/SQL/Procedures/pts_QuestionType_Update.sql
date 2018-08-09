EXEC [dbo].pts_CheckProc 'pts_QuestionType_Update'
 GO

CREATE PROCEDURE [dbo].pts_QuestionType_Update ( 
   @QuestionTypeID int,
   @CompanyID int,
   @QuestionTypeName nvarchar (40),
   @Seq int,
   @UserType int,
   @Secure int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE qtl
SET qtl.CompanyID = @CompanyID ,
   qtl.QuestionTypeName = @QuestionTypeName ,
   qtl.Seq = @Seq ,
   qtl.UserType = @UserType ,
   qtl.Secure = @Secure
FROM QuestionType AS qtl
WHERE qtl.QuestionTypeID = @QuestionTypeID

GO