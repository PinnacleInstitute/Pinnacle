EXEC [dbo].pts_CheckProc 'pts_Metric_Update'
 GO

CREATE PROCEDURE [dbo].pts_Metric_Update ( 
   @MetricID int,
   @MemberID int,
   @MetricTypeID int,
   @IsGoal bit,
   @MetricDate datetime,
   @Qty int,
   @Note nvarchar (100),
   @InputValues nvarchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE met
SET met.MemberID = @MemberID ,
   met.MetricTypeID = @MetricTypeID ,
   met.IsGoal = @IsGoal ,
   met.MetricDate = @MetricDate ,
   met.Qty = @Qty ,
   met.Note = @Note ,
   met.InputValues = @InputValues
FROM Metric AS met
WHERE met.MetricID = @MetricID

GO