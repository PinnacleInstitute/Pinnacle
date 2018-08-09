EXEC [dbo].pts_CheckProc 'pts_Msg_Update'
 GO

CREATE PROCEDURE [dbo].pts_Msg_Update ( 
   @MsgID int,
   @OwnerType int,
   @OwnerID int,
   @AuthUserID int,
   @MsgDate datetime,
   @Subject nvarchar (80),
   @Message nvarchar (2000),
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mg
SET mg.OwnerType = @OwnerType ,
   mg.OwnerID = @OwnerID ,
   mg.AuthUserID = @AuthUserID ,
   mg.MsgDate = @MsgDate ,
   mg.Subject = @Subject ,
   mg.Message = @Message ,
   mg.Status = @Status
FROM Msg AS mg
WHERE mg.MsgID = @MsgID

GO