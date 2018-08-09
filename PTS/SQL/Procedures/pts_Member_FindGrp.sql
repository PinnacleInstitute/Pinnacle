EXEC [dbo].pts_CheckProc 'pts_Member_FindGrp'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindGrp ( 
   @SearchText nvarchar (25),
   @Bookmark nvarchar (35),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(me.Grp, '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
            me.MemberID 'MemberID' ,
            me.CompanyID 'CompanyID' ,
            me.AuthUserID 'AuthUserID' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            me.Email 'Email' ,
            me.Status 'Status' ,
            me.Reference 'Reference' ,
            me.VisitDate 'VisitDate' ,
            me.EnrollDate 'EnrollDate' ,
            me.Billing 'Billing' ,
            me.Phone1 'Phone1' ,
            me.Phone2 'Phone2' ,
            me.Fax 'Fax' ,
            me.IsCompany 'IsCompany' ,
            me.CompanyName 'CompanyName' ,
            me.Grp 'Grp' ,
            me.Title 'Title'
FROM Member AS me (NOLOCK)
WHERE ISNULL(me.Grp, '') LIKE @SearchText + '%'
AND ISNULL(me.Grp, '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO