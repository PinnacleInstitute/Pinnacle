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
            ISNULL(dl.ChildName, '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) 'BookMark' ,
            dl.DownlineID 'DownlineID' ,
            dl.ChildID 'ChildID' ,
            dl.Title 'Title' ,
            dl.Status 'Status' ,
            dl.ChildName 'ChildName' ,
            dl.EnrollDate 'EnrollDate'
FROM Downline AS dl (NOLOCK)
WHERE ISNULL(dl.ChildName, '') LIKE @SearchText + '%'
AND ISNULL(dl.ChildName, '') + dbo.wtfn_FormatNumber(dl.DownlineID, 10) >= @BookMark
AND         (dl.Line = @Line)
AND         (dl.ParentID = @ParentID)
AND         (dl.Status >= 1)
AND         (dl.Status <= 4)
ORDER BY 'Bookmark'

GO