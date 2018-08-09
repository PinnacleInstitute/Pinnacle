EXEC [dbo].pts_CheckProc 'pts_Msg_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Msg_Delete ( 
   @MsgID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mg
FROM Msg AS mg
WHERE mg.MsgID = @MsgID

GO