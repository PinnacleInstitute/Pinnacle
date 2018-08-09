EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_Add'
 GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_Add ( 
   @SalesCampaignID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SalesCampaign (
            CompanyID , 
            GroupID , 
            SalesCampaignName , 
            Seq , 
            IsCopyURL , 
            CopyURL , 
            Result
            )
VALUES (
            @CompanyID ,
            @GroupID ,
            @SalesCampaignName ,
            @Seq ,
            @IsCopyURL ,
            @CopyURL ,
            @Result            )

SET @mNewID = @@IDENTITY

SET @SalesCampaignID = @mNewID

GO