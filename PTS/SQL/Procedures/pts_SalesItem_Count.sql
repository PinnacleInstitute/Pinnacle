EXEC [dbo].pts_CheckProc 'pts_SalesItem_Count'
 GO

CREATE PROCEDURE [dbo].pts_SalesItem_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM SalesItem AS si (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO