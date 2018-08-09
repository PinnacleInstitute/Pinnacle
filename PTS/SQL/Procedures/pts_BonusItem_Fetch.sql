EXEC [dbo].pts_CheckProc 'pts_BonusItem_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BonusItem_Fetch ( 
   @BonusItemID int,
   @BonusID int OUTPUT,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @MemberBonusID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @BonusMemberName nvarchar (62) OUTPUT,
   @BonusMemberID nvarchar (40) OUTPUT,
   @CommTypeName nvarchar (40) OUTPUT,
   @CommType int OUTPUT,
   @Amount money OUTPUT,
   @Reference varchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @BonusID = bi.BonusID ,
   @CompanyID = bi.CompanyID ,
   @MemberID = bi.MemberID ,
   @MemberBonusID = bi.MemberBonusID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @BonusMemberName = LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) ,
   @BonusMemberID = bo.MemberID ,
   @CommTypeName = ct.CommTypeName ,
   @CommType = bi.CommType ,
   @Amount = bi.Amount ,
   @Reference = bi.Reference
FROM BonusItem AS bi (NOLOCK)
LEFT OUTER JOIN Bonus AS bo (NOLOCK) ON (bi.BonusID = bo.BonusID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (bo.MemberID = me.MemberID)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (bi.CompanyID = ct.CompanyID AND bi.CommType = ct.CommTypeNo)
WHERE bi.BonusItemID = @BonusItemID

GO