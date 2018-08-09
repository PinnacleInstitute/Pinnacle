EXEC [dbo].pts_CheckProc 'pts_BonusItem_GetMemberBonusID'
GO

CREATE PROCEDURE [dbo].pts_BonusItem_GetMemberBonusID
   @BonusItemID int ,
   @MemberBonusID int OUTPUT
AS

SET NOCOUNT ON

SELECT @MemberBonusID = MemberBonusID FROM BonusItem WHERE BonusItemID = @BonusItemID

GO

