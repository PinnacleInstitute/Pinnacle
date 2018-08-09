EXEC [dbo].pts_CheckProc 'pts_Downline_FindChildName'
 GO

CREATE PROCEDURE [dbo].pts_Downline_FindChildName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @Line int,
   @ParentID int,
   @UserID int
      )
AS

SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(me.NameLast + ', ' + me.NameFirst, '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) 'BookMark' ,
            dl.DownlineID 'DownlineID' ,
            dl.ChildID 'ChildID' ,
            me.Title 'Title' ,
            me.Status 'Status' ,
            me.NameLast + ', ' + me.NameFirst 'ChildName' ,
            me.EnrollDate 'EnrollDate'
FROM Downline AS dl (NOLOCK)
JOIN Member AS me ON dl.ChildID = me.MemberID
WHERE ISNULL(me.NameLast + ', ' + me.NameFirst, '') LIKE @SearchText + '%'
AND ISNULL(me.NameLast + ', ' + me.NameFirst, '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) >= @BookMark
AND         (dl.Line = @Line)
AND         (dl.ParentID = @ParentID)
AND         (me.Status >= 1)
AND         (me.Status <= 4)
ORDER BY 'Bookmark'

GO