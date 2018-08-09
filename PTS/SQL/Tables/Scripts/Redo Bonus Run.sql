-- ************************************
-- Redo the Bonus Run
-- ************************************

DECLARE @RunDate datetime
SET @RunDate = '8/28/12'

---- Reset payments to be reprocessed 
--SELECT * FROM Payment WHERE CommDate > @RunDate
--SELECT * FROM Payment WHERE CommDate > '8/27/12'
UPDATE Payment SET CommStatus = 1, CommDate = 0 WHERE CommDate > @RunDate

---- Delete Commission records for this bonus run
--SELECT * FROM Commission WHERE commdate > @RunDate 
DELETE Commission WHERE commdate > @RunDate 

-- Delete Payouts records for this bonus run
--SELECT * FROM Payout where PayDate = @RunDate
DELETE Payout where PayDate = @RunDate


-- ***********************************************
--SELECT * FROM Payout order by PayoutID desc
--DELETE Payout where PayoutID >= 1685

--select * 
--update co set Status = 1, PayoutID = 0 
--from Commission as co
--left outer join Payout as pa on co.PayoutID = pa.PayoutID
--where pa.payoutid is null
