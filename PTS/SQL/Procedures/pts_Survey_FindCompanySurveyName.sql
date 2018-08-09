EXEC [dbo].pts_CheckProc 'pts_Survey_FindCompanySurveyName'
 GO

CREATE PROCEDURE [dbo].pts_Survey_FindCompanySurveyName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
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
AND         (og.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO