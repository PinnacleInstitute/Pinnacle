EXEC [dbo].pts_CheckProc 'pts_Debt_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Debt_Fetch ( 
   @DebtID int,
   @MemberID int OUTPUT,
   @DebtType int OUTPUT,
   @DebtName nvarchar (30) OUTPUT,
   @Balance money OUTPUT,
   @Payment money OUTPUT,
   @MinPayment money OUTPUT,
   @IntRate money OUTPUT,
   @IntPaid money OUTPUT,
   @MonthsPaid int OUTPUT,
   @IsActive bit OUTPUT,
   @IsConsolidate bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = de.MemberID ,
   @DebtType = de.DebtType ,
   @DebtName = de.DebtName ,
   @Balance = de.Balance ,
   @Payment = de.Payment ,
   @MinPayment = de.MinPayment ,
   @IntRate = de.IntRate ,
   @IntPaid = de.IntPaid ,
   @MonthsPaid = de.MonthsPaid ,
   @IsActive = de.IsActive ,
   @IsConsolidate = de.IsConsolidate
FROM Debt AS de (NOLOCK)
WHERE de.DebtID = @DebtID

GO