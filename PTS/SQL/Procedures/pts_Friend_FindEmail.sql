EXEC [dbo].pts_CheckProc 'pts_Friend_FindEmail'
 GO

CREATE PROCEDURE [dbo].pts_Friend_FindEmail ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(fr.Email, '') + dbo.wtfn_FormatNumber(fr.FriendID, 10) 'BookMark' ,
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
WHERE ISNULL(fr.Email, '') LIKE @SearchText + '%'
AND ISNULL(fr.Email, '') + dbo.wtfn_FormatNumber(fr.FriendID, 10) >= @BookMark
AND         (fr.MemberID = @MemberID)
ORDER BY 'Bookmark'

GO