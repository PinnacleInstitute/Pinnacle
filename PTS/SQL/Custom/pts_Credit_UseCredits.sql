EXEC [dbo].pts_CheckProc 'pts_Credit_UseCredits'
GO

--DECLARE @Count int EXEC pts_Credit_UseCredits 14, 10819, 1, 1, @Count OUTPUT print @Count
--SELECT * FROM Credit where MemberID = 10819

CREATE PROCEDURE [dbo].pts_Credit_UseCredits
   @CompanyID int ,
   @MemberID int ,
   @CreditType int ,
   @Used money ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CreditID int
SET @Count = 0

SET @CreditID = 0
SELECT @CreditID = CreditID FROM Credit 
WHERE CompanyID = @CompanyID AND MemberID = @MemberID AND CreditType = @CreditType AND Status = 2 AND Balance >= @Used

IF @CreditID > 0
BEGIN
   UPDATE Credit SET Used = Used + @Used, Balance = Balance - @Used WHERE CreditID = @CreditID
END

GO
