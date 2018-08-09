EXEC [dbo].pts_CheckProc 'pts_Emailee_Count'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Emailee AS eme (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO