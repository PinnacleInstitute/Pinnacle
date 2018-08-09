EXEC [dbo].pts_CheckProc 'pts_SalesOrder_CustomList'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_CustomList
   @CompanyID int ,
   @Status int ,
   @OrderDate datetime ,
   @Quantity int ,
   @Amount money
AS

SET NOCOUNT ON

IF @CompanyID = 9  EXEC pts_SalesOrder_CustomList_9 @Status, @OrderDate, @Quantity, @Amount
IF @CompanyID = 11  EXEC pts_SalesOrder_CustomList_11 @Status, @OrderDate, @Quantity, @Amount
IF @CompanyID = 13  EXEC pts_SalesOrder_CustomList_13 @Status, @OrderDate, @Quantity, @Amount
IF @CompanyID = 14  EXEC pts_SalesOrder_CustomList_14 @Status, @OrderDate, @Quantity, @Amount
IF @CompanyID = 20  EXEC pts_SalesOrder_CustomList_20 @Status, @OrderDate, @Quantity, @Amount

GO