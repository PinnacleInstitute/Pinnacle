EXEC [dbo].pts_CheckProc 'pts_BonusItem_Update'
GO

CREATE PROCEDURE [dbo].pts_BonusItem_Update
   @BonusItemID int,
   @BonusID int,
   @CompanyID int,
   @MemberID int,
   @MemberBonusID int,
   @CommType int,
   @Amount money,
   @Reference varchar (20),
   @UserID int
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE bi
SET bi.BonusID = @BonusID ,
   bi.CompanyID = @CompanyID ,
   bi.MemberID = @MemberID ,
   bi.MemberBonusID = @MemberBonusID ,
   bi.CommType = @CommType ,
   bi.Amount = @Amount ,
   bi.Reference = @Reference
FROM BonusItem AS bi
WHERE (bi.BonusItemID = @BonusItemID)


EXEC pts_Bonus_ComputeTotal
   @MemberBonusID

GO