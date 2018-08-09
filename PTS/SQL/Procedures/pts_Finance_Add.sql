EXEC [dbo].pts_CheckProc 'pts_Finance_Add'
 GO

CREATE PROCEDURE [dbo].pts_Finance_Add ( 
   @FinanceID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Finance (
            MemberID , 
            Payoff , 
            Payment , 
            Savings , 
            StartDate , 
            ROI , 
            SavingsRate , 
            IsMinPayment
            )
VALUES (
            @MemberID ,
            @Payoff ,
            @Payment ,
            @Savings ,
            @StartDate ,
            @ROI ,
            @SavingsRate ,
            @IsMinPayment            )

SET @mNewID = @@IDENTITY

SET @FinanceID = @mNewID

GO