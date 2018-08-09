EXEC [dbo].pts_CheckProc 'pts_Payment_ListMemberPayments'
GO

--EXEC pts_Payment_ListMemberPayments 86982
--select * from payment where ownertype=52
--select * from salesorder
--update payment set ownerid = 84 where paymentid in (1495, 1496, 1623)

CREATE PROCEDURE [dbo].pts_Payment_ListMemberPayments
   @OwnerID int
AS

SET NOCOUNT ON

DECLARE @MemberID int
SET @MemberID = @OwnerID

SELECT pa.PayType, pa.Description, MIN(pa.PaymentID) 'PaymentID'
FROM Payment AS pa (NOLOCK)
JOIN SalesOrder AS so ON so.SalesOrderID = pa.OwnerID AND pa.OwnerType = 52
WHERE so.MemberID = @MemberID
AND (pa.Status <> 4) AND (pa.PayType >= 1) AND (pa.PayType <= 6) AND pa.Notes NOT LIKE '%NOREUSE%'
GROUP BY pa.PayType, pa.Description
ORDER BY MIN(pa.PaymentID) DESC
 
GO