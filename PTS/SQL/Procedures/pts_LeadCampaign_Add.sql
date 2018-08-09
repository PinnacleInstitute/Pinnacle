EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_Add'
 GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_Add ( 
   @LeadCampaignID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO LeadCampaign (
            CompanyID , 
            SalesCampaignID , 
            ProspectTypeID , 
            CycleID , 
            NewsLetterID , 
            GroupID , 
            FolderID , 
            LeadCampaignName , 
            Status , 
            PageType , 
            Objective , 
            Title , 
            Description , 
            Keywords , 
            IsMember , 
            IsAffiliate , 
            Cycle , 
            CSS , 
            NoEdit , 
            Page , 
            Image , 
            Entity , 
            Seq
            )
VALUES (
            @CompanyID ,
            @SalesCampaignID ,
            @ProspectTypeID ,
            @CycleID ,
            @NewsLetterID ,
            @GroupID ,
            @FolderID ,
            @LeadCampaignName ,
            @Status ,
            @PageType ,
            @Objective ,
            @Title ,
            @Description ,
            @Keywords ,
            @IsMember ,
            @IsAffiliate ,
            @Cycle ,
            @CSS ,
            @NoEdit ,
            @Page ,
            @Image ,
            @Entity ,
            @Seq            )

SET @mNewID = @@IDENTITY

SET @LeadCampaignID = @mNewID

GO