EXEC [dbo].pts_CheckProc 'pts_MemberDomain_Update'
 GO

CREATE PROCEDURE [dbo].pts_MemberDomain_Update ( 
   @MemberDomainID int,
   @MemberID int,
   @DomainID int,
   @LeadCampaignID int,
   @PageType int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE med
SET med.MemberID = @MemberID ,
   med.DomainID = @DomainID ,
   med.LeadCampaignID = @LeadCampaignID ,
   med.PageType = @PageType
FROM MemberDomain AS med
WHERE med.MemberDomainID = @MemberDomainID

GO