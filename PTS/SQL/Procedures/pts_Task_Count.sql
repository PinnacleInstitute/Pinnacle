EXEC [dbo].pts_CheckProc 'pts_Task_Count'
 GO

CREATE PROCEDURE [dbo].pts_Task_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Task AS ta (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO