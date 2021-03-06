EXEC [dbo].pts_CheckProc 'pts_Member_FindMasterRole'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindMasterRole ( 
   @SearchText nvarchar (15),
   @Bookmark nvarchar (25),
   @MaxRows tinyint OUTPUT,
   @MasterID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(me.Role, '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
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
WHERE ISNULL(me.Role, '') LIKE '%' + @SearchText + '%'
AND ISNULL(me.Role, '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
AND         (me.MasterID = @MasterID)
AND         (me.IsRemoved = 0)
ORDER BY 'Bookmark'

GO