EXEC [dbo].pts_CheckProc 'pts_Survey_FindSurveyName'
 GO

CREATE PROCEDURE [dbo].pts_Survey_FindSurveyName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(su.SurveyName, '') + dbo.wtfn_FormatNumber(su.SurveyID, 10) 'BookMark' ,
            su.SurveyID 'SurveyID' ,
            su.OrgID 'OrgID' ,
            og.OrgName 'OrgName' ,
            og.CompanyID 'CompanyID' ,
            su.SurveyName 'SurveyName' ,
            su.Description 'Description' ,
            su.Status 'Status' ,
            su.StartDate 'StartDate' ,
            su.EndDate 'EndDate'
FROM Survey AS su (NOLOCK)
LEFT OUTER JOIN Org AS og (NOLOCK) ON (su.OrgID = og.OrgID)
WHERE ISNULL(su.SurveyName, '') LIKE @SearchText + '%'
AND ISNULL(su.SurveyName, '') + dbo.wtfn_FormatNumber(su.SurveyID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO