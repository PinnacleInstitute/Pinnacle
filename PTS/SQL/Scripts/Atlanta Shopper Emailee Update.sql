-- ************************************************
-- Update Atlanta Email Lists
-- Inactivate Emailee if registered as a Consumer
-- ************************************************

--SELECT * 
UPDATE em SET Status = 2
FROM Emailee AS em
JOIN Consumer AS co ON em.Email = co.Email
where EmailListID >= 117 AND EmailListID <= 123 
and em.Status = 1


--select * from Emailee where EmailListID >= 117 AND EmailListID <= 123 and Status = 2

