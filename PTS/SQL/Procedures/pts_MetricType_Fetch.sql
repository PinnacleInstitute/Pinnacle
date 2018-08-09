EXEC [dbo].pts_CheckProc 'pts_MetricType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MetricType_Fetch ( 
   @MetricTypeID int,
   @CompanyID int OUTPUT,
   @GroupID int OUTPUT,
   @MetricTypeName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @Pts int OUTPUT,
   @IsActive bit OUTPUT,
   @IsResult bit OUTPUT,
   @IsLeader bit OUTPUT,
   @IsQty bit OUTPUT,
   @Description nvarchar (200) OUTPUT,
   @Required nvarchar (200) OUTPUT,
   @InputOptions nvarchar (1000) OUTPUT,
   @AutoEvent int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = mtt.CompanyID ,
   @GroupID = mtt.GroupID ,
   @MetricTypeName = mtt.MetricTypeName ,
   @Seq = mtt.Seq ,
   @Pts = mtt.Pts ,
   @IsActive = mtt.IsActive ,
   @IsResult = mtt.IsResult ,
   @IsLeader = mtt.IsLeader ,
   @IsQty = mtt.IsQty ,
   @Description = mtt.Description ,
   @Required = mtt.Required ,
   @InputOptions = mtt.InputOptions ,
   @AutoEvent = mtt.AutoEvent
FROM MetricType AS mtt (NOLOCK)
WHERE mtt.MetricTypeID = @MetricTypeID

GO