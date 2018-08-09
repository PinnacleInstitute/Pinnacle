-- Copy Activities (Metric Types)
DECLARE @FromCompany int, @ToCompany int, @FromGroup int, @ToGroup int
-- SET CompanyID, GroupID to copy from
SET @FromCompany = 17
SET @FromGroup = 0
SET @ToCompany = 21
SET @ToGroup = 0

INSERT MetricType (CompanyID, GroupID, MetricTypeName, Seq, Pts, IsActive, IsResult, IsLeader, IsQty, Description, Required, InputOptions, AutoEvent) 
(
	SELECT @ToCompany, @ToGroup, MetricTypeName, Seq, Pts, IsActive, IsResult, IsLeader, IsQty, Description, Required, InputOptions, AutoEvent
	FROM MetricType WHERE CompanyID = @FromCompany AND GroupID = @FromGroup
)


--select * from MetricType where companyid > 7 order by CompanyID, groupid, seq

--delete MetricType where CompanyID = 17
