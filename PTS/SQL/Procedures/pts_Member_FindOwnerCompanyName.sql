EXEC [dbo].pts_CheckProc 'pts_Member_FindOwnerCompanyName'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindOwnerCompanyName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(me.CompanyName, '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
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
            me.PaidDate 'PaidDate' ,
            me.Billing 'Billing' ,
            me.Phone1 'Phone1' ,
            me.Phone2 'Phone2' ,
            me.Fax 'Fax' ,
            me.IsCompany 'IsCompany' ,
            me.CompanyName 'CompanyName' ,
            me.GroupID 'GroupID' ,
            me.Title 'Title' ,
            me.ReferralID 'ReferralID' ,
            me.SponsorID 'SponsorID' ,
            me.Sponsor2ID 'Sponsor2ID' ,
            me.Sponsor3ID 'Sponsor3ID' ,
            me.Qualify 'Qualify' ,
            me.IsIncluded 'IsIncluded' ,
            me.IsMaster 'IsMaster' ,
            me.Price 'Price' ,
            me.Process 'Process' ,
            me.Role 'Role' ,
            me.PromoID 'PromoID' ,
            me.BV 'BV' ,
            me.QV 'QV' ,
            me.BV2 'BV2' ,
            me.QV2 'QV2' ,
            me.BV3 'BV3' ,
            me.QV3 'QV3' ,
            me.BV4 'BV4' ,
            me.QV4 'QV4'
FROM Member AS me (NOLOCK)
WHERE ISNULL(me.CompanyName, '') LIKE @SearchText + '%'
AND ISNULL(me.CompanyName, '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
AND         (me.CompanyID = @CompanyID)
AND         (me.IsRemoved = 0)
ORDER BY 'Bookmark'

GO