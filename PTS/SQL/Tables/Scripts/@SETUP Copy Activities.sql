-- Copy Activities (Metric Types)
DECLARE @FromCompany int, @ToCompany int, @FromGroup int, @ToGroup int
-- SET CompanyID, GroupID to copy from
--SET @FromCompany = 7
--SET @FromGroup = 7667
SET @FromCompany = 10
SET @FromGroup = 0
-- SET CompanyID, GroupID to copy to
--SET @FromCompany = 7
--SET @ToGroup = 6708
SET @ToCompany = 11
SET @ToGroup = 0

INSERT MetricType (CompanyID, GroupID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description, Required, InputOptions, AutoEvent) 
(
	SELECT @ToCompany, @ToGroup, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description, Required, InputOptions, AutoEvent
	FROM MetricType WHERE CompanyID = @FromCompany AND GroupID = @FromGroup
)

