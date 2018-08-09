EXEC [dbo].pts_CheckProc 'pts_Question_Update'
 GO

CREATE PROCEDURE [dbo].pts_Question_Update ( 
   @QuestionID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE qu
SET qu.CompanyID = @CompanyID ,
   qu.QuestionTypeID = @QuestionTypeID ,
   qu.QuestionDate = @QuestionDate ,
   qu.Question = @Question ,
   qu.Answer = @Answer ,
   qu.Reference = @Reference ,
   qu.Seq = @Seq ,
   qu.Status = @Status ,
   qu.Secure = @Secure
FROM Question AS qu
WHERE qu.QuestionID = @QuestionID

GO