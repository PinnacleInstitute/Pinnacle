-- --------------------------------------------------------------------
-- Consolidate 2 members
-- --------------------------------------------------------------------
DECLARE @FromMemberID int, @ToMemberID int
SET @FromMemberID = 79121
SET @ToMemberID = 78772

UPDATE Member SET ReferralID = @ToMemberID WHERE ReferralID = @FromMemberID 
UPDATE Member SET SponsorID = @ToMemberID WHERE SponsorID = @FromMemberID 
UPDATE Member SET MentorID = @ToMemberID WHERE MentorID = @FromMemberID 

UPDATE Address SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE Bonus SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Calendar SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Commission SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE Event SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE Favorite SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Goal SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Lead SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE LeadLog SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Mail SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE MemberAssess SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE MemberNews SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE MemberTitle SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Msg SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE Note SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE Payment SET OwnerID = @ToMemberID WHERE OwnerType = 4 AND OwnerID = @FromMemberID
UPDATE Project SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE ProjectMember SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Prospect SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE SalesOrder SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Session SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Signature SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE Suggestion SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID
UPDATE SurveyAnswer SET MemberID = @ToMemberID WHERE MemberID = @FromMemberID

-- DELETE Member WHERE MemberID = @FromMemberID



