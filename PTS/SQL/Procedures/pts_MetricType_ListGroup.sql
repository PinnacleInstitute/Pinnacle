EXEC [dbo].pts_CheckProc 'pts_MetricType_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_MetricType_ListGroup
   @GroupID int
AS

SET NOCOUNT ON

SELECT      mtt.MetricTypeID, 
         mtt.MetricTypeName, 
         mtt.Seq, 
         mtt.Pts, 
         mtt.IsResult, 
         mtt.IsLeader, 
         mtt.IsQty, 
         mtt.IsActive, 
         mtt.Description, 
         mtt.Required, 
         mtt.AutoEvent
FROM MetricType AS mtt (NOLOCK)
WHERE (mtt.GroupID = @GroupID)

ORDER BY   mtt.Seq

GO