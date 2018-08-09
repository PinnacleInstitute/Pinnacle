EXEC [dbo].pts_CheckProc 'pts_BonusItem_ListType'
GO

CREATE PROCEDURE [dbo].pts_BonusItem_ListType
   @MemberBonusID int ,
   @CommType int
AS

SET NOCOUNT ON

SELECT   bi.BonusItemID, 
         ct.CommTypeName AS 'CommTypeName', 
         LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) AS 'BonusMemberName', 
         bi.Amount, 
         bi.Reference
FROM BonusItem AS bi (NOLOCK)
LEFT OUTER JOIN Bonus AS bo (NOLOCK) ON (bi.BonusID = bo.BonusID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (bo.MemberID = me.MemberID)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (bi.CompanyID = ct.CompanyID AND bi.CommType = ct.CommTypeNo)
WHERE bi.MemberBonusID = @MemberBonusID AND bi.CommType = @CommType
ORDER BY bi.Amount DESC


GO