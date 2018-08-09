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
            ISNULL(CONVERT(nvarchar(10), dl.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) 'BookMark' ,
            dl.DownlineID 'DownlineID' ,
            dl.ChildID 'ChildID' ,
            dl.Title 'Title' ,
            dl.Status 'Status' ,
            dl.ChildName 'ChildName' ,
            dl.EnrollDate 'EnrollDate'
FROM Downline AS dl (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), dl.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), dl.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) <= @BookMark
AND         (dl.Line = @Line)
AND         (dl.ParentID = @ParentID)
AND         (dl.Status >= 1)
AND         (dl.Status <= 4)
ORDER BY 'Bookmark' DESC

GO