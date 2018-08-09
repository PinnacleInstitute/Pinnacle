EXEC [dbo].pts_CheckProc 'pts_Org_Add'
GO

CREATE PROCEDURE [dbo].pts_Org_Add
   @OrgID int OUTPUT,
   @AuthUserID int OUTPUT,
   @ParentID int,
   @CompanyID int,
   @ForumID int,
   @MemberID int,
   @PrivateID int,
   @UserGroup int,
   @UserStatus int,
   @OrgName nvarchar (60),
   @Description nvarchar (1000),
   @Status int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @IsCatalog bit,
   @Level int,
   @Hierarchy varchar (100),
   @CourseCount int,
   @MemberCount int,
   @IsPublic bit,
   @IsChat bit,
   @IsForum bit,
   @IsSuggestion bit,
   @IsFavorite bit,
   @IsProgram bit,
   @NoCertificate bit,
   @IsCustomCertificate bit,
   @Secure int,
   @Credits int,
   @NewLogon nvarchar (80),
   @NewPassword nvarchar (30),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int, 
         @mAuthUserID int, 
         @mForumID int, 
         @mBoardUserID int, 
         @mForumModeratorID int

SET NOCOUNT ON

SET @mNow = GETDATE()
SET @mAuthUserID = 0
SET @mForumID = 0
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

INSERT INTO Org (
            AuthUserID , 
            ParentID , 
            CompanyID , 
            ForumID , 
            MemberID , 
            PrivateID , 
            OrgName , 
            Description , 
            Status , 
            NameLast , 
            NameFirst , 
            Email , 
            IsCatalog , 
            Level , 
            Hierarchy , 
            CourseCount , 
            MemberCount , 
            IsPublic , 
            IsChat , 
            IsForum , 
            IsSuggestion , 
            IsFavorite , 
            IsProgram , 
            NoCertificate , 
            IsCustomCertificate , 
            Secure , 
            Credits

            )
VALUES (
            @mAuthUserID ,
            @ParentID ,
            @CompanyID ,
            @ForumID ,
            @MemberID ,
            @PrivateID ,
            @OrgName ,
            @Description ,
            @Status ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @IsCatalog ,
            @Level ,
            @Hierarchy ,
            @CourseCount ,
            @MemberCount ,
            @IsPublic ,
            @IsChat ,
            @IsForum ,
            @IsSuggestion ,
            @IsFavorite ,
            @IsProgram ,
            @NoCertificate ,
            @IsCustomCertificate ,
            @Secure ,
            @Credits
            )

SET @mNewID = @@IDENTITY
SET @OrgID = @mNewID
SET @AuthUserID = @mAuthUserID
SET @ForumID = @mForumID
GO