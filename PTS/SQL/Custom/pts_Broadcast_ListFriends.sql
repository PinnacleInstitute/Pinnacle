EXEC [dbo].pts_CheckProc 'pts_Broadcast_ListFriends'
GO

--EXEC pts_Broadcast_ListFriends 1, 0

CREATE PROCEDURE [dbo].pts_Broadcast_ListFriends
   @MemberID int ,
   @FriendGroupID int
AS

SET NOCOUNT ON

--Get All Friends
IF @FriendGroupID = 0
BEGIN
	SELECT FriendID 'BroadcastID', NameFirst, NameLast, Email
	FROM Friend (NOLOCK)
	WHERE MemberID = @MemberID AND Status = 2
END
ELSE
BEGIN
	SELECT FriendID 'BroadcastID', NameFirst, NameLast, Email
	FROM Friend (NOLOCK)
	WHERE MemberID = @MemberID AND FriendGroupID = @FriendGroupID AND Status = 2
END

GO