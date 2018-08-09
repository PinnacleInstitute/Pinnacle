EXEC [dbo].pts_CheckProc 'pts_MetricType_Copy'
GO
--EXEC pts_MetricType_Copy 7667, 13

CREATE PROCEDURE [dbo].pts_MetricType_Copy
   @FromGroup int ,
   @ToGroup int 
AS

SET NOCOUNT ON

INSERT MetricType (CompanyID, GroupID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description, Required, InputOptions) 
(
	SELECT CompanyID, @ToGroup, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description, Required, InputOptions
	FROM MetricType WHERE GroupID = @FromGroup
)

GO

