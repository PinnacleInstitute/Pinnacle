EXEC [dbo].pts_CheckProc 'pts_Domain_Update'
 GO

CREATE PROCEDURE [dbo].pts_Domain_Update ( 
   @DomainID int,
   @CompanyID int,
   @MemberID int,
   @DomainName nvarchar (40),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE dom
SET dom.CompanyID = @CompanyID ,
   dom.MemberID = @MemberID ,
   dom.DomainName = @DomainName
FROM Domain AS dom
WHERE dom.DomainID = @DomainID

GO