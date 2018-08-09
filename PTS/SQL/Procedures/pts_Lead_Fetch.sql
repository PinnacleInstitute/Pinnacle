EXEC [dbo].pts_CheckProc 'pts_Lead_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Lead_Fetch ( 
   @LeadID int,
   @MemberID int OUTPUT,
   @SalesCampaignID int OUTPUT,
   @ProspectTypeID int OUTPUT,
   @SalesCampaignName nvarchar (40) OUTPUT,
   @ProspectTypeName nvarchar (40) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @LeadName nvarchar (62) OUTPUT,
   @LeadDate datetime OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Phone1 nvarchar (30) OUTPUT,
   @Phone2 nvarchar (30) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Comment nvarchar (500) OUTPUT,
   @Source nvarchar (20) OUTPUT,
   @Status int OUTPUT,
   @Priority nvarchar (4) OUTPUT,
   @CallBackDate datetime OUTPUT,
   @CallBackTime varchar (8) OUTPUT,
   @TimeZone int OUTPUT,
   @BestTime int OUTPUT,
   @DistributorID int OUTPUT,
   @DistributeDate datetime OUTPUT,
   @Code int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ld.MemberID ,
   @SalesCampaignID = ld.SalesCampaignID ,
   @ProspectTypeID = ld.ProspectTypeID ,
   @SalesCampaignName = sc.SalesCampaignName ,
   @ProspectTypeName = pt.ProspectTypeName ,
   @NameLast = ld.NameLast ,
   @NameFirst = ld.NameFirst ,
   @LeadName = LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  ''  ,
   @LeadDate = ld.LeadDate ,
   @Email = ld.Email ,
   @Phone1 = ld.Phone1 ,
   @Phone2 = ld.Phone2 ,
   @Street = ld.Street ,
   @Unit = ld.Unit ,
   @City = ld.City ,
   @State = ld.State ,
   @Zip = ld.Zip ,
   @Country = ld.Country ,
   @Comment = ld.Comment ,
   @Source = ld.Source ,
   @Status = ld.Status ,
   @Priority = ld.Priority ,
   @CallBackDate = ld.CallBackDate ,
   @CallBackTime = ld.CallBackTime ,
   @TimeZone = ld.TimeZone ,
   @BestTime = ld.BestTime ,
   @DistributorID = ld.DistributorID ,
   @DistributeDate = ld.DistributeDate ,
   @Code = ld.Code
FROM Lead AS ld (NOLOCK)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (ld.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesCampaign AS sc (NOLOCK) ON (ld.SalesCampaignID = sc.SalesCampaignID)
WHERE ld.LeadID = @LeadID

GO