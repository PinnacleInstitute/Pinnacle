EXEC [dbo].pts_CheckProc 'pts_Suggestion_FindOrgSuggestionDate'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_FindOrgSuggestionDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OrgID int,
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
            ISNULL(CONVERT(nvarchar(10), sg.SuggestionDate, 112), '') + dbo.wtfn_FormatNumber(sg.SuggestionID, 10) 'BookMark' ,
            sg.SuggestionID 'SuggestionID' ,
            sg.OrgID 'OrgID' ,
            sg.MemberID 'MemberID' ,
            og.OrgName 'OrgName' ,
            og.CompanyID 'CompanyID' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            sg.Subject 'Subject' ,
            sg.Description 'Description' ,
            sg.Status 'Status' ,
            sg.SuggestionDate 'SuggestionDate' ,
            sg.Response 'Response' ,
            sg.ChangeDate 'ChangeDate'
FROM Suggestion AS sg (NOLOCK)
LEFT OUTER JOIN Org AS og (NOLOCK) ON (sg.OrgID = og.OrgID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (sg.MemberID = me.MemberID)
WHERE ISNULL(CONVERT(nvarchar(10), sg.SuggestionDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), sg.SuggestionDate, 112), '') + dbo.wtfn_FormatNumber(sg.SuggestionID, 10) <= @BookMark
AND         (sg.OrgID = @OrgID)
ORDER BY 'Bookmark' DESC

GO