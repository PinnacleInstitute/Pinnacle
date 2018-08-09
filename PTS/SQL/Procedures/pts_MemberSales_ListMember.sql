EXEC [dbo].pts_CheckProc 'pts_MemberSales_ListMember'
GO

CREATE PROCEDURE [dbo].pts_MemberSales_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      ms.MemberSalesID, 
         ms.CompanyID, 
         ms.SalesDate, 
         ms.Title, 
         ti.TitleName AS 'TitleName', 
         ms.PV, 
         ms.GV, 
         ms.PV2, 
         ms.GV2
FROM MemberSales AS ms (NOLOCK)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (ms.CompanyID = ti.CompanyID and ms.Title = ti.TitleNo)
WHERE (ms.MemberID = @MemberID)

ORDER BY   ms.SalesDate DESC

GO