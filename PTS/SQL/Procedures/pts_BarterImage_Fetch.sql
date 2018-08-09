EXEC [dbo].pts_CheckProc 'pts_BarterImage_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BarterImage_Fetch ( 
   @BarterImageID int,
   @BarterAdID int OUTPUT,
   @Title varchar (100) OUTPUT,
   @Status int OUTPUT,
   @Seq int OUTPUT,
   @Ext varchar (5) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @BarterAdID = bai.BarterAdID ,
   @Title = bai.Title ,
   @Status = bai.Status ,
   @Seq = bai.Seq ,
   @Ext = bai.Ext
FROM BarterImage AS bai (NOLOCK)
WHERE bai.BarterImageID = @BarterImageID

GO