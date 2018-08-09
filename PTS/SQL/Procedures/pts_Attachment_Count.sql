EXEC [dbo].pts_CheckProc 'pts_Attachment_Count'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Attachment AS att (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO