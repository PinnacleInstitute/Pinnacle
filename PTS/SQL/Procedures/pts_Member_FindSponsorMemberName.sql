EXEC [dbo].pts_CheckProc 'pts_Member_FindSponsorMemberName'
 GO

CREATE PROCEDURE [dbo].pts_Member_FindSponsorMemberName ( 
   @SearchText nvarchar (62),
   @Bookmark nvarchar (72),
   @MaxRows tinyint OUTPUT,
   @SponsorID int,
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
AND         (me.SponsorID = @SponsorID)
AND         (me.Status <= 5)
AND         (me.IsRemoved = 0)
ORDER BY 'Bookmark'

GO