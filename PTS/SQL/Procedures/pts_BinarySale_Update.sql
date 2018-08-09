EXEC [dbo].pts_CheckProc 'pts_BinarySale_Update'
 GO

CREATE PROCEDURE [dbo].pts_BinarySale_Update ( 
   @BinarySaleID int,
   @MemberID int,
   @RefID int,
   @SaleDate datetime,
   @SaleType int,
   @Amount money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bs
SET bs.MemberID = @MemberID ,
   bs.RefID = @RefID ,
   bs.SaleDate = @SaleDate ,
   bs.SaleType = @SaleType ,
   bs.Amount = @Amount
FROM BinarySale AS bs
WHERE bs.BinarySaleID = @BinarySaleID

GO