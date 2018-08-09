EXEC [dbo].pts_CheckProc 'pts_AuthLog_ListAuthUser'
GO

CREATE PROCEDURE [dbo].pts_AuthLog_ListAuthUser
   @AuthUserID int
AS

SET NOCOUNT ON

SELECT      aul.AuthLogID, 
         aul.IP, 
         aul.LogDate, 
         aul.LastDate, 
         aul.Total, 
         aul.Status
FROM AuthLog AS aul (NOLOCK)
WHERE (aul.AuthUserID = @AuthUserID)

ORDER BY   aul.LogDate

GO