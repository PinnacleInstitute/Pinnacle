EXEC [dbo].pts_CheckProc 'pts_Org_Update'
GO

CREATE PROCEDURE [dbo].pts_Org_Update
   @OrgID int,
   @AuthUserID int,
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
         @mBoardUserID int, 
         @mForumModeratorID int, 
         @mOldParentID int, 
         @mOldCompanyID int, 
         @mOldIsPublic bit, 
         @midx int, 
         @mHReplace nvarchar (100), 
         @mNewParentLevel int, 
         @mParentPrivateID int, 
         @mOldPrivateID int

SET NOCOUNT ON

SET @mNow = GETDATE()

   SELECT @mOldParentID = ParentID, @mOldIsPublic = IsPublic FROM Org WHERE OrgID = @OrgID

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

IF ((@IsPublic <> @mOldIsPublic))
   BEGIN
   IF ((@IsPublic <> 0)   )
      BEGIN
      
         IF @ParentID > 0 
            SELECT @PrivateID = PrivateID FROM Org WHERE OrgID = @ParentID
         ELSE   
            SET @PrivateID = 0
         UPDATE Org SET PrivateID = @PrivateID
         WHERE CompanyID = @CompanyID AND Hierarchy LIKE @Hierarchy + '%' AND PrivateID = @OrgID

      END

   IF ((@IsPublic = 0)   )
      BEGIN
      
         SET @mOldPrivateID = @PrivateID
         SET @PrivateID = @OrgID
         UPDATE Org SET PrivateID = @PrivateID
         WHERE CompanyID = @CompanyID AND Hierarchy LIKE @Hierarchy + '%' AND PrivateID = @mOldPrivateID

      END

   END

IF ((@mOldParentID <> 0) AND (@ParentID <> @mOldParentID))
   BEGIN
   
   SELECT @mOldCompanyID = CompanyID, @mHReplace=Hierarchy, @mNewParentLevel=[Level] FROM Org WHERE OrgID = @ParentID
   SET @mOldCompanyID = ISNULL(@mOldCompanyID,0)

   IF ((@CompanyID <> @mOldCompanyID)   )
      BEGIN
      SET @ParentID = @mOldParentID
      END

   SET @midx =  PATINDEX('%/'+ CAST(@OrgID as varchar(10)) + '/%', @mHReplace) 
   IF ((@midx <> 0) AND (@Level <= @mNewParentLevel)   )
      BEGIN
      SET @ParentID = @mOldParentID
      END

   END

UPDATE org
SET org.AuthUserID = @AuthUserID ,
   org.ParentID = @ParentID ,
   org.CompanyID = @CompanyID ,
   org.ForumID = @ForumID ,
   org.MemberID = @MemberID ,
   org.PrivateID = @PrivateID ,
   org.OrgName = @OrgName ,
   org.Description = @Description ,
   org.Status = @Status ,
   org.NameLast = @NameLast ,
   org.NameFirst = @NameFirst ,
   org.Email = @Email ,
   org.IsCatalog = @IsCatalog ,
   org.Level = @Level ,
   org.Hierarchy = @Hierarchy ,
   org.CourseCount = @CourseCount ,
   org.MemberCount = @MemberCount ,
   org.IsPublic = @IsPublic ,
   org.IsChat = @IsChat ,
   org.IsForum = @IsForum ,
   org.IsSuggestion = @IsSuggestion ,
   org.IsFavorite = @IsFavorite ,
   org.IsProgram = @IsProgram ,
   org.NoCertificate = @NoCertificate ,
   org.IsCustomCertificate = @IsCustomCertificate ,
   org.Secure = @Secure ,
   org.Credits = @Credits
FROM Org AS org
WHERE (org.OrgID = @OrgID)


IF ((@mOldParentID <> 0) AND (@ParentID <> @mOldParentID) AND (@CompanyID = @mOldCompanyID))
   BEGIN
   EXEC pts_Org_UpdateHierarchy
      @CompanyID ,
      @OrgID ,
      @ParentID ,
      @Level ,
      @Hierarchy

   EXEC pts_Company_Update_Counters
      @CompanyID

   END

GO