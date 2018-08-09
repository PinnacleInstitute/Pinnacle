EXEC [dbo].pts_CheckProc 'pts_Audit_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Audit_Fetch ( 
   @AuditID int,
   @AuthUserID int OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @UserName nvarchar (62) OUTPUT,
   @UserGroup nvarchar (80) OUTPUT,
   @AuditDate datetime OUTPUT,
   @Action int OUTPUT,
   @Page varchar (100) OUTPUT,
   @IP varchar (16) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = adt.AuthUserID ,
   @NameFirst = au.NameFirst ,
   @NameLast = au.NameLast ,
   @UserName = LTRIM(RTRIM(au.NameLast)) +  ', '  + LTRIM(RTRIM(au.NameFirst)) ,
   @UserGroup = au.UserGroup ,
   @AuditDate = adt.AuditDate ,
   @Action = adt.Action ,
   @Page = adt.Page ,
   @IP = adt.IP
FROM Audit AS adt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (adt.AuthUserID = au.AuthUserID)
WHERE adt.AuditID = @AuditID

GO