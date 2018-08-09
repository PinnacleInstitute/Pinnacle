-- Populate Acticities (Metric Types)
DECLARE @CompanyID int
SET @CompanyID = 9

INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, '--- KEY RESULT ---',           1,  0, 0, 0, 0, '')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Signup New Customer',         10, 30, 1, 0, 0, 'Enroll a new customer.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Signup New Team Member',      15, 30, 1, 0, 0, 'Enroll a new team member.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, '.',                           20,  0, 0, 0, 0, '')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, '--- PERSONAL ACTIVITY ---',   21,  0, 0, 0, 0, '')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Show Personal Presentation',  35, 10, 0, 0, 1, 'Make a business presentation to a prospect.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Get 3rd Party Validation',    40,  5, 0, 0, 1, 'Call a leader during a presentation for a 3rd party validation.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Personal Followup',           45,  5, 0, 0, 1, 'Followup with a prospect after the presentation.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Attend Conference Call',      50,  5, 0, 0, 0, 'Attend a company or team conference call.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Schedule Presentation',       55,  5, 0, 0, 1, 'Schedule a business presentation with a prospect.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, '.',                           60,  0, 0, 0, 0, '')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, '--- LEADERSHIP ACTIVITY ---', 61,  0, 0, 0, 0, '')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Show Team Presentation',      65, 10, 0, 1, 1, 'Make a presentation for one or more team members.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'Do 3rd Party Validation',     70,  5, 0, 1, 1, 'Do a 3rd party validation for a team member.')
INSERT INTO MetricType (CompanyID, MetricTypeName, Seq, Pts, IsResult, IsLeader, IsQty, Description) VALUES (@CompanyID, 'New Member Training',         75, 10, 0, 1, 1, 'Train a new team member.')

