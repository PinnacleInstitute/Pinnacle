EXEC [dbo].pts_CheckProc 'pts_Msg_Add'
GO

CREATE PROCEDURE [dbo].pts_Msg_Add
   @MsgID int OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @AuthUserID int,
   @MsgDate datetime,
   @Subject nvarchar (80),
   @Message nvarchar (2000),
   @Status int,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO Msg (
            OwnerType , 
            OwnerID , 
            AuthUserID , 
            MsgDate , 
            Subject , 
            Message , 
            Status

            )
VALUES (
            @OwnerType ,
            @OwnerID ,
            @AuthUserID ,
            @MsgDate ,
            @Subject ,
            @Message ,
            @Status
            )

SET @mNewID = @@IDENTITY
SET @MsgID = @mNewID
IF ((@OwnerType = 04))
   BEGIN
   EXEC pts_Msg_SetMemberMsgs
      @OwnerID ,
      1

   END

GO