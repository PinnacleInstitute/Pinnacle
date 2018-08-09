EXEC [dbo].pts_CheckProc 'pts_Msg_SetMemberMsgs'
GO

CREATE PROCEDURE [dbo].pts_Msg_SetMemberMsgs
   @OwnerID int,
   @Num int
AS

SET NOCOUNT ON

UPDATE Member SET IsMsgs = @Num WHERE MemberID = @OwnerID

GO