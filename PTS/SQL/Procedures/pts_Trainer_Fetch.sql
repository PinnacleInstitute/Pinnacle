EXEC [dbo].pts_CheckProc 'pts_Trainer_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Trainer_Fetch ( 
   @TrainerID int,
   @AuthUserID int OUTPUT,
   @SponsorID int OUTPUT,
   @UserGroup int OUTPUT,
   @UserStatus int OUTPUT,
   @SponsorName nvarchar (40) OUTPUT,
   @CompanyName nvarchar (60) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @TrainerName nvarchar (62) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Phone1 nvarchar (30) OUTPUT,
   @Phone2 nvarchar (30) OUTPUT,
   @Fax nvarchar (30) OUTPUT,
   @Status int OUTPUT,
   @Tier int OUTPUT,
   @Website varchar (80) OUTPUT,
   @URL varchar (80) OUTPUT,
   @Image varchar (30) OUTPUT,
   @EnrollDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = tr.AuthUserID ,
   @SponsorID = tr.SponsorID ,
   @UserGroup = au.UserGroup ,
   @UserStatus = au.UserStatus ,
   @SponsorName = me.CompanyName ,
   @CompanyName = tr.CompanyName ,
   @NameLast = tr.NameLast ,
   @NameFirst = tr.NameFirst ,
   @TrainerName = LTRIM(RTRIM(tr.NameLast)) +  ', '  + LTRIM(RTRIM(tr.NameFirst)) ,
   @Email = tr.Email ,
   @Street = tr.Street ,
   @Unit = tr.Unit ,
   @City = tr.City ,
   @State = tr.State ,
   @Zip = tr.Zip ,
   @Country = tr.Country ,
   @Phone1 = tr.Phone1 ,
   @Phone2 = tr.Phone2 ,
   @Fax = tr.Fax ,
   @Status = tr.Status ,
   @Tier = tr.Tier ,
   @Website = tr.Website ,
   @URL = tr.URL ,
   @Image = tr.Image ,
   @EnrollDate = tr.EnrollDate
FROM Trainer AS tr (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (tr.AuthUserID = au.AuthUserID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (tr.SponsorID = me.MemberID)
WHERE tr.TrainerID = @TrainerID

GO