EXEC [dbo].pts_CheckProc 'pts_Msg_Count'
 GO

CREATE PROCEDURE [dbo].pts_Msg_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Msg AS mg (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO