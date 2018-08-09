EXEC [dbo].pts_CheckProc 'pts_Email_EnumUserProspect'
GO

CREATE PROCEDURE [dbo].pts_Email_EnumUserProspect
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ema.EmailID AS 'ID', 
         ema.EmailName AS 'Name'
FROM Email AS ema (NOLOCK)
WHERE (ema.CompanyID = @CompanyID)
 AND (ema.Status > 1)
 AND (ema.Status < 4)
 AND (ema.IsSalesStep <> 0)

ORDER BY   ema.EmailName

GO