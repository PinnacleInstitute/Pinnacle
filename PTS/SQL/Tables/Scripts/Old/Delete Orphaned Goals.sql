--Delete Orphaned Goals

--List all orphaned goals
select gl.goalname, g2.goalname 
from goal as gl
left outer join goal g2 on gl.parentid = g2.goalid
where gl.parentid!=0 and g2.goalname is null

--Delete all orphaned goals
delete gl
from goal as gl
left outer join goal g2 on gl.parentid = g2.goalid
where gl.parentid!=0 and g2.goalname is null

