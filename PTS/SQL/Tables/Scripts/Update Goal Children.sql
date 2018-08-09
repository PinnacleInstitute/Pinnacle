UPDATE g Set g.Children = (SELECT COUNT(GoalID) FROM Goal WHERE ParentID = g.GoalID) FROM Goal AS g 
