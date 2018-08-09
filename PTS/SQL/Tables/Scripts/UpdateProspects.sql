--Update Propsect Columns 
--Rebuild Prospect Table (Indexes)
--Create SQL Job to Update Prospect Status

--Set all old Prospect companyIDs to Pinnacle Sales (#1)
UPDATE Prospect SET CompanyID = 1

--Update MemberID from AffiliateIDs
UPDATE pr
SET pr.memberid = af.memberid
from prospect as pr
join affiliate as af on pr.affiliateid = af.affiliateid

--Update Next Events
UPDATE Prospect SET NextEvent = 6 WHERE NextEvent = 1
UPDATE Prospect SET NextEvent = 1 WHERE NextEvent = 2
UPDATE Prospect SET NextEvent = 2 WHERE NextEvent = 4

--Create Fixed Statuses (SalesSteps)
SET IDENTITY_INSERT SalesStep ON
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 1, 'Suspect', -2 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 2, 'Set FA', -1 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 3, 'Fallback', -1000000 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 4, 'Closed', -1000002 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 5, 'Dead', -1000003 )
SET IDENTITY_INSERT SalesStep OFF

--Add Sales Campaign, Get SalesSteps
UPDATE Prospect SET SalesCampaignID = x
UPDATE Prospect SET Status = x WHERE Status = 4 --Step 1
UPDATE Prospect SET Status = x WHERE Status = 5 --Step 2
UPDATE Prospect SET Status = x WHERE Status = 6 --Step 3
UPDATE Prospect SET Status = 4 WHERE Status = 7 --Closed
UPDATE Prospect SET Status = 5 WHERE Status = 8 --Dead

--Add ProspectTypes, Get ProspectType IDs
UPDATE Prospect SET ProspectTypeID = x WHERE Status = 1 --Corporate
UPDATE Prospect SET ProspectTypeID = x WHERE Status = 2 --Agents
UPDATE Prospect SET ProspectTypeID = x WHERE Status = 3 --Franchise
UPDATE Prospect SET ProspectTypeID = x WHERE Status = 4 --Association
UPDATE Prospect SET ProspectTypeID = x WHERE Status = 5 --MLM
UPDATE Prospect SET ProspectTypeID = x WHERE Status = 6 --Personal

--Delete Prospect AffiliateID
