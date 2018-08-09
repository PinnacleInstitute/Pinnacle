EXEC [dbo].pts_CheckProc 'pts_Lead_Add'
 GO

CREATE PROCEDURE [dbo].pts_Lead_Add ( 
   @LeadID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Lead (
            MemberID , 
            SalesCampaignID , 
            ProspectTypeID , 
            NameLast , 
            NameFirst , 
            LeadDate , 
            Email , 
            Phone1 , 
            Phone2 , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            Comment , 
            Source , 
            Status , 
            Priority , 
            CallBackDate , 
            CallBackTime , 
            TimeZone , 
            BestTime , 
            DistributorID , 
            DistributeDate , 
            Code
            )
VALUES (
            @MemberID ,
            @SalesCampaignID ,
            @ProspectTypeID ,
            @NameLast ,
            @NameFirst ,
            @LeadDate ,
            @Email ,
            @Phone1 ,
            @Phone2 ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @Comment ,
            @Source ,
            @Status ,
            @Priority ,
            @CallBackDate ,
            @CallBackTime ,
            @TimeZone ,
            @BestTime ,
            @DistributorID ,
            @DistributeDate ,
            @Code            )

SET @mNewID = @@IDENTITY

SET @LeadID = @mNewID

GO