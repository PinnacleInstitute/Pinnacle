EXEC [dbo].pts_CheckProc 'pts_BarterImage_List'
GO

CREATE PROCEDURE [dbo].pts_BarterImage_List
   @BarterAdID int
AS

SET NOCOUNT ON

SELECT      bai.BarterImageID, 
         bai.BarterAdID, 
         bai.Title, 
         bai.Status, 
         bai.Seq, 
         bai.Ext
FROM BarterImage AS bai (NOLOCK)
WHERE (bai.BarterAdID = @BarterAdID)
 AND (bai.Status = 1)

ORDER BY   bai.BarterAdID , bai.Seq , bai.BarterImageID

GO