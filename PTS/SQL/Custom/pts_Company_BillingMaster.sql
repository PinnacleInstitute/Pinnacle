EXEC [dbo].pts_CheckProc 'pts_Company_BillingMaster'
GO

CREATE PROCEDURE [dbo].pts_Company_BillingMaster
   @MasterID int,
   @Count int OUTPUT,
   @MasterPrice money OUTPUT,
   @MasterRetail money OUTPUT,
   @BilledFor nvarchar(500) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Price money, @BusAcctPrice money, @BusAcctRetail money, @BusAccts int, @MasterMembers int

-- ----- Get Master Account Price Options -----
SELECT @BusAcctPrice = BusAcctPrice, @BusAcctRetail = BusAcctRetail, @BusAccts = BusAccts FROM Member WHERE MemberID = @MasterID
SELECT @MasterMembers = ISNULL(COUNT(*),0) FROM Member WHERE MasterID = @MasterID AND Status = 1 AND Billing = 4 

SET @Count = @MasterMembers
SET @MasterPrice = 0
SET @MasterRetail = 0
IF @MasterMembers > @BusAccts
BEGIN
	SET @MasterPrice = (@MasterMembers - @BusAccts) * @BusAcctPrice 
	SET @MasterRetail = (@MasterMembers - @BusAccts) * @BusAcctRetail 
END

-- ----- Get MemberIDs of billed members and update PaidDates-----
DECLARE @MemberID int,  @EnrollDate datetime, @TrialDays int
DECLARE @Now datetime

SET @Now = GETDATE()

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, EnrollDate, TrialDays FROM Member WHERE MasterID = @MasterID AND Status = 1 AND Billing = 4

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate, @TrialDays

SET @BilledFor = ''

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @BilledFor = @BilledFor + CAST(@MemberID AS varchar(10)) + ' '

--	Calculate and Update the new paid date, if no paid date start at enrolldate + trialdays
	UPDATE MEMBER SET PaidDate =
	DATEADD(month, DATEDIFF(month,DATEADD(day,TrialDays,EnrollDate), @Now), DATEADD(day,TrialDays,EnrollDate)) 
 	WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate, @TrialDays
END
IF @Count > 0 SET @BilledFor = 'Billed:[' + @BilledFor + '] '

CLOSE Member_cursor
DEALLOCATE Member_cursor

GO