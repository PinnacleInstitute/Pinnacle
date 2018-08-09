EXEC [dbo].pts_CheckProc 'pts_Metric_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Metric_Fetch ( 
   @MetricID int,
   @MemberID int OUTPUT,
   @MetricTypeID int OUTPUT,
   @MetricTypeName nvarchar (40) OUTPUT,
   @InputOptions nvarchar (1000) OUTPUT,
   @IsGoal bit OUTPUT,
   @MetricDate datetime OUTPUT,
   @Qty int OUTPUT,
   @Note nvarchar (100) OUTPUT,
   @InputValues nvarchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = met.MemberID ,
   @MetricTypeID = met.MetricTypeID ,
   @MetricTypeName = mtt.MetricTypeName ,
   @InputOptions = mtt.InputOptions ,
   @IsGoal = met.IsGoal ,
   @MetricDate = met.MetricDate ,
   @Qty = met.Qty ,
   @Note = met.Note ,
   @InputValues = met.InputValues
FROM Metric AS met (NOLOCK)
LEFT OUTER JOIN MetricType AS mtt (NOLOCK) ON (met.MetricTypeID = mtt.MetricTypeID)
WHERE met.MetricID = @MetricID

GO