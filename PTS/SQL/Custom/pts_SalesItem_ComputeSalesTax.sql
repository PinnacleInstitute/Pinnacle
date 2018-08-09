EXEC [dbo].pts_CheckProc 'pts_SalesItem_ComputeSalesTax'
 GO

CREATE PROCEDURE [dbo].pts_SalesItem_ComputeSalesTax ( 
      @SalesItemID int 
      )
AS

DECLARE @Price money, @OptionPrice money, @IsTaxable bit, @TaxRate money, @TaxAmount money, @Tax money

SELECT @Price = si.Price, @OptionPrice = si.OptionPrice, @IsTaxable = pr.IsTaxable, @TaxRate = pr.TaxRate, @TaxAmount = pr.Tax
FROM   SalesItem AS si (NOLOCK)
LEFT OUTER JOIN Product AS pr (NOLOCK) ON (si.ProductID = pr.ProductID)
WHERE  si.SalesItemID = @SalesItemID

IF @IsTaxable = 1
BEGIN
	IF @TaxAmount > 0
		SET @Tax = @TaxAmount + (@OptionPrice * @TaxRate)
	ELSE
		SET @Tax = (@Price + @OptionPrice) * @TaxRate

	IF @Tax < 0 SET @Tax = 0

	UPDATE SalesItem SET Tax = @Tax WHERE SalesItemID = @SalesItemID
END

GO
