EXEC [dbo].pts_CheckProc 'pts_Member_FindSponsor3MemberID'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindSponsor3MemberID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @Sponsor3ID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), me.MemberID), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
            me.MemberID 'MemberID' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            me.Title 'Title' ,
            me.Status 'Status' ,
            me.EnrollDate 'EnrollDate'
FROM Member AS me (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), me.MemberID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), me.MemberID), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
AND         (me.Sponsor3ID = @Sponsor3ID)
AND         (me.Status <= 5)
AND         (me.IsRemoved = 0)
ORDER BY 'Bookmark'

GO