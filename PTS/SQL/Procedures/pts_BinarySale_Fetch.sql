EXEC [dbo].pts_CheckProc 'pts_BinarySale_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BinarySale_Fetch ( 
   @BinarySaleID int,
   @MemberID int OUTPUT,
   @RefID int OUTPUT,
   @SaleDate datetime OUTPUT,
   @SaleType int OUTPUT,
   @Amount money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = bs.MemberID ,
   @RefID = bs.RefID ,
   @SaleDate = bs.SaleDate ,
   @SaleType = bs.SaleType ,
   @Amount = bs.Amount
FROM BinarySale AS bs (NOLOCK)
WHERE bs.BinarySaleID = @BinarySaleID

GO