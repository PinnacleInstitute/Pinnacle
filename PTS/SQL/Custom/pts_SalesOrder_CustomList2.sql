EXEC [dbo].pts_CheckProc 'pts_SalesOrder_CustomList2'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_CustomList2
   @CompanyID int ,
   @Status int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Quantity int ,
   @Amount money
AS

SET NOCOUNT ON

IF @CompanyID = 14  EXEC pts_SalesOrder_CustomList2_14 @Status, @ReportFromDate, @ReportToDate, @Quantity, @Amount

GO