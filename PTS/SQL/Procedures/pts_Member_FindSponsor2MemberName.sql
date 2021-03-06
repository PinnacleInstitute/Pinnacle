EXEC [dbo].pts_CheckProc 'pts_Member_FindSponsor2MemberName'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindSponsor2MemberName ( 
   @SearchText nvarchar (62),
   @Bookmark nvarchar (72),
   @MaxRows tinyint OUTPUT,
   @Sponsor2ID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) 'BookMark' ,
            me.MemberID 'MemberID' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            me.Title 'Title' ,
            me.Status 'Status' ,
            me.EnrollDate 'EnrollDate'
FROM Member AS me (NOLOCK)
WHERE ISNULL(LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)), '') LIKE @SearchText + '%'
AND ISNULL(LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)), '') + dbo.wtfn_FormatNumber(me.MemberID, 10) >= @BookMark
AND         (me.Sponsor2ID = @Sponsor2ID)
AND         (me.Status <= 5)
AND         (me.IsRemoved = 0)
ORDER BY 'Bookmark'

GO