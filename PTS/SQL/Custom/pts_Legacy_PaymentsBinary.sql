EXEC [dbo].pts_CheckProc 'pts_Legacy_PaymentsBinary'
GO

--DECLARE @Count varchar(1000) EXEC pts_Legacy_PaymentsBinary @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_Legacy_PaymentsBinary
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @PaymentID int, @MemberID int, @SalesOrderID int, @cnt int
SET @CompanyID = 14

DECLARE @Count int, @Today datetime 
SET @Count = 0
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

--**********************************************************************************************************
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT pa.PaymentID, me.MemberID, so.SalesOrderID
FROM Payment AS pa
JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
JOIN Member AS me ON so.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID
AND pa.Status = 3
AND pa.Purpose like 'B%' 
AND pa.Notes not like 'B*%'
AND pa.PayDate <= @Today
order by so.salesorderid

OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @SalesOrderID 
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Legacy_PaymentBinary @MemberID, @SalesOrderID
	EXEC pts_Commission_Company_14b @MemberID, @PaymentID, '', @cnt OUTPUT 
	SET @Count = @Count + 1

	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @SalesOrderID 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor

SET @Result = CAST(@Count AS VARCHAR(10))
GO
