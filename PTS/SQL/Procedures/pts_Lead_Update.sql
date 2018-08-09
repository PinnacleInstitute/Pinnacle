EXEC [dbo].pts_CheckProc 'pts_Lead_Update'
 GO

CREATE PROCEDURE [dbo].pts_Lead_Update ( 
   @LeadID int,
   @MemberID int,
   @SalesCampaignID int,
   @ProspectTypeID int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @LeadDate datetime,
   @Email nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Comment nvarchar (500),
   @Source nvarchar (20),
   @Status int,
   @Priority nvarchar (4),
   @CallBackDate datetime,
   @CallBackTime varchar (8),
   @TimeZone int,
   @BestTime int,
   @DistributorID int,
   @DistributeDate datetime,
   @Code int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ld
SET ld.MemberID = @MemberID ,
   ld.SalesCampaignID = @SalesCampaignID ,
   ld.ProspectTypeID = @ProspectTypeID ,
   ld.NameLast = @NameLast ,
   ld.NameFirst = @NameFirst ,
   ld.LeadDate = @LeadDate ,
   ld.Email = @Email ,
   ld.Phone1 = @Phone1 ,
   ld.Phone2 = @Phone2 ,
   ld.Street = @Street ,
   ld.Unit = @Unit ,
   ld.City = @City ,
   ld.State = @State ,
   ld.Zip = @Zip ,
   ld.Country = @Country ,
   ld.Comment = @Comment ,
   ld.Source = @Source ,
   ld.Status = @Status ,
   ld.Priority = @Priority ,
   ld.CallBackDate = @CallBackDate ,
   ld.CallBackTime = @CallBackTime ,
   ld.TimeZone = @TimeZone ,
   ld.BestTime = @BestTime ,
   ld.DistributorID = @DistributorID ,
   ld.DistributeDate = @DistributeDate ,
   ld.Code = @Code
FROM Lead AS ld
WHERE ld.LeadID = @LeadID

GO