EXEC [dbo].pts_CheckProc 'pts_Suggestion_FindOrgStatusResponse'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_FindOrgStatusResponse ( 
   @SearchText nvarchar (1000),
   @Bookmark nvarchar (1010),
   @MaxRows tinyint OUTPUT,
   @OrgID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(sg.Response, '') + dbo.wtfn_FormatNumber(sg.SuggestionID, 10) 'BookMark' ,
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
WHERE ISNULL(sg.Response, '') LIKE '%' + @SearchText + '%'
AND ISNULL(sg.Response, '') + dbo.wtfn_FormatNumber(sg.SuggestionID, 10) >= @BookMark
AND         (sg.OrgID = @OrgID)
AND         (sg.Status = @Status)
ORDER BY 'Bookmark'

GO