EXEC [dbo].pts_CheckProc 'pts_Bonus_Add'
 GO

CREATE PROCEDURE [dbo].pts_Bonus_Add ( 
   @BonusID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @BonusDate datetime,
   @Title int,
   @BV money,
   @QV money,
   @Total money,
   @PaidDate datetime,
   @Reference varchar (20),
   @IsPrivate bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Bonus (
            CompanyID , 
            MemberID , 
            BonusDate , 
            Title , 
            BV , 
            QV , 
            Total , 
            PaidDate , 
            Reference , 
            IsPrivate
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @BonusDate ,
            @Title ,
            @BV ,
            @QV ,
            @Total ,
            @PaidDate ,
            @Reference ,
            @IsPrivate            )

SET @mNewID = @@IDENTITY

SET @BonusID = @mNewID

GO