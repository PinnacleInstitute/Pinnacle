EXEC [dbo].pts_CheckProc 'pts_Channel_Count'
 GO

CREATE PROCEDURE [dbo].pts_Channel_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Channel AS ch (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO