EXEC [dbo].pts_CheckProc 'pts_LeadLog_Add'
 GO

CREATE PROCEDURE [dbo].pts_LeadLog_Add ( 
   @LeadLogID int OUTPUT,
   @LeadPageID int,
   @MemberID int,
   @AffiliateID int,
   @LogDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO LeadLog (
            LeadPageID , 
            MemberID , 
            AffiliateID , 
            LogDate
            )
VALUES (
            @LeadPageID ,
            @MemberID ,
            @AffiliateID ,
            @LogDate            )

SET @mNewID = @@IDENTITY

SET @LeadLogID = @mNewID

GO