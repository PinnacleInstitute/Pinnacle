EXEC [dbo].pts_CheckProc 'pts_Bonus_Update'
 GO

CREATE PROCEDURE [dbo].pts_Bonus_Update ( 
   @BonusID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bo
SET bo.CompanyID = @CompanyID ,
   bo.MemberID = @MemberID ,
   bo.BonusDate = @BonusDate ,
   bo.Title = @Title ,
   bo.BV = @BV ,
   bo.QV = @QV ,
   bo.Total = @Total ,
   bo.PaidDate = @PaidDate ,
   bo.Reference = @Reference ,
   bo.IsPrivate = @IsPrivate
FROM Bonus AS bo
WHERE bo.BonusID = @BonusID

GO