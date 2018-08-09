EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_90'
GO

--TEST
--EXEC pts_Emailee_ListCustom_90 17, '', '', '', '', ''

-- Certification(Assessment) Completion Date Range
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_90
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @AssessmentID int, @FromDate datetime, @ToDate datetime

IF @Data1 != '' 
	SET @AssessmentID = CAST(@Data1 AS int)
Else
	SET @AssessmentID = 0

IF @Data2 != '' 
	SET @FromDate = CAST(@Data2 AS datetime)
Else
	SET @FromDate = 0

IF @Data3 != '' 
	SET @ToDate = CAST(@Data3 AS datetime)
Else
	SET @ToDate = 0

SELECT ma.MemberAssessID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       am.AssessmentName AS 'Data1', 
       dbo.wtfn_DateOnlyStr(ma.CompleteDate) AS 'Data2',
       CAST(ma.Status AS nvarchar(20)) AS 'Data3',
       CAST(ma.Score AS nvarchar(20)) AS 'Data4',
       '' AS 'Data5'
FROM MemberAssess AS ma (NOLOCK)
JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID
JOIN Member AS me ON ma.MemberID = me.MemberID
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ma.AssessmentID = @AssessmentID
AND ma.Status > 0
AND ma.CompleteDate > 0
AND ( @FromDate = 0 OR ma.CompleteDate >= @FromDate ) 
AND ( @ToDate = 0 OR ma.CompleteDate <= @ToDate ) 
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
