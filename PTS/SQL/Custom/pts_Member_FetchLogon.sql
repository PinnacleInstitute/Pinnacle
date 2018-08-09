EXEC [dbo].pts_CheckProc 'pts_Member_FetchLogon'
GO

CREATE PROCEDURE [dbo].pts_Member_FetchLogon
   @Logon nvarchar (80) ,
   @MemberID int OUTPUT ,
   @Level int OUTPUT ,
   @GroupID int OUTPUT
AS

SET NOCOUNT ON

SELECT @MemberID = ISNULL(me.MemberID,0), @Level = ISNULL(me.Level,0), @GroupID = ISNULL(me.GroupID,0) 
FROM   AuthUser AS au (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (au.AuthUserID = me.AuthUserID)
WHERE  au.Logon = @Logon

GO

