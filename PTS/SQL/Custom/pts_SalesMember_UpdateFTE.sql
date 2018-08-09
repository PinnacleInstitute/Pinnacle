EXEC [dbo].pts_CheckProc 'pts_SalesMember_UpdateFTE'
GO

CREATE PROCEDURE [dbo].pts_SalesMember_UpdateFTE
   @SalesMemberID int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON
SET @Status = 1

DECLARE @SalesArea1ID int, @SalesArea2ID int, @SalesArea3ID int

--Update Local Area population
SELECT @SalesArea3ID = SalesAreaID FROM SalesMember WHERE SalesMemberID = @SalesMemberID
UPDATE SalesArea SET FTE = (SELECT CAST(SUM(FTE) AS Money) / 100 FROM SalesMember WHERE SalesAreaID = @SalesArea3ID) 
WHERE SalesAreaID  = @SalesArea3ID

--Update Regional population
SELECT @SalesArea2ID = ParentID FROM SalesArea WHERE SalesAreaID = @SalesArea3ID
UPDATE SalesArea SET FTE = (SELECT SUM(FTE) FROM SalesArea WHERE ParentID = @SalesArea2ID) 
WHERE SalesAreaID  = @SalesArea2ID

--Update National population
SELECT @SalesArea1ID = ParentID FROM SalesArea WHERE SalesAreaID = @SalesArea2ID
UPDATE SalesArea SET FTE = (SELECT SUM(FTE) FROM SalesArea WHERE ParentID = @SalesArea1ID) 
WHERE SalesAreaID  = @SalesArea1ID

GO
