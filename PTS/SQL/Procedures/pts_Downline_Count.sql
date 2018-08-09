EXEC [dbo].pts_CheckProc 'pts_Downline_Count'
 GO

CREATE PROCEDURE [dbo].pts_Downline_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Downline AS dl (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO