EXEC [dbo].pts_CheckProc 'pts_SalesOrder_CustomCalc'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_CustomCalc
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON

GO