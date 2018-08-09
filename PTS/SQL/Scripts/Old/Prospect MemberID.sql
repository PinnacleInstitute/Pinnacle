UPDATE pr
SET pr.memberid = af.memberid
from prospect as pr
join affiliate as af on pr.affiliateid = af.affiliateid

