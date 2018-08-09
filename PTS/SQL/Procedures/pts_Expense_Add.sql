EXEC [dbo].pts_CheckProc 'pts_Expense_Add'
 GO

CREATE PROCEDURE [dbo].pts_Expense_Add ( 
   @ExpenseID int OUTPUT,
   @MemberID int,
   @ExpenseTypeID int,
   @ExpType int,
   @ExpDate datetime,
   @Total money,
   @Amount money,
   @MilesStart int,
   @MilesEnd int,
   @TotalMiles int,
   @Note1 nvarchar (50),
   @Note2 nvarchar (100),
   @Purpose nvarchar (200),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Expense (
            MemberID , 
            ExpenseTypeID , 
            ExpType , 
            ExpDate , 
            Total , 
            Amount , 
            MilesStart , 
            MilesEnd , 
            TotalMiles , 
            Note1 , 
            Note2 , 
            Purpose
            )
VALUES (
            @MemberID ,
            @ExpenseTypeID ,
            @ExpType ,
            @ExpDate ,
            @Total ,
            @Amount ,
            @MilesStart ,
            @MilesEnd ,
            @TotalMiles ,
            @Note1 ,
            @Note2 ,
            @Purpose            )

SET @mNewID = @@IDENTITY

SET @ExpenseID = @mNewID

GO