EXEC [dbo].pts_CheckProc 'pts_Debt_Update'
 GO

CREATE PROCEDURE [dbo].pts_Debt_Update ( 
   @DebtID int,
   @MemberID int,
   @DebtType int,
   @DebtName nvarchar (30),
   @Balance money,
   @Payment money,
   @MinPayment money,
   @IntRate money,
   @IntPaid money,
   @MonthsPaid int,
   @IsActive bit,
   @IsConsolidate bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE de
SET de.MemberID = @MemberID ,
   de.DebtType = @DebtType ,
   de.DebtName = @DebtName ,
   de.Balance = @Balance ,
   de.Payment = @Payment ,
   de.MinPayment = @MinPayment ,
   de.IntRate = @IntRate ,
   de.IntPaid = @IntPaid ,
   de.MonthsPaid = @MonthsPaid ,
   de.IsActive = @IsActive ,
   de.IsConsolidate = @IsConsolidate
FROM Debt AS de
WHERE de.DebtID = @DebtID

GO