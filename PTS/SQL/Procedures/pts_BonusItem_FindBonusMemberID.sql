EXEC [dbo].pts_CheckProc 'pts_BonusItem_FindBonusMemberID'
 GO

CREATE PROCEDURE [dbo].pts_BonusItem_FindBonusMemberID ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @MemberBonusID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(bo.MemberID, '') + dbo.wtfn_FormatNumber(bi.BonusItemID, 10) 'BookMark' ,
            bi.BonusItemID 'BonusItemID' ,
            bi.BonusID 'BonusID' ,
            bi.CompanyID 'CompanyID' ,
            bi.MemberID 'MemberID' ,
            bi.MemberBonusID 'MemberBonusID' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'BonusMemberName' ,
            bo.MemberID 'BonusMemberID' ,
            ct.CommTypeName 'CommTypeName' ,
            bi.CommType 'CommType' ,
            bi.Amount 'Amount' ,
            bi.Reference 'Reference'
FROM BonusItem AS bi (NOLOCK)
LEFT OUTER JOIN Bonus AS bo (NOLOCK) ON (bi.BonusID = bo.BonusID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (bo.MemberID = me.MemberID)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (bi.CompanyID = ct.CompanyID AND bi.CommType = ct.CommTypeNo)
WHERE ISNULL(bo.MemberID, '') LIKE @SearchText + '%'
AND ISNULL(bo.MemberID, '') + dbo.wtfn_FormatNumber(bi.BonusItemID, 10) >= @BookMark
AND         (bi.MemberBonusID = @MemberBonusID)
ORDER BY 'Bookmark'

GO