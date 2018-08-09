EXEC [dbo].pts_CheckProc 'pts_Audit_FindUserName'
 GO

CREATE PROCEDURE [dbo].pts_Audit_FindUserName ( 
   @SearchText nvarchar (62),
   @Bookmark nvarchar (72),
   @MaxRows tinyint OUTPUT,
   @AuditDate datetime,
   @ToDate datetime,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(LTRIM(RTRIM(au.NameLast)) +  ', '  + LTRIM(RTRIM(au.NameFirst)), '') + dbo.wtfn_FormatNumber(adt.AuditID, 10) 'BookMark' ,
            adt.AuditID 'AuditID' ,
            adt.AuthUserID 'AuthUserID' ,
            au.NameFirst 'NameFirst' ,
            au.NameLast 'NameLast' ,
            LTRIM(RTRIM(au.NameLast)) +  ', '  + LTRIM(RTRIM(au.NameFirst)) 'UserName' ,
            au.UserGroup 'UserGroup' ,
            adt.AuditDate 'AuditDate' ,
            adt.Action 'Action' ,
            adt.Page 'Page' ,
            adt.IP 'IP'
FROM Audit AS adt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (adt.AuthUserID = au.AuthUserID)
WHERE ISNULL(LTRIM(RTRIM(au.NameLast)) +  ', '  + LTRIM(RTRIM(au.NameFirst)), '') LIKE @SearchText + '%'
AND ISNULL(LTRIM(RTRIM(au.NameLast)) +  ', '  + LTRIM(RTRIM(au.NameFirst)), '') + dbo.wtfn_FormatNumber(adt.AuditID, 10) >= @BookMark
AND         (adt.AuditDate >= @AuditDate)
AND         (adt.AuditDate <= @ToDate)
ORDER BY 'Bookmark'

GO