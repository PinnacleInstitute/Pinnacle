EXEC [dbo].pts_CheckProc 'pts_Affiliate_Count'
 GO

CREATE PROCEDURE [dbo].pts_Affiliate_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Affiliate AS af (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO