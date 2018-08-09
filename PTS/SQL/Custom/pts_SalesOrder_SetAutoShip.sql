EXEC [dbo].pts_CheckProc 'pts_SalesOrder_SetAutoShip'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_SetAutoShip
   @MemberID int ,
   @SalesOrderID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

UPDATE SalesOrder SET IsActive = 1 WHERE SalesOrderID = @SalesOrderID
UPDATE SalesOrder SET IsActive = 0 WHERE MemberID = @MemberID AND AutoShip = 2 AND SalesOrderID != @SalesOrderID

GO