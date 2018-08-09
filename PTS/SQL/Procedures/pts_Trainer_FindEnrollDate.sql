EXEC [dbo].pts_CheckProc 'pts_Trainer_FindEnrollDate'
 GO

CREATE PROCEDURE [dbo].pts_Trainer_FindEnrollDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
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
            ISNULL(CONVERT(nvarchar(10), tr.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(tr.TrainerID, 10) 'BookMark' ,
            tr.TrainerID 'TrainerID' ,
            tr.AuthUserID 'AuthUserID' ,
            tr.SponsorID 'SponsorID' ,
            au.UserGroup 'UserGroup' ,
            au.UserStatus 'UserStatus' ,
            me.CompanyName 'SponsorName' ,
            tr.CompanyName 'CompanyName' ,
            tr.NameLast 'NameLast' ,
            tr.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(tr.NameLast)) +  ', '  + LTRIM(RTRIM(tr.NameFirst)) 'TrainerName' ,
            tr.Email 'Email' ,
            tr.Street 'Street' ,
            tr.Unit 'Unit' ,
            tr.City 'City' ,
            tr.State 'State' ,
            tr.Zip 'Zip' ,
            tr.Country 'Country' ,
            tr.Phone1 'Phone1' ,
            tr.Phone2 'Phone2' ,
            tr.Fax 'Fax' ,
            tr.Status 'Status' ,
            tr.Tier 'Tier' ,
            tr.Website 'Website' ,
            tr.URL 'URL' ,
            tr.Image 'Image' ,
            tr.EnrollDate 'EnrollDate'
FROM Trainer AS tr (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (tr.AuthUserID = au.AuthUserID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (tr.SponsorID = me.MemberID)
WHERE ISNULL(CONVERT(nvarchar(10), tr.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), tr.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(tr.TrainerID, 10) <= @BookMark
ORDER BY 'Bookmark' DESC

GO