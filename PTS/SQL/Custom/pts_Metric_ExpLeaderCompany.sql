EXEC [dbo].pts_CheckProc 'pts_Metric_ExpLeaderCompany'
 GO

--EXEC pts_Metric_ExpLeaderCompany 7, '1/1/13', '1/1/14', 2

CREATE PROCEDURE [dbo].pts_Metric_ExpLeaderCompany ( 
   @CompanyID int,
   @FromDate datetime,
   @ToDate datetime,
   @Rpt int
      )
AS

SET NOCOUNT ON
DECLARE @NotResult int
-- Get all Activities where IsResult != @NotResult
-- Rpt 1. Results Only ... @NotResult != 0
-- Rpt 2. Activities Only ... @NotResult != 1
-- Rpt 3. Both ... @NotResult != 2
SET @NotResult = @Rpt - 1

SELECT TOP 200 me.MemberID 'MetricID', SUM(met.qty*mtt.pts) 'Points',
 me.NameFirst + ' ' + me.NameLast + ', ' + me.Phone1 + ', ' + me.Email AS 'InputOptions' 
FROM Metric AS met
JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
JOIN Member AS me ON met.MemberID = me.MemberID
WHERE  me.CompanyID = @CompanyID
AND  met.MetricDate >= @FromDate
AND  met.MetricDate <= @ToDate
AND  mtt.IsResult != @NotResult
AND  met.IsGoal = 0
GROUP BY me.MemberID, me.NameFirst, me.NameLast, me.Phone1, me.Email 
ORDER BY SUM(met.qty*mtt.pts) DESC

GO
