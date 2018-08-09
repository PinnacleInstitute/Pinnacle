EXEC [dbo].pts_CheckProc 'pts_Credit_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Credit_ListMember
   @CompanyID int ,
   @MemberID int
AS

SET NOCOUNT ON

SELECT      cr.CreditID, 
         cr.CreditDate, 
         cr.CreditType, 
         cr.Status, 
         cr.Total, 
         cr.Used, 
         cr.Balance
FROM Credit AS cr (NOLOCK)
WHERE (cr.CompanyID = @CompanyID)
 AND (cr.MemberID = @MemberID)
 AND (cr.Status = 2)

ORDER BY   cr.CreditDate DESC

GO