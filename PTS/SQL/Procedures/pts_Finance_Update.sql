EXEC [dbo].pts_CheckProc 'pts_Finance_Update'
 GO

CREATE PROCEDURE [dbo].pts_Finance_Update ( 
   @FinanceID int,
   @MemberID int,
   @Payoff int,
   @Payment money,
   @Savings int,
   @StartDate datetime,
   @ROI money,
   @SavingsRate money,
   @IsMinPayment bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE fi
SET fi.MemberID = @MemberID ,
   fi.Payoff = @Payoff ,
   fi.Payment = @Payment ,
   fi.Savings = @Savings ,
   fi.StartDate = @StartDate ,
   fi.ROI = @ROI ,
   fi.SavingsRate = @SavingsRate ,
   fi.IsMinPayment = @IsMinPayment
FROM Finance AS fi
WHERE fi.FinanceID = @FinanceID

GO