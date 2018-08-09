EXEC [dbo].pts_CheckProc 'pts_Ad_Update'
 GO

CREATE PROCEDURE [dbo].pts_Ad_Update ( 
   @AdID int,
   @CompanyID int,
   @MemberID int,
   @AdName nvarchar (60),
   @Status int,
   @Msg nvarchar (2000),
   @Placement int,
   @RefID int,
   @Priority int,
   @POrder int,
   @Zip nvarchar (20),
   @City nvarchar (30),
   @MTA nvarchar (15),
   @State nvarchar (30),
   @StartAge int,
   @EndAge int,
   @StartDate datetime,
   @EndDate datetime,
   @MaxPlace int,
   @Places int,
   @Clicks int,
   @Rotation nvarchar (10),
   @Weight int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE adv
SET adv.CompanyID = @CompanyID ,
   adv.MemberID = @MemberID ,
   adv.AdName = @AdName ,
   adv.Status = @Status ,
   adv.Msg = @Msg ,
   adv.Placement = @Placement ,
   adv.RefID = @RefID ,
   adv.Priority = @Priority ,
   adv.POrder = @POrder ,
   adv.Zip = @Zip ,
   adv.City = @City ,
   adv.MTA = @MTA ,
   adv.State = @State ,
   adv.StartAge = @StartAge ,
   adv.EndAge = @EndAge ,
   adv.StartDate = @StartDate ,
   adv.EndDate = @EndDate ,
   adv.MaxPlace = @MaxPlace ,
   adv.Places = @Places ,
   adv.Clicks = @Clicks ,
   adv.Rotation = @Rotation ,
   adv.Weight = @Weight
FROM Ad AS adv
WHERE adv.AdID = @AdID

GO