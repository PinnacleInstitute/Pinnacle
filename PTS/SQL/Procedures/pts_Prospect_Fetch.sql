EXEC [dbo].pts_CheckProc 'pts_Prospect_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_Fetch ( 
   @ProspectID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @SalesCampaignID int OUTPUT,
   @LeadCampaignID int OUTPUT,
   @PresentID int OUTPUT,
   @ProspectTypeID int OUTPUT,
   @EmailID int OUTPUT,
   @AffiliateID int OUTPUT,
   @NewsLetterID int OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @StatusName nvarchar (40) OUTPUT,
   @IsBoard nvarchar (40) OUTPUT,
   @SalesCampaignName nvarchar (40) OUTPUT,
   @ProspectTypeName nvarchar (40) OUTPUT,
   @IsCopyURL bit OUTPUT,
   @Result nvarchar (20) OUTPUT,
   @ProspectName nvarchar (60) OUTPUT,
   @Website nvarchar (80) OUTPUT,
   @Description nvarchar (2000) OUTPUT,
   @Representing nvarchar (20) OUTPUT,
   @Potential money OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @ContactName nvarchar (62) OUTPUT,
   @Title nvarchar (30) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Phone1 nvarchar (30) OUTPUT,
   @Phone2 nvarchar (30) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Status int OUTPUT,
   @NextEvent int OUTPUT,
   @NextDate datetime OUTPUT,
   @NextTime varchar (8) OUTPUT,
   @CreateDate datetime OUTPUT,
   @FBDate datetime OUTPUT,
   @CloseDate datetime OUTPUT,
   @DeadDate datetime OUTPUT,
   @Date1 datetime OUTPUT,
   @Date2 datetime OUTPUT,
   @Date3 datetime OUTPUT,
   @Date4 datetime OUTPUT,
   @Date5 datetime OUTPUT,
   @Date6 datetime OUTPUT,
   @Date7 datetime OUTPUT,
   @Date8 datetime OUTPUT,
   @Date9 datetime OUTPUT,
   @Date10 datetime OUTPUT,
   @ChangeDate datetime OUTPUT,
   @ChangeStatus int OUTPUT,
   @EmailDate datetime OUTPUT,
   @RSVP int OUTPUT,
   @EmailStatus int OUTPUT,
   @LeadViews int OUTPUT,
   @LeadPages varchar (10) OUTPUT,
   @LeadReplies int OUTPUT,
   @PresentViews int OUTPUT,
   @PresentPages varchar (40) OUTPUT,
   @NoDistribute bit OUTPUT,
   @DistributorID int OUTPUT,
   @DistributeDate datetime OUTPUT,
   @Priority nvarchar (4) OUTPUT,
   @InputValues nvarchar (1000) OUTPUT,
   @Source nvarchar (20) OUTPUT,
   @Code int OUTPUT,
   @Reminder int OUTPUT,
   @RemindDate datetime OUTPUT,
   @TimeZone int OUTPUT,
   @BestTime int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pr.CompanyID ,
   @MemberID = pr.MemberID ,
   @SalesCampaignID = pr.SalesCampaignID ,
   @LeadCampaignID = pr.LeadCampaignID ,
   @PresentID = pr.PresentID ,
   @ProspectTypeID = pr.ProspectTypeID ,
   @EmailID = pr.EmailID ,
   @AffiliateID = pr.AffiliateID ,
   @NewsLetterID = pr.NewsLetterID ,
   @MemberName = me.CompanyName ,
   @StatusName = sls.SalesStepName ,
   @IsBoard = sls.IsBoard ,
   @SalesCampaignName = slc.SalesCampaignName ,
   @ProspectTypeName = pt.ProspectTypeName ,
   @IsCopyURL = slc.IsCopyURL ,
   @Result = slc.Result ,
   @ProspectName = pr.ProspectName ,
   @Website = pr.Website ,
   @Description = pr.Description ,
   @Representing = pr.Representing ,
   @Potential = pr.Potential ,
   @NameLast = pr.NameLast ,
   @NameFirst = pr.NameFirst ,
   @ContactName = LTRIM(RTRIM(pr.NameLast)) +  ', '  + LTRIM(RTRIM(pr.NameFirst)) ,
   @Title = pr.Title ,
   @Email = pr.Email ,
   @Phone1 = pr.Phone1 ,
   @Phone2 = pr.Phone2 ,
   @Street = pr.Street ,
   @Unit = pr.Unit ,
   @City = pr.City ,
   @State = pr.State ,
   @Zip = pr.Zip ,
   @Country = pr.Country ,
   @Status = pr.Status ,
   @NextEvent = pr.NextEvent ,
   @NextDate = pr.NextDate ,
   @NextTime = pr.NextTime ,
   @CreateDate = pr.CreateDate ,
   @FBDate = pr.FBDate ,
   @CloseDate = pr.CloseDate ,
   @DeadDate = pr.DeadDate ,
   @Date1 = pr.Date1 ,
   @Date2 = pr.Date2 ,
   @Date3 = pr.Date3 ,
   @Date4 = pr.Date4 ,
   @Date5 = pr.Date5 ,
   @Date6 = pr.Date6 ,
   @Date7 = pr.Date7 ,
   @Date8 = pr.Date8 ,
   @Date9 = pr.Date9 ,
   @Date10 = pr.Date10 ,
   @ChangeDate = pr.ChangeDate ,
   @ChangeStatus = pr.ChangeStatus ,
   @EmailDate = pr.EmailDate ,
   @RSVP = pr.RSVP ,
   @EmailStatus = pr.EmailStatus ,
   @LeadViews = pr.LeadViews ,
   @LeadPages = pr.LeadPages ,
   @LeadReplies = pr.LeadReplies ,
   @PresentViews = pr.PresentViews ,
   @PresentPages = pr.PresentPages ,
   @NoDistribute = pr.NoDistribute ,
   @DistributorID = pr.DistributorID ,
   @DistributeDate = pr.DistributeDate ,
   @Priority = pr.Priority ,
   @InputValues = pr.InputValues ,
   @Source = pr.Source ,
   @Code = pr.Code ,
   @Reminder = pr.Reminder ,
   @RemindDate = pr.RemindDate ,
   @TimeZone = pr.TimeZone ,
   @BestTime = pr.BestTime
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE pr.ProspectID = @ProspectID

GO