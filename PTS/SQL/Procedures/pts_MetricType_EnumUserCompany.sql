EXEC [dbo].pts_CheckProc 'pts_MetricType_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_MetricType_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      mtt.MetricTypeID AS 'ID', 
         mtt.MetricTypeName + CASE WHEN mtt.Pts != 0 THEN + ' (' + CAST(mtt.Pts AS VARCHAR(5)) + ')' ELSE '' END AS 'Name'
FROM MetricType AS mtt (NOLOCK)
WHERE (mtt.CompanyID = @CompanyID)
 AND (mtt.GroupID = 0)
 AND (mtt.IsActive <> 0)

ORDER BY   mtt.Seq

GO