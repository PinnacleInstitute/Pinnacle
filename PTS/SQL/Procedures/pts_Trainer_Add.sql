EXEC [dbo].pts_CheckProc 'pts_Trainer_Add'
GO

CREATE PROCEDURE [dbo].pts_Trainer_Add
   @TrainerID int OUTPUT,
   @AuthUserID int OUTPUT,
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
         @mNewID int, 
         @mAuthUserID int

SET NOCOUNT ON

SET @mNow = GETDATE()
SET @mAuthUserID = 0
IF ((@UserGroup > 0))
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
      @mAuthUserID OUTPUT

   SET @AuthUserID = ISNULL(@mAuthUserID, 0)
   END

INSERT INTO Trainer (
            AuthUserID , 
            SponsorID , 
            CompanyName , 
            NameLast , 
            NameFirst , 
            Email , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            Phone1 , 
            Phone2 , 
            Fax , 
            Status , 
            Tier , 
            Website , 
            URL , 
            Image , 
            EnrollDate

            )
VALUES (
            @mAuthUserID ,
            @SponsorID ,
            @CompanyName ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @Phone1 ,
            @Phone2 ,
            @Fax ,
            @Status ,
            @Tier ,
            @Website ,
            @URL ,
            @Image ,
            @EnrollDate
            )

SET @mNewID = @@IDENTITY
SET @TrainerID = @mNewID
SET @AuthUserID = @mAuthUserID
GO