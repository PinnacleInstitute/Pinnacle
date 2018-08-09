EXEC [dbo].pts_CheckProc 'pts_BarterCredit_Total'
GO

--declare @Result varchar(1000) EXEC pts_BarterCredit_Total 151, 1, @Result output print @Result

CREATE PROCEDURE [dbo].pts_BarterCredit_Total
   @OwnerType int ,
   @OwnerID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Available money, @Total money 
SET @Available = 0
SET @Total = 0

SELECT @Available = ISNULL(SUM(Amount),0) FROM BarterCredit WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND Status IN (1,2)

SELECT @Total = ISNULL(SUM(Amount),0) FROM BarterCredit WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND Amount > 0 AND Status != 3

SET @Result = CAST(@Available AS VARCHAR(10)) + ';' + CAST(@Total AS VARCHAR(10))
 
GO

