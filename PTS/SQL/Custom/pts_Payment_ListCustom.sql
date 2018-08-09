EXEC [dbo].pts_CheckProc 'pts_Payment_ListCustom'
GO

--EXEC pts_Payment_ListCustom -1, 0, 0, 1, 0, 0, ''

CREATE PROCEDURE [dbo].pts_Payment_ListCustom
   @CompanyID int ,
   @OwnerType int ,
   @OwnerID int ,
   @Status int ,
   @PayType int ,
   @PayDate datetime ,
   @Notes nvarchar (500)
AS

SET NOCOUNT ON

-- Get Merchant Cash Orders
IF @Status = 1
BEGIN
	SELECT   pa.PaymentID, 
			 pa.PayDate, 
			 pa.Amount, 
			 pa.Total, 
			 pa.Credit, 
			 pa.Retail, 
			 pa.Commission, 
			 pa.Status, 
			 pa.PayType, 
			 CAST(pa.ProductID AS VARCHAR(100)) 'Purpose', 
			 co.NameFirst + ' ' + co.NameLast 'Description', 
			 st.StaffName 'Notes'
	FROM Payment AS pa
	LEFT OUTER JOIN Consumer AS co ON pa.OwnerID = co.ConsumerID 
	LEFT OUTER JOIN Staff AS st ON pa.BillingID = st.StaffID 
	WHERE pa.CompanyID = @CompanyID AND pa.PayType = 7 AND pa.Status = 1
	ORDER BY pa.PayDate DESC
END

GO