EXEC [dbo].pts_CheckProc 'pts_Metric_Find'
 GO

CREATE PROCEDURE [dbo].pts_Metric_Find ( 
   @GroupID int,
   @FromDate datetime,
   @EndDate ,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(met., '') + dbo.wtfn_FormatNumber(met.MetricID, 10) 'BookMark' ,
FROM Metric AS met (NOLOCK)
LEFT OUTER JOIN MetricType AS mtt (NOLOCK) ON (met.MetricTypeID = mtt.MetricTypeID)
WHERE ISNULL(met., '') LIKE @SearchText + '%'
AND ISNULL(met., '') + dbo.wtfn_FormatNumber(met.MetricID, 10) >= @BookMark
WHERE (met.GroupID = @GroupID)
AND         (met.MetricDate >= @FromDate)
AND         (met.MetricDate <= @ToDate)
ORDER BY 'Bookmark'

GO