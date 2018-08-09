EXEC [dbo].pts_CheckProc 'pts_Nexxus_ReleaseRewards'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_ReleaseRewards @Result output print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_ReleaseRewards
   @Result varchar(100) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @cnt int, @amt money, @now datetime
SET @cnt = 0
SET @amt = 0
SET @now = GETDATE()

SELECT @cnt = COUNT(*), @amt = ISNULL(SUM(Amount),0) FROM Reward WHERE Status = 4 AND HoldDate < @now

UPDATE Reward SET Status = 3 WHERE Status = 4 AND HoldDate < @now

SET @Result = CAST( LEN(@cnt) AS VARCHAR(10)) + '|' + CAST( LEN(@amt) AS VARCHAR(10))

GO

