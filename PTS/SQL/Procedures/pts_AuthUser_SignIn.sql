EXEC [dbo].pts_CheckProc 'pts_AuthUser_SignIn'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_SignIn
   @Logon nvarchar (80) ,
   @Password nvarchar (30) OUTPUT ,
   @AuthUserID int OUTPUT ,
   @TrainerID int OUTPUT ,
   @EmployeeID int OUTPUT ,
   @MemberID int OUTPUT ,
   @OrgID int OUTPUT ,
   @AffiliateID int OUTPUT ,
   @Email nvarchar (80) OUTPUT ,
   @NameLast nvarchar (30) OUTPUT ,
   @NameFirst nvarchar (30) OUTPUT ,
   @AuthUserName nvarchar (62) OUTPUT ,
   @UserType int OUTPUT ,
   @UserGroup int OUTPUT ,
   @UserStatus int OUTPUT ,
   @UserKey nvarchar (40) OUTPUT ,
   @UserCode nvarchar (10) OUTPUT
AS

DECLARE @mAuthUserID int, 
         @mTrainerID int, 
         @mEmployeeID int, 
         @mMemberID int, 
         @mOrgID int, 
         @mAffiliateID int, 
         @mUserType int, 
         @mUserGroup int, 
         @mUserStatus int, 
         @mUserCode nvarchar (10)

SET NOCOUNT ON

SELECT      @mAuthUserID = au.AuthUserID, 
         @mTrainerID = tr.TrainerID, 
         @mEmployeeID = em.EmployeeID, 
         @mMemberID = me.MemberID, 
         @mOrgID = org.OrgID, 
         @mAffiliateID = af.AffiliateID, 
         @Email = au.Email, 
         @NameLast = au.NameLast, 
         @NameFirst = au.NameFirst, 
         @AuthUserName = LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)), 
         @UserKey = au.UserKey, 
         @UserCode = au.UserCode, 
         @mUserType = au.UserType, 
         @mUserGroup = au.UserGroup, 
         @mUserStatus = au.UserStatus
FROM AuthUser AS au (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (au.AuthUserID = tr.AuthUserID)
LEFT OUTER JOIN Employee AS em (NOLOCK) ON (au.AuthUserID = em.AuthUserID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (au.AuthUserID = me.AuthUserID)
LEFT OUTER JOIN Org AS org (NOLOCK) ON (au.AuthUserID = org.AuthUserID)
LEFT OUTER JOIN Affiliate AS af (NOLOCK) ON (au.AuthUserID = af.AuthUserID)
WHERE (au.Logon = @Logon)
 AND (au.Password = @Password)


IF ((@mAuthUserID <> 0) AND (@mUserStatus = 1))
   BEGIN
   EXEC pts_AuthUser_SetUserCode
      @mAuthUserID ,
      @mUserCode OUTPUT

   END

SET @AuthUserID = ISNULL(@mAuthUserID, 0)
SET @TrainerID = ISNULL(@mTrainerID, 0)
SET @EmployeeID = ISNULL(@mEmployeeID, 0)
SET @MemberID = ISNULL(@mMemberID, 0)
SET @OrgID = ISNULL(@mOrgID, 0)
SET @AffiliateID = ISNULL(@mAffiliateID, 0)
SET @UserType = ISNULL(@mUserType, 0)
SET @UserGroup = ISNULL(@mUserGroup, 0)
SET @UserStatus = ISNULL(@mUserStatus, 0)
SET @UserCode = @mUserCode
SET @Password = ''
GO