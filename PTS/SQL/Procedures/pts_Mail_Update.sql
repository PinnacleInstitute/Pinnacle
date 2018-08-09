EXEC [dbo].pts_CheckProc 'pts_Mail_Update'
 GO

CREATE PROCEDURE [dbo].pts_Mail_Update ( 
   @MailID int,
   @MemberID int,
   @OwnerType int,
   @OwnerID int,
   @Subject nvarchar (80),
   @MailFrom nvarchar (80),
   @MailTo nvarchar (80),
   @CC nvarchar (80),
   @BCC nvarchar (80),
   @MailDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ml
SET ml.MemberID = @MemberID ,
   ml.OwnerType = @OwnerType ,
   ml.OwnerID = @OwnerID ,
   ml.Subject = @Subject ,
   ml.MailFrom = @MailFrom ,
   ml.MailTo = @MailTo ,
   ml.CC = @CC ,
   ml.BCC = @BCC ,
   ml.MailDate = @MailDate
FROM Mail AS ml
WHERE ml.MailID = @MailID

GO