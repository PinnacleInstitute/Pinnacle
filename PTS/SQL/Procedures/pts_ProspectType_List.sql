EXEC [dbo].pts_CheckProc 'pts_ProspectType_List'
GO

CREATE PROCEDURE [dbo].pts_ProspectType_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      pt.ProspectTypeID, 
         pt.ProspectTypeName, 
         pt.Seq
FROM ProspectType AS pt (NOLOCK)
WHERE (pt.CompanyID = @CompanyID)

ORDER BY   pt.Seq

GO