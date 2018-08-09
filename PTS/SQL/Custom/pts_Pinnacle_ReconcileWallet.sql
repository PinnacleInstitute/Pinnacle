EXEC [dbo].pts_CheckProc 'pts_Pinnacle_ReconcileWallet'
GO

--DECLARE @Count varchar(1000) EXEC pts_Pinnacle_ReconcileWallet 17, @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_Pinnacle_ReconcileWallet
   @CompanyID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @Count int, @MemberID int, @Available money, @Pending int
SET @Count = 0

--**********************************************************************************************************
--Process - Bill Members (Billing = 3)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
Select MemberID
FROM Member AS me
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
AND 0 < ( SELECT COUNT(*) FROM Payout WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status NOT IN (2,6) )
--AND me.MemberID = 13073

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @Available = ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status IN (1,4,5,7)
	SELECT @Pending = COUNT(*) FROM Payout WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status IN (4,5)

	IF @Pending = 0 AND @Available = 0
	BEGIN 
		UPDATE Payout SET Status = 2 WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status IN (1,4,5,7)
		SET @Count = @Count + 1
	END

	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))

GO

