-- Script to adjust Binary Points
-- when moving someone in the binary

DECLARE @OldMemberID int, @NewMemberID int, @Amount money

-- Enter Old Binary Sponsor ID
SET @OldMemberID = 0

-- Enter New Binary Sponsor ID
SET @NewMemberID = 0

-- Enter Amount of Binary Points (50, 25)
SET @Amount = 50

-- Remove Binary Points from old Sponsor upline
EXEC pts_BinarySale_AddCustom @OldMemberID, 3, @Amount

-- Add Binary Points to new Sponsor upline
EXEC pts_BinarySale_AddCustom @NewMemberID, 1, @Amount

