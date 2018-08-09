EXEC [dbo].pts_CheckProc 'pts_Bonus_ComputeTotal'
 GO

CREATE PROCEDURE [dbo].pts_Bonus_ComputeTotal ( 
      @BonusID int 
      )
AS
DECLARE @Total money

SELECT @Total = ISNULL(SUM(Amount),0) FROM BonusItem WHERE MemberBonusID = @BonusID
UPDATE Bonus SET Total = @Total WHERE BonusID = @BonusID

GO
