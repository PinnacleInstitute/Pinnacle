EXEC [dbo].pts_CheckProc 'pts_Metric_AutoAdd'
GO
--DECLARE @Result int EXEC pts_Metric_AutoAdd 6591, 3, 'Joe Blow', @Result OUTPUT PRINT @Result
--select * from Metric order by MetricID desc

CREATE PROCEDURE [dbo].pts_Metric_AutoAdd
   @MemberID int ,
   @AutoEvent int ,
   @Note nvarchar (100) ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @GroupID int, @IsActivity bit, @ShareID int, @MetricTypeID int, @ID int, @Today datetime
SET @Result = 0
SET @Today = dbo.wtfn_DateOnly(GETDATE())

--Lookup GroupID
SELECT @GroupID = GroupID FROM Member WHERE MemberID = @MemberID

IF @GroupID > 0
BEGIN
--	Lookup Group Activity Option
	SET @IsActivity = 0
	SELECT @IsActivity = IsActivity FROM Moption WHERE MemberID = @GroupID

--	If not using own activities, Lookup Shared group activities
	IF @IsActivity = 0
	BEGIN
		SET @ShareID = 0
		SELECT @ShareID = ShareID FROM [Resource] WHERE MemberID = @GroupID AND (ResourceType = 0 OR ResourceType = 1) AND Share = 0
--		save shared group activities, or 0 if using company activities
		SET @GroupID = @ShareID 
	END
END

--	Get MetricType for this Event
SET @MetricTypeID = 0
SELECT @MetricTypeID = MetricTypeID FROM MetricType WHERE GroupID = @GroupID AND AutoEvent = @AutoEvent

IF @MetricTypeID > 0
BEGIN
--	Auto Log new Metric 
--	MetricID,MemberID,MetricTypeID,IsGoal,MetricDate,Qty,Note,InputValues,UserID
	EXEC pts_Metric_Add @ID, @MemberID, @MetricTypeID, 0, @Today, 1, @Note, '', 1
	SET @Result = @MetricTypeID 
END

GO