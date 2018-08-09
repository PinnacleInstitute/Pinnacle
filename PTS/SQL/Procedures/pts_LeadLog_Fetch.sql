EXEC [dbo].pts_CheckProc 'pts_LeadLog_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_LeadLog_Fetch ( 
   @LeadLogID int,
   @LeadPageID int OUTPUT,
   @MemberID int OUTPUT,
   @AffiliateID int OUTPUT,
   @LogDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @LeadPageID = ll.LeadPageID ,
   @MemberID = ll.MemberID ,
   @AffiliateID = ll.AffiliateID ,
   @LogDate = ll.LogDate
FROM LeadLog AS ll (NOLOCK)
WHERE ll.LeadLogID = @LeadLogID

GO