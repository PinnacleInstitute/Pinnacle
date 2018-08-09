----------------------------------
-- CREATE EXECUTIVE MINING ORDERS
----------------------------------
--select * from payment where ownerid = 12046

DECLARE @MemberID int
--Sasa
SET @MemberID = 12556
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'9/1/15','9/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'10/1/15','10/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'11/1/15','11/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'12/1/15','12/1/15',91,'207',3,3)

--Ruben
SET @MemberID = 12561
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'9/1/15','9/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'10/1/15','10/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'11/1/15','11/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'12/1/15','12/1/15',91,'207',3,3)

--Lisa
SET @MemberID = 19469
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'9/1/15','9/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'10/1/15','10/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'11/1/15','11/1/15',91,'207',3,3)
INSERT INTO Payment ( CompanyID, OwnerType, OwnerID, PayDate, PaidDate, PayType, Purpose, [Status], CommStatus) VALUES ( 17,4,@MemberID,'12/1/15','12/1/15',91,'207',3,3)


 