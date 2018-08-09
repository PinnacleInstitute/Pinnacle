select memberid, grp, groupid from member where grp <> ''
update member set grp = '123' where memberid=145
update member set groupid = CAST(grp as int) where grp <> ''


select leadcampaignid, grp, groupid from leadcampaign where grp <> ''
update leadcampaign set groupid = 82 where leadcampaignid = 10
update leadcampaign set groupid = 84 where leadcampaignid = 14


select salescampaignid, grp, groupid from salescampaign where grp <> ''
update salescampaign set groupid = 84 where salescampaignid = 7

