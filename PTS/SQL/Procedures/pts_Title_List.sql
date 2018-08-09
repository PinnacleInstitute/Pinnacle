EXEC [dbo].pts_CheckProc 'pts_Title_List'
GO

CREATE PROCEDURE [dbo].pts_Title_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      ti.TitleID, 
         ti.TitleName, 
         ti.TitleNo
FROM Title AS ti (NOLOCK)
WHERE (ti.CompanyID = @CompanyID)

ORDER BY   ti.TitleNo

GO