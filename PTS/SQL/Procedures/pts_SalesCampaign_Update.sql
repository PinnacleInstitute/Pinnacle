EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_Update'
 GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_Update ( 
   @SalesCampaignID int,
   @CompanyID int,
   @GroupID int,
   @SalesCampaignName nvarchar (40),
   @Seq int,
   @IsCopyURL bit,
   @CopyURL varchar (500),
   @Result nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE slc
SET slc.CompanyID = @CompanyID ,
   slc.GroupID = @GroupID ,
   slc.SalesCampaignName = @SalesCampaignName ,
   slc.Seq = @Seq ,
   slc.IsCopyURL = @IsCopyURL ,
   slc.CopyURL = @CopyURL ,
   slc.Result = @Result
FROM SalesCampaign AS slc
WHERE slc.SalesCampaignID = @SalesCampaignID

GO