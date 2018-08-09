--SET IDENTITY_INSERT to ON.
SET IDENTITY_INSERT SalesStep ON

--Add the default sysadmin record
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 1, 'Created', -2 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 2, 'Set FA', -1 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 3, 'Fallback', -1000000 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 4, 'Closed', -1000002 )
INSERT INTO SalesStep (SalesStepID, SalesStepName, Seq) VALUES ( 5, 'Dead', -1000003 )

SET IDENTITY_INSERT SalesStep OFF
GO

