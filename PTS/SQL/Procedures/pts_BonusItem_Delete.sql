EXEC [dbo].pts_CheckProc 'pts_BonusItem_Delete'
GO

CREATE PROCEDURE [dbo].pts_BonusItem_Delete
   @BonusItemID int ,
   @UserID int
AS

DECLARE @mMemberBonusID int

SET NOCOUNT ON

EXEC pts_BonusItem_GetMemberBonusID
   @BonusItemID ,
   @mMemberBonusID OUTPUT

DELETE bi
FROM BonusItem AS bi
WHERE (bi.BonusItemID = @BonusItemID)


IF ((@mMemberBonusID > 0))
   BEGIN
   EXEC pts_Bonus_ComputeTotal
      @mMemberBonusID

   END

GO