EXEC [dbo].pts_CheckProc 'pts_Domain_List'
GO

CREATE PROCEDURE [dbo].pts_Domain_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      dom.DomainID, 
         dom.CompanyID, 
         dom.MemberID, 
         dom.DomainName
FROM Domain AS dom (NOLOCK)
WHERE (dom.CompanyID = @CompanyID)

ORDER BY   dom.DomainName

GO