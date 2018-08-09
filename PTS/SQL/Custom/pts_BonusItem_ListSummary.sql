EXEC [dbo].pts_CheckProc 'pts_BonusItem_ListSummary'
GO

--EXEC pts_BonusItem_ListSummary 1

CREATE PROCEDURE [dbo].pts_BonusItem_ListSummary
   @MemberBonusID int
AS

SET NOCOUNT ON

SELECT bi.CommType AS 'CommType', 
       ct.CommTypeName AS 'CommTypeName', 
       MIN(bi.BonusItemID) AS 'BonusItemID', 
       SUM(bi.Amount) AS 'Amount'
FROM BonusItem AS bi (NOLOCK)
JOIN CommType AS ct (NOLOCK) ON (bi.CompanyID = ct.CompanyID AND bi.CommType = ct.CommTypeNo)
WHERE bi.MemberBonusID = @MemberBonusID
GROUP BY bi.CommType, ct.CommTypeName
ORDER BY bi.CommType

GO