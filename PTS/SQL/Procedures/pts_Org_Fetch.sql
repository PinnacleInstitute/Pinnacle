EXEC [dbo].pts_CheckProc 'pts_Org_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Org_Fetch ( 
   @OrgID int,
   @AuthUserID int OUTPUT,
   @ParentID int OUTPUT,
   @CompanyID int OUTPUT,
   @ForumID int OUTPUT,
   @MemberID int OUTPUT,
   @PrivateID int OUTPUT,
   @UserGroup int OUTPUT,
   @UserStatus int OUTPUT,
   @Logon nvarchar (80) OUTPUT,
   @OrgName nvarchar (60) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Status int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @ContactName nvarchar (62) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @IsCatalog bit OUTPUT,
   @Level int OUTPUT,
   @Hierarchy varchar (100) OUTPUT,
   @CourseCount int OUTPUT,
   @MemberCount int OUTPUT,
   @IsPublic bit OUTPUT,
   @IsChat bit OUTPUT,
   @IsForum bit OUTPUT,
   @IsSuggestion bit OUTPUT,
   @IsFavorite bit OUTPUT,
   @IsProgram bit OUTPUT,
   @NoCertificate bit OUTPUT,
   @IsCustomCertificate bit OUTPUT,
   @Secure int OUTPUT,
   @Credits int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = org.AuthUserID ,
   @ParentID = org.ParentID ,
   @CompanyID = org.CompanyID ,
   @ForumID = org.ForumID ,
   @MemberID = org.MemberID ,
   @PrivateID = org.PrivateID ,
   @UserGroup = au.UserGroup ,
   @UserStatus = au.UserStatus ,
   @Logon = au.Logon ,
   @OrgName = org.OrgName ,
   @Description = org.Description ,
   @Status = org.Status ,
   @NameLast = org.NameLast ,
   @NameFirst = org.NameFirst ,
   @ContactName = LTRIM(RTRIM(org.NameLast)) +  ', '  + LTRIM(RTRIM(org.NameFirst)) ,
   @Email = org.Email ,
   @IsCatalog = org.IsCatalog ,
   @Level = org.Level ,
   @Hierarchy = org.Hierarchy ,
   @CourseCount = org.CourseCount ,
   @MemberCount = org.MemberCount ,
   @IsPublic = org.IsPublic ,
   @IsChat = org.IsChat ,
   @IsForum = org.IsForum ,
   @IsSuggestion = org.IsSuggestion ,
   @IsFavorite = org.IsFavorite ,
   @IsProgram = org.IsProgram ,
   @NoCertificate = org.NoCertificate ,
   @IsCustomCertificate = org.IsCustomCertificate ,
   @Secure = org.Secure ,
   @Credits = org.Credits
FROM Org AS org (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (org.AuthUserID = au.AuthUserID)
LEFT OUTER JOIN Org AS parent (NOLOCK) ON (org.ParentID = parent.OrgID)
WHERE org.OrgID = @OrgID

GO