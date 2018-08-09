EXEC [dbo].pts_CheckProc 'pts_Suggestion_FindCompanyStatusSuggestionID'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_FindCompanyStatusSuggestionID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), sg.SuggestionID), '') + dbo.wtfn_FormatNumber(sg.SuggestionID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), sg.SuggestionID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), sg.SuggestionID), '') + dbo.wtfn_FormatNumber(sg.SuggestionID, 10) >= @BookMark
AND         (og.CompanyID = @CompanyID)
AND         (sg.Status = @Status)
ORDER BY 'Bookmark'

GO