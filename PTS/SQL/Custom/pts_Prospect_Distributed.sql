EXEC [dbo].pts_CheckProc 'pts_Prospect_Distributed'
GO

CREATE PROCEDURE [dbo].pts_Prospect_Distributed
   @MemberID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT   me.NameLast + ', ' + me.NameFirst AS 'MemberName', 
         MIN(pr.ProspectID) AS 'ProspectID', 
         COUNT(pr.ProspectID) AS 'Count'
FROM Prospect AS pr (NOLOCK)
JOIN Member AS me ON pr.MemberID = me.MemberID
WHERE pr.DistributorID = @MemberID
AND pr.DistributeDate >= @ReportFromDate
AND pr.DistributeDate <= @ReportToDate
GROUP BY me.NameLast + ', ' + me.NameFirst
ORDER BY me.NameLast + ', ' + me.NameFirst

GO

