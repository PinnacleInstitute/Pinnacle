EXEC [dbo].pts_CheckProc 'pts_CloudZow_IncomeLeader'
GO

--DECLARE @L1 money, @L2 money, @L3 money 
--EXEC pts_CloudZow_IncomeLeader 643, 6, '7/30/12', @L1 output, @L2 output, @L3 output 
--print CAST(@L1 AS VARCHAR(10)) + ' | ' + CAST(@L2 AS VARCHAR(10)) + ' | ' + CAST(@L3 AS VARCHAR(10)) 

CREATE PROCEDURE [dbo].pts_CloudZow_IncomeLeader
   @MemberID int ,
   @Title int ,
   @StartDate datetime ,
   @L1 money OUTPUT ,
   @L2 money OUTPUT ,
   @L3 money OUTPUT
AS

SET NOCOUNT ON
SET @L1 = 0
SET @L2 = 0
SET @L3 = 0

DECLARE @EndDate datetime, @m varchar(12), @y varchar(4)
SET @EndDate = DATEADD(day,7,@StartDate)
SET @m = DATENAME(month,@StartDate)
SET @y = DATENAME(year,@StartDate)

--	-- Manager Leadership Bonus
IF @Title >= 4
BEGIN
	SELECT @L1 = ISNULL(SUM(me.Price),0) * .10
	FROM Downline AS dl 
	JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = 2 AND dl.ParentID = @MemberID AND me.Status = 1 AND me.Price > 0
	AND CAST(@m+' '+DATENAME(day,me.PaidDate)+' '+@y AS DATETIME) >= @StartDate 
	AND CAST(@m+' '+DATENAME(day,me.PaidDate)+' '+@y AS DATETIME) < @EndDate
END

--	-- Director Leadership Bonus
IF @Title >= 5
BEGIN
	SELECT @L2 = ISNULL(SUM(me.Price),0) * .05
	FROM Downline AS dl 
	JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = 3 AND dl.ParentID = @MemberID AND me.Status = 1 AND me.Price > 0
	AND CAST(@m+' '+DATENAME(day,me.PaidDate)+' '+@y AS DATETIME) >= @StartDate 
	AND CAST(@m+' '+DATENAME(day,me.PaidDate)+' '+@y AS DATETIME) < @EndDate
END

-- Executive Leadership Bonus
IF @Title >= 6
BEGIN
	SELECT @L3 = ISNULL(SUM(me.Price),0) * .05
	FROM Downline AS dl 
	JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = 4 AND dl.ParentID = @MemberID AND me.Status = 1 AND me.Price > 0
	AND CAST(@m+' '+DATENAME(day,me.PaidDate)+' '+@y AS DATETIME) >= @StartDate 
	AND CAST(@m+' '+DATENAME(day,me.PaidDate)+' '+@y AS DATETIME) < @EndDate
END

GO