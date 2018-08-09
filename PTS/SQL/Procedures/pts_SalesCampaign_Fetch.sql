EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_Fetch ( 
   @SalesCampaignID int,
   @CompanyID int OUTPUT,
   @GroupID int OUTPUT,
   @SalesCampaignName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @IsCopyURL bit OUTPUT,
   @CopyURL varchar (500) OUTPUT,
   @Result nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = slc.CompanyID ,
   @GroupID = slc.GroupID ,
   @SalesCampaignName = slc.SalesCampaignName ,
   @Seq = slc.Seq ,
   @IsCopyURL = slc.IsCopyURL ,
   @CopyURL = slc.CopyURL ,
   @Result = slc.Result
FROM SalesCampaign AS slc (NOLOCK)
WHERE slc.SalesCampaignID = @SalesCampaignID

GO