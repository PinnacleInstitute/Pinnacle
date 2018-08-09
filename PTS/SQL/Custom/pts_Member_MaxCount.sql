EXEC [dbo].pts_CheckProc 'pts_Member_MaxCount'
GO

CREATE PROCEDURE [dbo].pts_Member_MaxCount
   @MasterID int ,
   @MaxMembers int OUTPUT
AS

SET NOCOUNT ON

SET @MaxMembers = 0

SELECT @MaxMembers = MaxMembers FROM Member WHERE MemberID = @MasterID

GO