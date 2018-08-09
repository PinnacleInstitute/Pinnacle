EXEC [dbo].pts_CheckProc 'pts_Domain_FetchDomain'
GO

CREATE PROCEDURE [dbo].pts_Domain_FetchDomain
   @DomainName nvarchar (40) ,
   @UserID int ,
   @DomainID int OUTPUT ,
   @CompanyID int OUTPUT
AS

DECLARE @mDomainID int, 
         @mCompanyID int

SET NOCOUNT ON

SELECT      @mDomainID = dom.DomainID, 
         @mCompanyID = dom.CompanyID
FROM Domain AS dom (NOLOCK)
WHERE (dom.DomainName = @DomainName)


SET @DomainID = ISNULL(@mDomainID, 0)
SET @CompanyID = ISNULL(@mCompanyID, 0)
GO