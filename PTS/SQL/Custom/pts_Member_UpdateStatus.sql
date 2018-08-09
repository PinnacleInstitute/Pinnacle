EXEC [dbo].pts_CheckProc 'pts_Member_UpdateStatus'
GO

CREATE PROCEDURE [dbo].pts_Member_UpdateStatus
AS
 
SET NOCOUNT ON

--Change Member Status if ChangeDate is specified and we'vre reached it
UPDATE Member SET Status = StatusChange, Level = LevelChange 
WHERE StatusDate > 0 AND DATEDIFF(day, StatusDate, GETDATE()) >= 0

--Set End Date for inactivated members 
UPDATE Member SET EndDate = GETDATE()
WHERE StatusDate > 0 AND DATEDIFF(day, StatusDate, GETDATE()) >= 0 AND Status >= 5

--Clear ChangeDate and ChangeStatus 
UPDATE Member SET StatusChange = 0, LevelChange = 0, StatusDate = 0
WHERE StatusDate > 0 AND DATEDIFF(day, StatusDate, GETDATE()) >= 0

--Update Member from trial to active if bill member and we have billing info and the trial period has expired
UPDATE Member SET Status = 1 
WHERE Status = 2 AND Billing = 3 AND BillingID != 0 AND DATEADD(day, TrialDays, EnrollDate) < GETDATE()

--Update Member from trial to active if bill company and the trial period has expired
UPDATE Member SET Status = 1 
WHERE Status = 2 AND Billing = 2 AND DATEADD(day, TrialDays, EnrollDate) < GETDATE()

--Inactivate Member if bill member and and we don't have billing info and trial period has expired
UPDATE Member SET Status = 5 
WHERE Status = 2 AND Billing = 3 AND BillingID = 0 AND DATEADD(day, TrialDays, EnrollDate) < GETDATE()


GO
