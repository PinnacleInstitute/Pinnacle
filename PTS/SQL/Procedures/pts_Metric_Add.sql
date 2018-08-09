EXEC [dbo].pts_CheckProc 'pts_Metric_Add'
 GO

CREATE PROCEDURE [dbo].pts_Metric_Add ( 
   @MetricID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Metric (
            MemberID , 
            MetricTypeID , 
            IsGoal , 
            MetricDate , 
            Qty , 
            Note , 
            InputValues
            )
VALUES (
            @MemberID ,
            @MetricTypeID ,
            @IsGoal ,
            @MetricDate ,
            @Qty ,
            @Note ,
            @InputValues            )

SET @mNewID = @@IDENTITY

SET @MetricID = @mNewID

GO