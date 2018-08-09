EXEC [dbo].pts_CheckProc 'pts_Member_GetIsMsg'
GO

CREATE PROCEDURE [dbo].pts_Member_GetIsMsg
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT @Result = IsMsg FROM Member WHERE MemberID = @MemberID

GO