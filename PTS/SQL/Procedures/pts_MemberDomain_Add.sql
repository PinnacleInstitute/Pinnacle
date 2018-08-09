EXEC [dbo].pts_CheckProc 'pts_MemberDomain_Add'
 GO

CREATE PROCEDURE [dbo].pts_MemberDomain_Add ( 
   @MemberDomainID int OUTPUT,
   @MemberID int,
   @DomainID int,
   @LeadCampaignID int,
   @PageType int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO MemberDomain (
            MemberID , 
            DomainID , 
            LeadCampaignID , 
            PageType
            )
VALUES (
            @MemberID ,
            @DomainID ,
            @LeadCampaignID ,
            @PageType            )

SET @mNewID = @@IDENTITY

SET @MemberDomainID = @mNewID

GO