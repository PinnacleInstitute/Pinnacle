--RUN This once to update status for the new "Suspended" Status.
-- 1 Active 
-- 2 Trial 
-- 3 Suspended 
-- 4 Inactive 
-- 5 Removed 

UPDATE Member SET Status = 5 WHERE Status = 4
UPDATE Member SET Status = 4 WHERE Status = 3
