EXEC [dbo].pts_CheckProc 'pts_Credit_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Credit_Fetch ( 
   @CreditID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @CreditDate datetime OUTPUT,
   @CreditType int OUTPUT,
   @Status int OUTPUT,
   @Total money OUTPUT,
   @Used money OUTPUT,
   @Balance money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = cr.CompanyID ,
   @MemberID = cr.MemberID ,
   @CreditDate = cr.CreditDate ,
   @CreditType = cr.CreditType ,
   @Status = cr.Status ,
   @Total = cr.Total ,
   @Used = cr.Used ,
   @Balance = cr.Balance
FROM Credit AS cr (NOLOCK)
WHERE cr.CreditID = @CreditID

GO