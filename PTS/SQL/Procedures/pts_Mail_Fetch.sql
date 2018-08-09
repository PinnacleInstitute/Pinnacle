EXEC [dbo].pts_CheckProc 'pts_Mail_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Mail_Fetch ( 
   @MailID int,
   @MemberID int OUTPUT,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @MailFrom nvarchar (80) OUTPUT,
   @MailTo nvarchar (80) OUTPUT,
   @CC nvarchar (80) OUTPUT,
   @BCC nvarchar (80) OUTPUT,
   @MailDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ml.MemberID ,
   @OwnerType = ml.OwnerType ,
   @OwnerID = ml.OwnerID ,
   @Subject = ml.Subject ,
   @MailFrom = ml.MailFrom ,
   @MailTo = ml.MailTo ,
   @CC = ml.CC ,
   @BCC = ml.BCC ,
   @MailDate = ml.MailDate
FROM Mail AS ml (NOLOCK)
WHERE ml.MailID = @MailID

GO