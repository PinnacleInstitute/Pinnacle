DECLARE @cnt int, @Total int, @TotalMembers int, @TotalAgents int, @TotalCustomers int

select @Total = COUNT(*) from Member as me where CompanyID = 17
print 'Total Signups: ' + CAST(@Total AS VARCHAR(10))

select @cnt = COUNT(*) from Member as me where CompanyID = 17
and 0 = (select COUNT(*) from Payment where OwnerID = me.MemberID and Status = 3)
print 'Total Free Members: ' + CAST(@cnt AS VARCHAR(10)) + ' (' + CAST( (@cnt / CAST(@Total AS float)) * 100 AS VARCHAR(10)) + '%)'

select @TotalMembers = COUNT(*) from Member as me where CompanyID = 17
and 0 < (select COUNT(*) from Payment where OwnerID = me.MemberID and Status = 3)
print 'Total Paid Members: ' + CAST(@TotalMembers AS VARCHAR(10)) + ' (' + CAST( (@TotalMembers / CAST(@Total AS float)) * 100 AS VARCHAR(10)) + '%)'

select @TotalCustomers = COUNT(*) from Member as me where CompanyID = 17 and Options2 like '%retail%'
and 0 < (select COUNT(*) from Payment where OwnerID = me.MemberID and Status = 3)
print '..... Total Customers: ' + CAST(@TotalCustomers AS VARCHAR(10)) + ' (' + CAST( (@TotalCustomers / CAST(@TotalMembers AS float)) * 100 AS VARCHAR(10)) + '%)'

select @TotalAgents = COUNT(*) from Member as me where CompanyID = 17 and Options2 not like '%retail%'
and 0 < (select COUNT(*) from Payment where OwnerID = me.MemberID and Status = 3)
print '..... Total Agents: ' + CAST(@TotalAgents AS VARCHAR(10)) + ' (' + CAST( (@TotalAgents / CAST(@TotalMembers AS float)) * 100 AS VARCHAR(10)) + '%)'

select @cnt = COUNT(*) from Member as me where CompanyID = 17 and Options2 not like '%retail%'
and 0 < (select COUNT(*) from Payment where OwnerID = me.MemberID and Status = 3)
and 0 < (select COUNT(*) from Member where ReferralID = me.MemberID)
print '.......... Agents with Referrals: ' + CAST(@cnt AS VARCHAR(10)) + ' (' + CAST( (@cnt / CAST(@TotalAgents AS float)) * 100 AS VARCHAR(10)) + '%)'

select @cnt = COUNT(*) from Member as me where CompanyID = 17 and Options2 not like '%retail%'
and 0 < (select COUNT(*) from Payment where OwnerID = me.MemberID and Status = 3)
and 0 = (select COUNT(*) from Member where ReferralID = me.MemberID)
print '.......... Agents with No Referrals: ' + CAST(@cnt AS VARCHAR(10)) + ' (' + CAST( (@cnt / CAST(@TotalAgents AS float)) * 100 AS VARCHAR(10)) + '%)'


