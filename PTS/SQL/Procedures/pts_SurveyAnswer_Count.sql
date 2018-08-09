EXEC [dbo].pts_CheckProc 'pts_SurveyAnswer_Count'
 GO

CREATE PROCEDURE [dbo].pts_SurveyAnswer_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM SurveyAnswer AS sa (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO