EXEC [dbo].pts_CheckProc 'pts_Member_FindGroupEnrollDate'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindGroupEnrollDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @GroupID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
            me.MemberID 'MemberID' ,
            me.CompanyID 'CompanyID' ,
            me.AuthUserID 'AuthUserID' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            me.Email 'Email' ,
            me.Status 'Status' ,
            me.Level 'Level' ,
            me.Reference 'Reference' ,
            me.VisitDate 'VisitDate' ,
            me.EnrollDate 'EnrollDate' ,
            me.Billing 'Billing' ,
            me.Phone1 'Phone1' ,
            me.Phone2 'Phone2' ,
            me.Fax 'Fax' ,
            me.IsCompany 'IsCompany' ,
            me.CompanyName 'CompanyName' ,
            me.GroupID 'GroupID' ,
            me.Role 'Role' ,
            me.Title 'Title' ,
            me.Qualify 'Qualify' ,
            me.IsMaster 'IsMaster'
FROM Member AS me (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) <= @BookMark
AND         (me.GroupID = @GroupID)
AND         (me.IsRemoved = 0)
AND         (me.Status > 0)
AND         (me.Status < 5)
ORDER BY 'Bookmark' DESC

GO