-- ************************************
-- Redo the Bonus Run
-- ************************************

DECLARE @CompanyID int, @RunDate datetime
SET @CompanyID = 8
SET @RunDate = '11/7/13'

---- Reset payments to be reprocessed 
--SELECT * FROM Payment WHERE CompanyID = @CompanyID AND CommDate > @RunDate
UPDATE Payment SET CommStatus = 1, CommDate = 0 WHERE CompanyID = @CompanyID AND CommDate > @RunDate

---- Delete Commission records for this bonus run
--SELECT * FROM Commission WHERE CompanyID = @CompanyID AND commdate > @RunDate 
DELETE Commission WHERE CompanyID = @CompanyID AND commdate > @RunDate 

-- Delete Payouts records for this bonus run
--SELECT * FROM Payout where CompanyID = @CompanyID AND PayDate = @RunDate
DELETE Payout where CompanyID = @CompanyID AND PayDate = @RunDate


-- ***********************************************
--SELECT * FROM Payout order by PayoutID desc
--DELETE Payout where PayoutID >= 1685

--select * 
--update co set Status = 1, PayoutID = 0 
--from Commission as co
--left outer join Payout as pa on co.PayoutID = pa.PayoutID
--where pa.payoutid is null
