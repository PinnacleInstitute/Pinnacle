EXEC [dbo].pts_CheckProc 'pts_Member_FindSponsor3EnrollDate'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindSponsor3EnrollDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @Sponsor3ID int,
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
            ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
            me.MemberID 'MemberID' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            me.Title 'Title' ,
            me.Status 'Status' ,
            me.EnrollDate 'EnrollDate'
FROM Member AS me (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), me.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) <= @BookMark
AND         (me.Sponsor3ID = @Sponsor3ID)
AND         (me.Status <= 5)
AND         (me.IsRemoved = 0)
ORDER BY 'Bookmark' DESC

GO