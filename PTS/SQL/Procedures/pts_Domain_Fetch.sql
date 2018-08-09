EXEC [dbo].pts_CheckProc 'pts_Domain_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Domain_Fetch ( 
   @DomainID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @DomainName nvarchar (40) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = dom.CompanyID ,
   @MemberID = dom.MemberID ,
   @DomainName = dom.DomainName
FROM Domain AS dom (NOLOCK)
WHERE dom.DomainID = @DomainID

GO