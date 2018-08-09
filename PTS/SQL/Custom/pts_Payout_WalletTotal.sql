EXEC [dbo].pts_CheckProc 'pts_Payout_WalletTotal'
GO

--declare @Result varchar(1000) EXEC pts_Payout_WalletTotal 4, 37731, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Payout_WalletTotal
   @OwnerType int ,
   @OwnerID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Available money, @Pending money, @Total money 
SET @Available = 0
SET @Pending = 0
SET @Available = 0

SELECT @Available = ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND Status IN (1,4,5,7) AND Show = 0

SELECT @Pending = ABS(ISNULL(SUM(Amount),0)) FROM Payout WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND Status IN (4,5) AND Show = 0

SELECT @Total = ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND Amount > 0 AND Status IN (1,2) AND Show = 0

SET @Result = CAST(@Available AS VARCHAR(10)) + ';' +CAST(@Pending AS VARCHAR(10)) + ';' +CAST(@Total AS VARCHAR(10))
 
GO

