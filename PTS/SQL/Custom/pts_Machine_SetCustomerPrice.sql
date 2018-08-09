EXEC [dbo].pts_CheckProc 'pts_Machine_SetCustomerPrice'
GO
--declare @Result int exec pts_Machine_SetCustomerPrice 5193, @Result output 

CREATE PROCEDURE [dbo].pts_Machine_SetCustomerPrice
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Cnt int, @Price money, @Level int, @Process int, @Options2 varchar(40)
SET @Cnt = 0
SET @Price = 0

SELECT @Level = [Level], @Process = Process, @Options2 = Options2 FROM Member WHERE MemberID = @MemberID 

IF CHARINDEX('M', @Options2) > 0 SET @Price = @Price + 15
IF CHARINDEX('U', @Options2) > 0 SET @Price = @Price + 15

-- Process Affiliate
IF @Level > 0 
BEGIN
	SELECT @Cnt = COUNT(MachineID), @Price = @Price + COUNT(MachineID) * 5
	FROM Machine WHERE MemberID = @MemberID AND Status <= 2

--	If the number of active comuters is greater than the precommited number, update it.
	IF @Cnt > @Process
		UPDATE Member SET Process = @Cnt, Price = @Price WHERE MemberID = @MemberID
END

-- Process Customer
IF @Level = 0 
BEGIN
	SELECT @Cnt = COUNT(MachineID), @Price = @Price + COUNT(MachineID) * 5
	FROM Machine WHERE MemberID = @MemberID AND Status <= 2

	UPDATE Member SET Process = @Cnt, Price = @Price WHERE MemberID = @MemberID
END

SET @Result = @Cnt

GO