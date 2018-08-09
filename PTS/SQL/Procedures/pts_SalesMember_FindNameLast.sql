EXEC [dbo].pts_CheckProc 'pts_SalesMember_FindNameLast'
 GO

CREATE PROCEDURE [dbo].pts_SalesMember_FindNameLast ( 
   @SearchText nvarchar (30),
   @Bookmark nvarchar (40),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(me.NameLast, '') + dbo.wtfn_FormatNumber(slm.SalesMemberID, 10) 'BookMark' ,
            slm.SalesMemberID 'SalesMemberID' ,
            slm.SalesAreaID 'SalesAreaID' ,
            slm.MemberID 'MemberID' ,
            sla.SalesAreaName 'SalesAreaName' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) 'MemberName' ,
            slm.Status 'Status' ,
            slm.StatusDate 'StatusDate' ,
            slm.FTE 'FTE' ,
            slm.Assignment 'Assignment'
FROM SalesMember AS slm (NOLOCK)
LEFT OUTER JOIN SalesArea AS sla (NOLOCK) ON (slm.SalesAreaID = sla.SalesAreaID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (slm.MemberID = me.MemberID)
WHERE ISNULL(me.NameLast, '') LIKE @SearchText + '%'
AND ISNULL(me.NameLast, '') + dbo.wtfn_FormatNumber(slm.SalesMemberID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO