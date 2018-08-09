SELECT namelast, email, count(*) 'Count'
FROM Member
GROUP BY namelast, email
HAVING Count(*) > 1 