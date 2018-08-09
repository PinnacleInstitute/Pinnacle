EXEC [dbo].pts_CheckProc 'pts_Credit_Add'
 GO

CREATE PROCEDURE [dbo].pts_Credit_Add ( 
   @CreditID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Credit (
            CompanyID , 
            MemberID , 
            CreditDate , 
            CreditType , 
            Status , 
            Total , 
            Used , 
            Balance
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @CreditDate ,
            @CreditType ,
            @Status ,
            @Total ,
            @Used ,
            @Balance            )

SET @mNewID = @@IDENTITY

SET @CreditID = @mNewID

GO