EXEC [dbo].pts_CheckProc 'pts_MetricType_EnumUserGroup'
GO

CREATE PROCEDURE [dbo].pts_MetricType_EnumUserGroup
   @GroupID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      mtt.MetricTypeID AS 'ID', 
         mtt.MetricTypeName + CASE WHEN mtt.Pts != 0 THEN + ' (' + CAST(mtt.Pts AS VARCHAR(5)) + ')' ELSE '' END AS 'Name'
FROM MetricType AS mtt (NOLOCK)
WHERE (mtt.GroupID = @GroupID)
 AND (mtt.IsActive <> 0)

ORDER BY   mtt.Seq

GO