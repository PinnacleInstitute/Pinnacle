EXEC [dbo].pts_CheckProc 'pts_Prospect_Add'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_Add ( 
   @ProspectID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @SalesCampaignID int,
   @LeadCampaignID int,
   @PresentID int,
   @ProspectTypeID int,
   @EmailID int,
   @AffiliateID int,
   @NewsLetterID int,
   @ProspectName nvarchar (60),
   @Website nvarchar (80),
   @Description nvarchar (2000),
   @Representing nvarchar (20),
   @Potential money,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Title nvarchar (30),
   @Email nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Status int,
   @NextEvent int,
   @NextDate datetime,
   @NextTime varchar (8),
   @CreateDate datetime,
   @FBDate datetime,
   @CloseDate datetime,
   @DeadDate datetime,
   @Date1 datetime,
   @Date2 datetime,
   @Date3 datetime,
   @Date4 datetime,
   @Date5 datetime,
   @Date6 datetime,
   @Date7 datetime,
   @Date8 datetime,
   @Date9 datetime,
   @Date10 datetime,
   @ChangeDate datetime,
   @ChangeStatus int,
   @EmailDate datetime,
   @RSVP int,
   @EmailStatus int,
   @LeadViews int,
   @LeadPages varchar (10),
   @LeadReplies int,
   @PresentViews int,
   @PresentPages varchar (40),
   @NoDistribute bit,
   @DistributorID int,
   @DistributeDate datetime,
   @Priority nvarchar (4),
   @InputValues nvarchar (1000),
   @Source nvarchar (20),
   @Code int,
   @Reminder int,
   @RemindDate datetime,
   @TimeZone int,
   @BestTime int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Prospect (
            CompanyID , 
            MemberID , 
            SalesCampaignID , 
            LeadCampaignID , 
            PresentID , 
            ProspectTypeID , 
            EmailID , 
            AffiliateID , 
            NewsLetterID , 
            ProspectName , 
            Website , 
            Description , 
            Representing , 
            Potential , 
            NameLast , 
            NameFirst , 
            Title , 
            Email , 
            Phone1 , 
            Phone2 , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            Status , 
            NextEvent , 
            NextDate , 
            NextTime , 
            CreateDate , 
            FBDate , 
            CloseDate , 
            DeadDate , 
            Date1 , 
            Date2 , 
            Date3 , 
            Date4 , 
            Date5 , 
            Date6 , 
            Date7 , 
            Date8 , 
            Date9 , 
            Date10 , 
            ChangeDate , 
            ChangeStatus , 
            EmailDate , 
            RSVP , 
            EmailStatus , 
            LeadViews , 
            LeadPages , 
            LeadReplies , 
            PresentViews , 
            PresentPages , 
            NoDistribute , 
            DistributorID , 
            DistributeDate , 
            Priority , 
            InputValues , 
            Source , 
            Code , 
            Reminder , 
            RemindDate , 
            TimeZone , 
            BestTime
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @SalesCampaignID ,
            @LeadCampaignID ,
            @PresentID ,
            @ProspectTypeID ,
            @EmailID ,
            @AffiliateID ,
            @NewsLetterID ,
            @ProspectName ,
            @Website ,
            @Description ,
            @Representing ,
            @Potential ,
            @NameLast ,
            @NameFirst ,
            @Title ,
            @Email ,
            @Phone1 ,
            @Phone2 ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @Status ,
            @NextEvent ,
            @NextDate ,
            @NextTime ,
            @CreateDate ,
            @FBDate ,
            @CloseDate ,
            @DeadDate ,
            @Date1 ,
            @Date2 ,
            @Date3 ,
            @Date4 ,
            @Date5 ,
            @Date6 ,
            @Date7 ,
            @Date8 ,
            @Date9 ,
            @Date10 ,
            @ChangeDate ,
            @ChangeStatus ,
            @EmailDate ,
            @RSVP ,
            @EmailStatus ,
            @LeadViews ,
            @LeadPages ,
            @LeadReplies ,
            @PresentViews ,
            @PresentPages ,
            @NoDistribute ,
            @DistributorID ,
            @DistributeDate ,
            @Priority ,
            @InputValues ,
            @Source ,
            @Code ,
            @Reminder ,
            @RemindDate ,
            @TimeZone ,
            @BestTime            )

SET @mNewID = @@IDENTITY

SET @ProspectID = @mNewID

GO