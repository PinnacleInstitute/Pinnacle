EXEC [dbo].pts_CheckProc 'pts_Msg_GetMemberMsgs'
GO

CREATE PROCEDURE [dbo].pts_Msg_GetMemberMsgs
   @OwnerID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT @Result = IsMsgs FROM Member WHERE MemberID = @OwnerID

GO