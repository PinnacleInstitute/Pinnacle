EXEC [dbo].pts_CheckProc 'pts_Emailee_ListStandard'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListStandard
   @EmailListID int
AS

SET NOCOUNT ON

SELECT      eme.EmaileeID, 
         eme.Email, 
         eme.FirstName, 
         eme.LastName, 
         eme.Data1, 
         eme.Data2, 
         eme.Data3, 
         eme.Data4, 
         eme.Data5
FROM Emailee AS eme (NOLOCK)
WHERE (eme.EmailListID = @EmailListID)
 AND (eme.Status = 1)

ORDER BY   eme.LastName

GO