UPDATE Attachment SET Status = 3 WHERE ParentType <> 28
UPDATE Attachment SET Status = 1 WHERE ParentType = 28

INSERT INTO AttachmentFT ( AttachmentID, FT ) 
SELECT AttachmentID, AttachName + ' ' + Description FROM Attachment WHERE ParentType = 28 AND Status = 1 

--select * from attachmentft
--select * from attachment where attachmentid in (26,27)

--select * from org where orgid=13
