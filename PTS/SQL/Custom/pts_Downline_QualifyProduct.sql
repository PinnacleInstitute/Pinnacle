EXEC [dbo].pts_CheckProc 'pts_Downline_QualifyProduct'
GO

CREATE PROCEDURE [dbo].pts_Downline_QualifyProduct
   @MemberID int , 
   @Product varchar(10) , 
   @ID int OUTPUT
AS

SET NOCOUNT ON
SET @ID = 0

SELECT TOP 1 @ID = SalesItemID FROM SalesItem AS si
JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN Product AS pr ON si.ProductID = pr.ProductID
WHERE so.MemberID = @MemberID AND pr.Code = @Product

GO
