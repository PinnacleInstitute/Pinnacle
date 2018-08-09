EXEC [dbo].pts_CheckProc 'pts_SeminarLog_Report'
GO

CREATE PROCEDURE [dbo].pts_SeminarLog_Report
   @SeminarID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Result int OUTPUT
AS 

SET NOCOUNT ON
SET @Result = 0

SELECT @Result = COUNT(*) 
FROM SeminarLog
WHERE SeminarID = @SeminarID
AND LogDate >= @ReportFromDate
AND LogDate < @ReportToDate

GO