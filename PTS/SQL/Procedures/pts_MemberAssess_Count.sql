EXEC [dbo].pts_CheckProc 'pts_MemberAssess_Count'
 GO

CREATE PROCEDURE [dbo].pts_MemberAssess_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM MemberAssess AS ma (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO