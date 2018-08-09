EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_Fetch ( 
   @LeadCampaignID int,
   @CompanyID int OUTPUT,
   @SalesCampaignID int OUTPUT,
   @ProspectTypeID int OUTPUT,
   @CycleID int OUTPUT,
   @NewsLetterID int OUTPUT,
   @GroupID int OUTPUT,
   @FolderID int OUTPUT,
   @LeadCampaignName nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @PageType int OUTPUT,
   @Objective nvarchar (500) OUTPUT,
   @Title varchar (100) OUTPUT,
   @Description varchar (500) OUTPUT,
   @Keywords varchar (500) OUTPUT,
   @IsMember bit OUTPUT,
   @IsAffiliate bit OUTPUT,
   @Cycle varchar (1000) OUTPUT,
   @CSS varchar (100) OUTPUT,
   @NoEdit bit OUTPUT,
   @Page nvarchar (25) OUTPUT,
   @Image nvarchar (25) OUTPUT,
   @Entity int OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = lc.CompanyID ,
   @SalesCampaignID = lc.SalesCampaignID ,
   @ProspectTypeID = lc.ProspectTypeID ,
   @CycleID = lc.CycleID ,
   @NewsLetterID = lc.NewsLetterID ,
   @GroupID = lc.GroupID ,
   @FolderID = lc.FolderID ,
   @LeadCampaignName = lc.LeadCampaignName ,
   @Status = lc.Status ,
   @PageType = lc.PageType ,
   @Objective = lc.Objective ,
   @Title = lc.Title ,
   @Description = lc.Description ,
   @Keywords = lc.Keywords ,
   @IsMember = lc.IsMember ,
   @IsAffiliate = lc.IsAffiliate ,
   @Cycle = lc.Cycle ,
   @CSS = lc.CSS ,
   @NoEdit = lc.NoEdit ,
   @Page = lc.Page ,
   @Image = lc.Image ,
   @Entity = lc.Entity ,
   @Seq = lc.Seq
FROM LeadCampaign AS lc (NOLOCK)
WHERE lc.LeadCampaignID = @LeadCampaignID

GO