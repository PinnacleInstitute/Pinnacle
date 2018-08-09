EXEC [dbo].pts_CheckProc 'pts_CloudZow_Prepaid'
GO

--DECLARE @Result varchar(1000) EXEC pts_CloudZow_Prepaid 521, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Prepaid
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Prepaid Services Summary
-- ***********************************************************************
DECLARE @ToDate datetime, @FromDate datetime
DECLARE 
@PB money,
@PC money,
@PD money,
@BV money,
@CB money,
@CT money,
@C1 money,
@C2 money,
@C3 money,
@C4 money

SET @ToDate = GETDATE()
SET @FromDate = DATEADD(wk,-13,@ToDate)
SET	@PB = 0.0
SET	@PC = 0.0
SET	@PD = 0.0 
SET	@BV = 0.0 
SET	@CB = 0.0
SET	@CT = 0.0
SET	@C1 = 0.0 
SET	@C2 = 0.0 
SET	@C3 = 0.0 
SET	@C4 = 0.0 
 
SELECT @PC = ISNULL(SUM(Amount),0) FROM Prepaid WHERE MemberID = @MemberID AND PayType = 1
SELECT @PD = ISNULL(SUM(Amount),0) FROM Prepaid WHERE MemberID = @MemberID AND PayType = 2
SET @PB = @PC - @PD
SELECT @BV = ISNULL(SUM(Amount),0) FROM Prepaid WHERE MemberID = @MemberID AND PayDate >= @FromDate AND PayDate <= @ToDate AND PayType = 2

SELECT @C1 = ISNULL(SUM(Amount),0) FROM Cash WHERE MemberID = @MemberID AND CashType = 1
SELECT @C2 = ISNULL(SUM(Amount),0) FROM Cash WHERE MemberID = @MemberID AND CashType = 2
SELECT @C3 = ISNULL(SUM(Amount),0) FROM Cash WHERE MemberID = @MemberID AND CashType = 3
SELECT @C4 = ISNULL(SUM(Amount),0) FROM Cash WHERE MemberID = @MemberID AND CashType = 4
SET @CT = (@C1 + @C2)
SET @CB = (@C1 + @C2) - (@C3 + @C4)

SET @Result = '<PTSSUMMARY ' + 
'pb="' + CAST(@PB AS VARCHAR(10)) + '" ' +
'pc="' + CAST(@PC AS VARCHAR(10))  + '" ' +
'pd="' + CAST(@PD AS VARCHAR(10)) + '" ' +
'bv="' + CAST(@BV AS VARCHAR(10)) + '" ' +
'cb="' + CAST(@CB AS VARCHAR(10))  + '" ' +
'ct="' + CAST(@CT AS VARCHAR(10)) + '" ' +
'c1="' + CAST(@C1 AS VARCHAR(10)) + '" ' +
'c2="' + CAST(@C2 AS VARCHAR(10)) + '" ' +
'c3="' + CAST(@C3 AS VARCHAR(10)) + '" ' +
'c4="' + CAST(@C4 AS VARCHAR(10))  + '" ' +
'/>'

GO

