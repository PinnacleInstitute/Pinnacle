EXEC [dbo].pts_CheckProc 'pts_Title_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_Title_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ti.TitleNo AS 'ID', 
         ti.TitleName AS 'Name'
FROM Title AS ti (NOLOCK)
WHERE (ti.CompanyID = @CompanyID)

ORDER BY   ti.TitleNo

GO