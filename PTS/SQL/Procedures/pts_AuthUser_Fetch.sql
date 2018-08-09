EXEC [dbo].pts_CheckProc 'pts_AuthUser_Fetch'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_Fetch
   @AuthUserID int ,
   @TrainerID int OUTPUT ,
   @EmployeeID int OUTPUT ,
   @MemberID int OUTPUT ,
   @OrgID int OUTPUT ,
   @AffiliateID int OUTPUT ,
   @Logon nvarchar (80) OUTPUT ,
   @Password nvarchar (30) OUTPUT ,
   @Email nvarchar (80) OUTPUT ,
   @NameLast nvarchar (30) OUTPUT ,
   @NameFirst nvarchar (30) OUTPUT ,
   @AuthUserName nvarchar (62) OUTPUT ,
   @UserType int OUTPUT ,
   @UserGroup int OUTPUT ,
   @UserStatus int OUTPUT ,
   @UserKey nvarchar (40) OUTPUT ,
   @UserID int
AS

DECLARE @mTrainerID int, 
         @mEmployeeID int, 
         @mMemberID int, 
         @mOrgID int, 
         @mAffiliateID int

SET NOCOUNT ON

SELECT      @mTrainerID = tr.TrainerID, 
         @mEmployeeID = em.EmployeeID, 
         @mMemberID = me.MemberID, 
         @mOrgID = org.OrgID, 
         @mAffiliateID = af.AffiliateID, 
         @Logon = au.Logon, 
         @Password = au.Password, 
         @Email = au.Email, 
         @NameLast = au.NameLast, 
         @NameFirst = au.NameFirst, 
         @AuthUserName = LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)), 
         @UserType = au.UserType, 
         @UserGroup = au.UserGroup, 
         @UserStatus = au.UserStatus, 
         @UserKey = au.UserKey
FROM AuthUser AS au (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (au.AuthUserID = tr.AuthUserID)
LEFT OUTER JOIN Employee AS em (NOLOCK) ON (au.AuthUserID = em.AuthUserID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (au.AuthUserID = me.AuthUserID)
LEFT OUTER JOIN Org AS org (NOLOCK) ON (au.AuthUserID = org.AuthUserID)
LEFT OUTER JOIN Affiliate AS af (NOLOCK) ON (au.AuthUserID = af.AuthUserID)
WHERE (au.AuthUserID = @AuthUserID)


SET @TrainerID = ISNULL(@mTrainerID, 0)
SET @EmployeeID = ISNULL(@mEmployeeID, 0)
SET @MemberID = ISNULL(@mMemberID, 0)
SET @OrgID = ISNULL(@mOrgID, 0)
SET @AffiliateID = ISNULL(@mAffiliateID, 0)
GO