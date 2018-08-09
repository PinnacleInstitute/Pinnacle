EXEC [dbo].pts_CheckProc 'pts_Member_ChangeStatus'
GO

CREATE PROCEDURE [dbo].pts_Member_ChangeStatus
AS
 
SET NOCOUNT ON

--Change Member Status if ChangeDate is specified and we'vre reached it
UPDATE Member SET Status = StatusChange 
WHERE StatusDate > 0 AND DATEDIFF(day, StatusDate, GETDATE()) >= 0

--Clear ChangeDate and ChangeStatus 
UPDATE Member SET StatusDate = 0, StatusChange = 0
WHERE StatusDate > 0 AND DATEDIFF(day, StatusDate, GETDATE()) >= 0

--Inactivate Member if trial period has expired
UPDATE Member SET Status = 5 
WHERE Status = 2 AND DATEADD(day, TrialDays, EnrollDate) < GETDATE()

GO
