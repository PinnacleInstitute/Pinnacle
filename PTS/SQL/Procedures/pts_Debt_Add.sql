EXEC [dbo].pts_CheckProc 'pts_Debt_Add'
 GO

CREATE PROCEDURE [dbo].pts_Debt_Add ( 
   @DebtID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Debt (
            MemberID , 
            DebtType , 
            DebtName , 
            Balance , 
            Payment , 
            MinPayment , 
            IntRate , 
            IntPaid , 
            MonthsPaid , 
            IsActive , 
            IsConsolidate
            )
VALUES (
            @MemberID ,
            @DebtType ,
            @DebtName ,
            @Balance ,
            @Payment ,
            @MinPayment ,
            @IntRate ,
            @IntPaid ,
            @MonthsPaid ,
            @IsActive ,
            @IsConsolidate            )

SET @mNewID = @@IDENTITY

SET @DebtID = @mNewID

GO