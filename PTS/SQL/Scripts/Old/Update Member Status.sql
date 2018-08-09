UPDATE Member SET IsRemoved = 1 WHERE Status = 5
UPDATE Member SET Status = Status + 1 WHERE Status > 2
UPDATE SurveyQuestion SET Status = 1
UPDATE AssessQuestion SET Status = 1

