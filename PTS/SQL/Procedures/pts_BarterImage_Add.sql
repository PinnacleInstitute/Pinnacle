EXEC [dbo].pts_CheckProc 'pts_BarterImage_Add'
 GO

CREATE PROCEDURE [dbo].pts_BarterImage_Add ( 
   @BarterImageID int OUTPUT,
   @BarterAdID int,
   @Title varchar (100),
   @Status int,
   @Seq int,
   @Ext varchar (5),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO BarterImage (
            BarterAdID , 
            Title , 
            Status , 
            Seq , 
            Ext
            )
VALUES (
            @BarterAdID ,
            @Title ,
            @Status ,
            @Seq ,
            @Ext            )

SET @mNewID = @@IDENTITY

SET @BarterImageID = @mNewID

GO