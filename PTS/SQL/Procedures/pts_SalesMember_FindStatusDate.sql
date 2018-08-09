EXEC [dbo].pts_CheckProc 'pts_SalesMember_FindStatusDate'
 GO

CREATE PROCEDURE [dbo].pts_SalesMember_FindStatusDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
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
            ISNULL(CONVERT(nvarchar(10), slm.StatusDate, 112), '') + dbo.wtfn_FormatNumber(slm.SalesMemberID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), slm.StatusDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), slm.StatusDate, 112), '') + dbo.wtfn_FormatNumber(slm.SalesMemberID, 10) <= @BookMark
ORDER BY 'Bookmark' DESC

GO