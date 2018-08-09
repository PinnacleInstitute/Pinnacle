EXEC [dbo].pts_CheckProc 'pts_Ad_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Ad_Fetch ( 
   @AdID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @AdName nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @Msg nvarchar (2000) OUTPUT,
   @Placement int OUTPUT,
   @RefID int OUTPUT,
   @Priority int OUTPUT,
   @POrder int OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @MTA nvarchar (15) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @StartAge int OUTPUT,
   @EndAge int OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @MaxPlace int OUTPUT,
   @Places int OUTPUT,
   @Clicks int OUTPUT,
   @Rotation nvarchar (10) OUTPUT,
   @Weight int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = adv.CompanyID ,
   @MemberID = adv.MemberID ,
   @MemberName = me.CompanyName ,
   @AdName = adv.AdName ,
   @Status = adv.Status ,
   @Msg = adv.Msg ,
   @Placement = adv.Placement ,
   @RefID = adv.RefID ,
   @Priority = adv.Priority ,
   @POrder = adv.POrder ,
   @Zip = adv.Zip ,
   @City = adv.City ,
   @MTA = adv.MTA ,
   @State = adv.State ,
   @StartAge = adv.StartAge ,
   @EndAge = adv.EndAge ,
   @StartDate = adv.StartDate ,
   @EndDate = adv.EndDate ,
   @MaxPlace = adv.MaxPlace ,
   @Places = adv.Places ,
   @Clicks = adv.Clicks ,
   @Rotation = adv.Rotation ,
   @Weight = adv.Weight
FROM Ad AS adv (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (adv.MemberID = me.MemberID)
WHERE adv.AdID = @AdID

GO