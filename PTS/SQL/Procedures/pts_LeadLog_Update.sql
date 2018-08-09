EXEC [dbo].pts_CheckProc 'pts_LeadLog_Update'
 GO

CREATE PROCEDURE [dbo].pts_LeadLog_Update ( 
   @LeadLogID int,
   @LeadPageID int,
   @MemberID int,
   @AffiliateID int,
   @LogDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ll
SET ll.LeadPageID = @LeadPageID ,
   ll.MemberID = @MemberID ,
   ll.AffiliateID = @AffiliateID ,
   ll.LogDate = @LogDate
FROM LeadLog AS ll
WHERE ll.LeadLogID = @LeadLogID

GO