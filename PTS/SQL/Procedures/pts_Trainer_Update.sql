EXEC [dbo].pts_CheckProc 'pts_Trainer_Update'
GO

CREATE PROCEDURE [dbo].pts_Trainer_Update
   @TrainerID int,
   @AuthUserID int,
   @SponsorID int,
   @UserGroup int,
   @UserStatus int,
   @CompanyName nvarchar (60),
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Fax nvarchar (30),
   @Status int,
   @Tier int,
   @Website varchar (80),
   @URL varchar (80),
   @Image varchar (30),
   @EnrollDate datetime,
   @NewLogon nvarchar (80),
   @NewPassword nvarchar (30),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
IF ((@AuthUserID > 0) AND (@UserGroup = 0))
   BEGIN
   EXEC pts_AuthUser_Delete
      @AuthUserID ,
      @UserID

   SET @AuthUserID = 0
   END

IF ((@AuthUserID > 0) AND (@UserGroup > 0))
   BEGIN
   EXEC pts_AuthUser_Update
      @AuthUserID ,
      @Email ,
      @NameLast ,
      @NameFirst ,
      @UserGroup ,
      @UserStatus ,
      @UserID

   END

IF ((@AuthUserID = 0) AND (@UserGroup > 0))
   BEGIN
   EXEC pts_AuthUser_Add
      @NewLogon ,
      @NewPassword ,
      @Email ,
      @NameLast ,
      @NameFirst ,
      @UserGroup ,
      @UserStatus ,
      @UserID ,
      @mNewID OUTPUT

   SET @AuthUserID = ISNULL(@mNewID, 0)
   END

UPDATE tr
SET tr.AuthUserID = @AuthUserID ,
   tr.SponsorID = @SponsorID ,
   tr.CompanyName = @CompanyName ,
   tr.NameLast = @NameLast ,
   tr.NameFirst = @NameFirst ,
   tr.Email = @Email ,
   tr.Street = @Street ,
   tr.Unit = @Unit ,
   tr.City = @City ,
   tr.State = @State ,
   tr.Zip = @Zip ,
   tr.Country = @Country ,
   tr.Phone1 = @Phone1 ,
   tr.Phone2 = @Phone2 ,
   tr.Fax = @Fax ,
   tr.Status = @Status ,
   tr.Tier = @Tier ,
   tr.Website = @Website ,
   tr.URL = @URL ,
   tr.Image = @Image ,
   tr.EnrollDate = @EnrollDate
FROM Trainer AS tr
WHERE (tr.TrainerID = @TrainerID)


GO