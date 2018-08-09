EXEC [dbo].pts_CheckProc 'pts_BonusItem_ListBonus'
GO

CREATE PROCEDURE [dbo].pts_BonusItem_ListBonus
   @BonusID int
AS

SET NOCOUNT ON

SELECT   bi.BonusItemID, 
         ct.CommTypeName AS 'CommTypeName', 
         LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) AS 'BonusMemberName', 
         bi.Amount, 
         bi.Reference
FROM BonusItem AS bi (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (bi.MemberID = me.MemberID)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (bi.CompanyID = ct.CompanyID AND bi.CommType = ct.CommTypeNo)
WHERE (bi.BonusID = @BonusID)

ORDER BY   bi.CommType

GO