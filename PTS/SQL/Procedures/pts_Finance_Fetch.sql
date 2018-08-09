EXEC [dbo].pts_CheckProc 'pts_Finance_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Finance_Fetch ( 
   @FinanceID int,
   @MemberID int OUTPUT,
   @Payoff int OUTPUT,
   @Payment money OUTPUT,
   @Savings int OUTPUT,
   @StartDate datetime OUTPUT,
   @ROI money OUTPUT,
   @SavingsRate money OUTPUT,
   @IsMinPayment bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = fi.MemberID ,
   @Payoff = fi.Payoff ,
   @Payment = fi.Payment ,
   @Savings = fi.Savings ,
   @StartDate = fi.StartDate ,
   @ROI = fi.ROI ,
   @SavingsRate = fi.SavingsRate ,
   @IsMinPayment = fi.IsMinPayment
FROM Finance AS fi (NOLOCK)
WHERE fi.FinanceID = @FinanceID

GO