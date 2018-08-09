EXEC [dbo].pts_CheckProc 'pts_Domain_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_Domain_EnumUserCompany
   @CompanyID int ,
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      dom.DomainID AS 'ID', 
         dom.DomainName AS 'Name'
FROM Domain AS dom (NOLOCK)
WHERE (dom.CompanyID = @CompanyID)
 AND ((dom.MemberID = 0)
 OR (dom.MemberID = @MemberID))

ORDER BY   dom.DomainName

GO