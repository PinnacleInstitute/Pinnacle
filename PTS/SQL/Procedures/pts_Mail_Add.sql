EXEC [dbo].pts_CheckProc 'pts_Mail_Add'
 GO

CREATE PROCEDURE [dbo].pts_Mail_Add ( 
   @MailID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Mail (
            MemberID , 
            OwnerType , 
            OwnerID , 
            Subject , 
            MailFrom , 
            MailTo , 
            CC , 
            BCC , 
            MailDate
            )
VALUES (
            @MemberID ,
            @OwnerType ,
            @OwnerID ,
            @Subject ,
            @MailFrom ,
            @MailTo ,
            @CC ,
            @BCC ,
            @MailDate            )

SET @mNewID = @@IDENTITY

SET @MailID = @mNewID

GO