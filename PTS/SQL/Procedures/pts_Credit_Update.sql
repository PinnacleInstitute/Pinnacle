EXEC [dbo].pts_CheckProc 'pts_Credit_Update'
 GO

CREATE PROCEDURE [dbo].pts_Credit_Update ( 
   @CreditID int,
   @CompanyID int,
   @MemberID int,
   @CreditDate datetime,
   @CreditType int,
   @Status int,
   @Total money,
   @Used money,
   @Balance money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cr
SET cr.CompanyID = @CompanyID ,
   cr.MemberID = @MemberID ,
   cr.CreditDate = @CreditDate ,
   cr.CreditType = @CreditType ,
   cr.Status = @Status ,
   cr.Total = @Total ,
   cr.Used = @Used ,
   cr.Balance = @Balance
FROM Credit AS cr
WHERE cr.CreditID = @CreditID

GO