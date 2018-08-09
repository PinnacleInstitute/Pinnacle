EXEC [dbo].pts_CheckProc 'pts_Friend_FindFriendDate'
 GO

CREATE PROCEDURE [dbo].pts_Friend_FindFriendDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
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
            ISNULL(CONVERT(nvarchar(10), fr.FriendDate, 112), '') + dbo.wtfn_FormatNumber(fr.FriendID, 10) 'BookMark' ,
            fr.FriendID 'FriendID' ,
            fr.MemberID 'MemberID' ,
            fr.FriendGroupID 'FriendGroupID' ,
            fr.CountryID 'CountryID' ,
            frg.FriendGroupName 'FriendGroupName' ,
            cou.CountryName 'CountryName' ,
            fr.NameLast 'NameLast' ,
            fr.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(fr.NameLast)) +  ', '  + LTRIM(RTRIM(fr.NameFirst)) 'FriendName' ,
            fr.Email 'Email' ,
            fr.FriendDate 'FriendDate' ,
            fr.Status 'Status' ,
            fr.Zip 'Zip' ,
            fr.DOB 'DOB'
FROM Friend AS fr (NOLOCK)
LEFT OUTER JOIN FriendGroup AS frg (NOLOCK) ON (fr.FriendGroupID = frg.FriendGroupID)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (fr.CountryID = cou.CountryID)
WHERE ISNULL(CONVERT(nvarchar(10), fr.FriendDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), fr.FriendDate, 112), '') + dbo.wtfn_FormatNumber(fr.FriendID, 10) <= @BookMark
AND         (fr.MemberID = @MemberID)
ORDER BY 'Bookmark' DESC

GO