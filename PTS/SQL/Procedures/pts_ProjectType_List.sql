EXEC [dbo].pts_CheckProc 'pts_ProjectType_List'
GO

CREATE PROCEDURE [dbo].pts_ProjectType_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      pjt.ProjectTypeID, 
         pjt.ProjectTypeName, 
         pjt.Seq
FROM ProjectType AS pjt (NOLOCK)
WHERE (pjt.CompanyID = @CompanyID)

ORDER BY   pjt.Seq

GO