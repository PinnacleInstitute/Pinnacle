EXEC [dbo].pts_CheckProc 'pts_MetricType_Update'
 GO

CREATE PROCEDURE [dbo].pts_MetricType_Update ( 
   @MetricTypeID int,
   @CompanyID int,
   @GroupID int,
   @MetricTypeName nvarchar (40),
   @Seq int,
   @Pts int,
   @IsActive bit,
   @IsResult bit,
   @IsLeader bit,
   @IsQty bit,
   @Description nvarchar (200),
   @Required nvarchar (200),
   @InputOptions nvarchar (1000),
   @AutoEvent int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mtt
SET mtt.CompanyID = @CompanyID ,
   mtt.GroupID = @GroupID ,
   mtt.MetricTypeName = @MetricTypeName ,
   mtt.Seq = @Seq ,
   mtt.Pts = @Pts ,
   mtt.IsActive = @IsActive ,
   mtt.IsResult = @IsResult ,
   mtt.IsLeader = @IsLeader ,
   mtt.IsQty = @IsQty ,
   mtt.Description = @Description ,
   mtt.Required = @Required ,
   mtt.InputOptions = @InputOptions ,
   mtt.AutoEvent = @AutoEvent
FROM MetricType AS mtt
WHERE mtt.MetricTypeID = @MetricTypeID

GO