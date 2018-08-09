EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_Update'
 GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_Update ( 
   @LeadCampaignID int,
   @CompanyID int,
   @SalesCampaignID int,
   @ProspectTypeID int,
   @CycleID int,
   @NewsLetterID int,
   @GroupID int,
   @FolderID int,
   @LeadCampaignName nvarchar (60),
   @Status int,
   @PageType int,
   @Objective nvarchar (500),
   @Title varchar (100),
   @Description varchar (500),
   @Keywords varchar (500),
   @IsMember bit,
   @IsAffiliate bit,
   @Cycle varchar (1000),
   @CSS varchar (100),
   @NoEdit bit,
   @Page nvarchar (25),
   @Image nvarchar (25),
   @Entity int,
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE lc
SET lc.CompanyID = @CompanyID ,
   lc.SalesCampaignID = @SalesCampaignID ,
   lc.ProspectTypeID = @ProspectTypeID ,
   lc.CycleID = @CycleID ,
   lc.NewsLetterID = @NewsLetterID ,
   lc.GroupID = @GroupID ,
   lc.FolderID = @FolderID ,
   lc.LeadCampaignName = @LeadCampaignName ,
   lc.Status = @Status ,
   lc.PageType = @PageType ,
   lc.Objective = @Objective ,
   lc.Title = @Title ,
   lc.Description = @Description ,
   lc.Keywords = @Keywords ,
   lc.IsMember = @IsMember ,
   lc.IsAffiliate = @IsAffiliate ,
   lc.Cycle = @Cycle ,
   lc.CSS = @CSS ,
   lc.NoEdit = @NoEdit ,
   lc.Page = @Page ,
   lc.Image = @Image ,
   lc.Entity = @Entity ,
   lc.Seq = @Seq
FROM LeadCampaign AS lc
WHERE lc.LeadCampaignID = @LeadCampaignID

GO