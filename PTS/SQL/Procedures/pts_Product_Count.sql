EXEC [dbo].pts_CheckProc 'pts_Product_Count'
 GO

CREATE PROCEDURE [dbo].pts_Product_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Product AS pd (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO