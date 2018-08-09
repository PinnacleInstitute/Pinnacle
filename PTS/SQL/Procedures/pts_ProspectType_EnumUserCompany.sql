EXEC [dbo].pts_CheckProc 'pts_ProspectType_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_ProspectType_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pt.ProspectTypeID AS 'ID', 
         pt.ProspectTypeName AS 'Name'
FROM ProspectType AS pt (NOLOCK)
WHERE (pt.CompanyID = @CompanyID)

ORDER BY   pt.Seq

GO