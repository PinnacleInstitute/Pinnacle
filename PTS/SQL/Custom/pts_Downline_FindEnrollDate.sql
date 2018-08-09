EXEC [dbo].pts_CheckProc 'pts_Downline_FindEnrollDate'
 GO

CREATE PROCEDURE [dbo].pts_Downline_FindEnrollDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @Line int,
   @ParentID int,
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
            ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) 'BookMark' ,
            dl.DownlineID 'DownlineID' ,
            dl.ChildID 'ChildID' ,
            me.Title 'Title' ,
            me.Status 'Status' ,
            me.NameLast + ', ' + me.NameFirst 'ChildName' ,
            me.EnrollDate 'EnrollDate'
FROM Downline AS dl (NOLOCK)
JOIN Member AS me ON dl.ChildID = me.MemberID
WHERE ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) <= @BookMark
AND         (dl.Line = @Line)
AND         (dl.ParentID = @ParentID)
AND         (me.Status >= 1)
AND         (me.Status <= 4)
ORDER BY 'Bookmark' DESC

GO