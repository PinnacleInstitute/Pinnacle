EXEC [dbo].pts_CheckProc 'pts_Member_FindStatus'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindStatus ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), me.Status), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
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
            me.Title 'Title' ,
            me.Qualify 'Qualify' ,
            me.IsIncluded 'IsIncluded' ,
            me.IsMaster 'IsMaster'
FROM Member AS me (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), me.Status), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), me.Status), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO