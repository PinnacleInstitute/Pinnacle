EXEC [dbo].pts_CheckProc 'pts_Survey_FindCompanySurveyID'
 GO

CREATE PROCEDURE [dbo].pts_Survey_FindCompanySurveyID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), su.SurveyID), '') + dbo.wtfn_FormatNumber(su.SurveyID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), su.SurveyID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), su.SurveyID), '') + dbo.wtfn_FormatNumber(su.SurveyID, 10) >= @BookMark
AND         (og.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO