EXEC [dbo].pts_CheckProc 'pts_Member_FindCustomerInitPrice'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindCustomerInitPrice ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (30),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(15), me.InitPrice), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
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
            me.IsMaster 'IsMaster' ,
            me.Price 'Price' ,
            me.InitPrice 'InitPrice' ,
            me.Options2 'Options2'
FROM Member AS me (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(15), me.InitPrice), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(15), me.InitPrice), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
AND         (me.ReferralID = @MemberID)
AND         (me.IsRemoved = 0)
AND         (me.Status >= 1)
AND         (me.Status <= 3)
AND         (me.Level = 0)
ORDER BY 'Bookmark'

GO