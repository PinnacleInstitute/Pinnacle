EXEC [dbo].pts_CheckProc 'pts_ProjectType_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_ProjectType_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pjt.ProjectTypeID AS 'ID', 
         pjt.ProjectTypeName AS 'Name'
FROM ProjectType AS pjt (NOLOCK)
WHERE (pjt.CompanyID = @CompanyID)

ORDER BY   pjt.Seq

GO