EXEC [dbo].pts_CheckProc 'pts_Nexxus_StatementsPending'
GO
--declare @Result varchar(1000) EXEC pts_Nexxus_StatementsPending @Result output print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_StatementsPending
   @Result varchar(100) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @StatementID int, @Amount money, @tmpResult nvarchar (100), @cnt int, @amt money
DECLARE @Today datetime, @GoodDate datetime

SET @Today = dbo.wtfn_DateOnly( GETDATE() )
SET @GoodDate = DATEADD(day,-3,@Today)

SET @cnt = 0
SET @amt = 0

DECLARE Statement_Cursor CURSOR LOCAL STATIC FOR 
SELECT StatementID, Amount FROM Statement WHERE Status = 2 AND PayType = 1 AND PaidDate < @GoodDate

OPEN Statement_Cursor
FETCH NEXT FROM Statement_Cursor INTO @StatementID, @Amount
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Statement_ProcessStatement @StatementID, 3, @tmpResult OUTPUT
	SET @cnt = @cnt + 1
	Set @amt = @amt + @Amount	
	
	FETCH NEXT FROM Statement_Cursor INTO @StatementID, @Amount
END
CLOSE Statement_Cursor
DEALLOCATE Statement_Cursor

SET @Result = CAST( @cnt AS VARCHAR(10)) + '|' + CAST( @amt AS VARCHAR(10))

GO

