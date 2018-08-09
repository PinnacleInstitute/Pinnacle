EXEC [dbo].pts_CheckProc 'pts_BinarySale_Add'
GO

CREATE PROCEDURE [dbo].pts_BinarySale_Add
   @BinarySaleID int OUTPUT,
   @MemberID int,
   @RefID int,
   @SaleDate datetime,
   @SaleType int,
   @Amount money,
   @UserID int
AS

DECLARE @mNewID int

SET NOCOUNT ON

INSERT INTO BinarySale (
            MemberID , 
            RefID , 
            SaleDate , 
            SaleType , 
            Amount

            )
VALUES (
            @MemberID ,
            @RefID ,
            @SaleDate ,
            @SaleType ,
            @Amount
            )

SET @mNewID = @@IDENTITY
SET @BinarySaleID = @mNewID
EXEC pts_BinarySale_AddCustom
   @MemberID ,
   @SaleType ,
   @Amount

GO