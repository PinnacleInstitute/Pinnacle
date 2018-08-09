EXEC [dbo].pts_CheckProc 'pts_Mail_ListProspect'
GO

CREATE PROCEDURE [dbo].pts_Mail_ListProspect
   @OwnerType int ,
   @ProspectID int
AS

SET NOCOUNT ON

SELECT      ml.MailID, 
         ml.Subject, 
         ml.MailDate
FROM Mail AS ml (NOLOCK)
WHERE (ml.OwnerType = @OwnerType)
 AND (ml.ProspectID = @ProspectID)

ORDER BY   ml.MailDate DESC

GO