EXEC [dbo].pts_CheckProc 'pts_Project_Count'
 GO

CREATE PROCEDURE [dbo].pts_Project_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Project AS pj (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO