EXEC [dbo].pts_CheckProc 'pts_Mail_ListOwner'
GO

CREATE PROCEDURE [dbo].pts_Mail_ListOwner
   @OwnerType int ,
   @OwnerID int
AS

SET NOCOUNT ON

SELECT      ml.MailID, 
         ml.Subject, 
         ml.MailDate
FROM Mail AS ml (NOLOCK)
WHERE (ml.OwnerType = @OwnerType)
 AND (ml.OwnerID = @OwnerID)

ORDER BY   ml.MailDate DESC

GO