EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_Count'
 GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM AssessQuestion AS asq (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO