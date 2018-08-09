EXEC [dbo].pts_CheckProc 'pts_SeminarLog_ClearAll'
GO

CREATE PROCEDURE [dbo].pts_SeminarLog_ClearAll
   @SeminarID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SELECT @Count = COUNT(*) FROM SeminarLog
WHERE SeminarID = @SeminarID
AND LogDate >= @FromDate
AND LogDate <= @ToDate

DELETE SeminarLog
WHERE SeminarID = @SeminarID
AND LogDate >= @FromDate
AND LogDate <= @ToDate

GO