EXEC [dbo].pts_CheckProc 'pts_Domain_Add'
 GO

CREATE PROCEDURE [dbo].pts_Domain_Add ( 
   @DomainID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @DomainName nvarchar (40),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Domain (
            CompanyID , 
            MemberID , 
            DomainName
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @DomainName            )

SET @mNewID = @@IDENTITY

SET @DomainID = @mNewID

GO