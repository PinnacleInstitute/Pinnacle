EXEC [dbo].pts_CheckProc 'pts_Channel_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Channel_Delete ( 
   @ChannelID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ch
FROM Channel AS ch
WHERE ch.ChannelID = @ChannelID

GO