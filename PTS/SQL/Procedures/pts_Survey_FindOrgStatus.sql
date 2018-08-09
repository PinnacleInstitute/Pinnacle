EXEC [dbo].pts_CheckProc 'pts_Survey_FindOrgStatus'
 GO

CREATE PROCEDURE [dbo].pts_Survey_FindOrgStatus ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OrgID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), su.Status), '') + dbo.wtfn_FormatNumber(su.SurveyID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), su.Status), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), su.Status), '') + dbo.wtfn_FormatNumber(su.SurveyID, 10) >= @BookMark
AND         (su.OrgID = @OrgID)
ORDER BY 'Bookmark'

GO