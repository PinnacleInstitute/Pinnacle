EXEC [dbo].pts_CheckProc 'pts_Msg_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Msg_Fetch ( 
   @MsgID int,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @AuthUserID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @UserName nvarchar (62) OUTPUT,
   @MsgDate datetime OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @Message nvarchar (2000) OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OwnerType = mg.OwnerType ,
   @OwnerID = mg.OwnerID ,
   @AuthUserID = mg.AuthUserID ,
   @NameLast = au.NameLast ,
   @NameFirst = au.NameFirst ,
   @UserName = LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) ,
   @MsgDate = mg.MsgDate ,
   @Subject = mg.Subject ,
   @Message = mg.Message ,
   @Status = mg.Status
FROM Msg AS mg (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (mg.AuthUserID = au.AuthUserID)
WHERE mg.MsgID = @MsgID

GO