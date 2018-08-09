-- initalize all paid dates before starting billing for the first time
DECLARE @Now datetime
SET @Now = GETDATE()
-- Set PaidDate to enrolldate + trialdays, if not yet set
UPDATE Member SET PaidDate = DATEADD(day,TrialDays, EnrollDate) WHERE PaidDate = 0
-- Set PaidDate to current month
UPDATE Member SET PaidDate = 
DATEADD(month, DATEDIFF(month,DATEADD(day,TrialDays,EnrollDate), @Now), DATEADD(day,TrialDays,EnrollDate)) 
WHERE PaidDate < @Now
-- Set PaidDate to previous month if greater than current date
UPDATE Member SET PaidDate = DATEADD(month,-1,PaidDate) WHERE PaidDate >= @Now

--SELECT EnrollDate, TrialDays, DATEADD(day, TrialDays, EnrollDate),PaidDate FROM Member
--update member set paiddate = 0
