EXEC [dbo].pts_CheckProc 'pts_Commission_ListRef'
GO

--EXEC pts_Commission_ListRef 20886

CREATE PROCEDURE [dbo].pts_Commission_ListRef
   @RefID int
AS

SET NOCOUNT ON

SELECT   co.CommissionID, 
         co.CommType, 
         ct.CommTypeName AS 'CommTypeName', 
         CASE
			 WHEN co.OwnerType = 4 THEN me.NameFirst + ' ' + me.NameLast + ' (#' + CAST(me.MemberID AS VARCHAR(10)) + ')'
			 WHEN co.OwnerType = 150 THEN mr.MerchantName + ' (#' + CAST(mr.MerchantID AS VARCHAR(10)) + ')'
			 ELSE ''
	     END AS 'Notes',
         co.Description, 
         co.CommDate, 
         co.Total
FROM Commission AS co (NOLOCK)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (co.CompanyID = ct.CompanyID AND co.CommType = ct.CommTypeNo)
LEFT OUTER JOIN Member AS me ON co.OwnerID = me.MemberID AND co.OwnerType = 4
LEFT OUTER JOIN Merchant AS mr ON co.OwnerID = mr.MerchantID AND co.OwnerType = 150
WHERE (co.RefID = @RefID)
ORDER BY co.CommType, co.CommissionID


GO