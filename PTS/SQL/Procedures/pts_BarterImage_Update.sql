EXEC [dbo].pts_CheckProc 'pts_BarterImage_Update'
 GO

CREATE PROCEDURE [dbo].pts_BarterImage_Update ( 
   @BarterImageID int,
   @BarterAdID int,
   @Title varchar (100),
   @Status int,
   @Seq int,
   @Ext varchar (5),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bai
SET bai.BarterAdID = @BarterAdID ,
   bai.Title = @Title ,
   bai.Status = @Status ,
   bai.Seq = @Seq ,
   bai.Ext = @Ext
FROM BarterImage AS bai
WHERE bai.BarterImageID = @BarterImageID

GO