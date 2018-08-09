EXEC [dbo].pts_CheckProc 'pts_SalesZip_UpdatePopulation'
GO

CREATE PROCEDURE [dbo].pts_SalesZip_UpdatePopulation
   @SalesZipID int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON
SET @Status = 1

DECLARE @SalesArea1ID int, @SalesArea2ID int, @SalesArea3ID int

--Update Local Area population
SELECT @SalesArea3ID = SalesAreaID FROM SalesZip WHERE SalesZipID = @SalesZipID
UPDATE SalesArea SET Population = (SELECT SUM(Population) FROM SalesZip WHERE SalesAreaID = @SalesArea3ID) 
WHERE SalesAreaID  = @SalesArea3ID

--Update Regional population
SELECT @SalesArea2ID = ParentID FROM SalesArea WHERE SalesAreaID = @SalesArea3ID
UPDATE SalesArea SET Population = (SELECT SUM(Population) FROM SalesArea WHERE ParentID = @SalesArea2ID) 
WHERE SalesAreaID  = @SalesArea2ID

--Update National population
SELECT @SalesArea1ID = ParentID FROM SalesArea WHERE SalesAreaID = @SalesArea2ID
UPDATE SalesArea SET Population = (SELECT SUM(Population) FROM SalesArea WHERE ParentID = @SalesArea1ID) 
WHERE SalesAreaID  = @SalesArea1ID

GO