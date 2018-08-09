-- Set GCR Token
declare @Token varchar(20), @MemberID int
-- -----------------------------
set @Token = 'a7d71be264dd98e2'
set @MemberID = 24311
-- -----------------------------
update Member set Reference = LEFT(@Token,15), Referral = RIGHT(@Token,1) where MemberID = @MemberID

select Reference, referral from Member where memberid = @MemberID


