EXEC [dbo].pts_CheckProc 'pts_MemberContest_Add'
GO
--DECLARE @ID int EXEC pts_MemberContest_Add 12, 6708, @ID output print @ID
--select * from membercontest

CREATE PROCEDURE [dbo].pts_MemberContest_Add
   @ContestID int ,
   @MemberID int ,
   @Result int OUTPUT
AS
-- Returns 0 if no open contest, otherwise MemberContestID

SET NOCOUNT ON
DECLARE @ID int

SET @Result = 0
--Check if the Contest exists and is open
SELECT @Result = ContestID FROM Contest WHERE ContestID = @ContestID AND Status = 2

IF @Result > 0 
BEGIN
	SET @Result = 0
	SELECT @Result = MemberContestID FROM MemberContest WHERE ContestID = @ContestID AND MemberID = @MemberID

	IF @Result = 0 
	BEGIN
		INSERT INTO MemberContest ( ContestID, MemberID ) VALUES ( @ContestID, @MemberID )
		SET @Result = @@IDENTITY
	END
END
GO