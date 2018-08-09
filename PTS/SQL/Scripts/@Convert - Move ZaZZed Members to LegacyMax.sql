-- Move All ZaZZed members to Legacy Max

-- Update Member Titles
UPDATE Member SET Title = -2 WHERE CompanyID = 9 AND Title = 1
UPDATE Member SET Title = -2 WHERE CompanyID = 9 AND Title = 2
UPDATE Member SET Title = -3 WHERE CompanyID = 9 AND Title = 3
UPDATE Member SET Title = -4 WHERE CompanyID = 9 AND Title = 4
UPDATE Member SET Title = -4 WHERE CompanyID = 9 AND Title = 5
UPDATE Member SET Title = -5 WHERE CompanyID = 9 AND Title = 6
UPDATE Member SET Title = -6 WHERE CompanyID = 9 AND Title = 7
UPDATE Member SET Title = -7 WHERE CompanyID = 9 AND Title = 8
UPDATE Member SET Title = -8 WHERE CompanyID = 9 AND Title = 9
UPDATE Member SET Title = -9 WHERE CompanyID = 9 AND Title = 10
UPDATE Member SET Title = -10 WHERE CompanyID = 9 AND Title = 11
UPDATE Member SET Title = ABS(Title) WHERE CompanyID = 9

-- Upddate Member Coded Teams
--select dl.Line, dl.Line-1 
update dl set Line = Line - 1
from Downline AS dl
JOIN Member AS me ON dl.ParentID = me.MemberID
WHERE me.CompanyID = 9  

-- Update Member Status (save old status in Role
UPDATE Member SET Role = CAST(Status AS VARCHAR(2)) WHERE CompanyID = 9
UPDATE Member SET Status = 2, Level = 3 WHERE CompanyID = 9

-- Update Member Company
UPDATE Member SET CompanyID = 14 WHERE CompanyID = 9
