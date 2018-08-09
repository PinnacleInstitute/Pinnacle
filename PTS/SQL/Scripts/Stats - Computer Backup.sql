-- ***************************
-- Computer Backup Stats
-- ***************************
DECLARE @FromDate datetime, @ToDate datetime
SET @FromDate = '5/22/12' 
SET @ToDate = '6/1/12' 
print '***************************'
print 'Computer Backup Stats      '
print 'from ' + CONVERT(varchar(20), @FromDate, 1) + ' to ' + CONVERT(varchar(20), @toDate, 1)
print '***************************'
print ''
DECLARE @ComputerTotal int, @ComputerYes int, @ComputerNo int 
select @ComputerTotal = COUNT(*) from Machine where Status = 2 and ActiveDate >= @FromDate and ActiveDate <= @ToDate
select @ComputerNo = COUNT(*) from Machine where Status = 2 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed = '0 B'
select @ComputerYes = COUNT(*) from Machine where Status = 2 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed <> '0 B'
print 'Total Computer Backups'
print '----------------------'
print 'Total Computers: ' + CAST(@ComputerTotal as varchar(10))
print 'Backup Computers: ' + CAST(@ComputerYes as varchar(10))
print 'Not Backup Computers: ' + CAST(@ComputerNo as varchar(10))
print 'Computer Backup Rate: ' + CAST(@ComputerYes/CAST(@ComputerTotal AS money) as varchar(10))
print ''

DECLARE @CustomerTotal int, @CustomerYes int, @CustomerNo int, @CustomerUpgrade int 
select @CustomerTotal = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 0 and ActiveDate >= @FromDate and ActiveDate <= @ToDate
select @CustomerNo = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 0 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed = '0 B'
select @CustomerYes = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 0 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed <> '0 B'
select @CustomerUpgrade = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 0 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and me.Status = 1 and BackupUsed <> '0 B'
print 'Total Customer Computer Backups'
print '-------------------------------'
print 'Total Customer Computers: ' + CAST(@CustomerTotal as varchar(10))
print 'Backup Customers: ' + CAST(@CustomerYes as varchar(10))
print 'Not Backup Customers: ' + CAST(@CustomerNo as varchar(10))
print 'Customer Backup Rate: ' + CAST(@CustomerYes/CAST(@CustomerTotal AS money) as varchar(10))
print 'Upgraded Customers: ' + CAST(@CustomerUpgrade as varchar(10))
print 'Customer Upgrade Rate: ' + CAST(@CustomerUpgrade/CAST(@CustomerYes AS money) as varchar(10))
print ''

DECLARE @ResellerTotal int, @ResellerYes int, @ResellerNo int 
select @ResellerTotal = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 1 and me.Title <= 1 and ActiveDate >= @FromDate and ActiveDate <= @ToDate
select @ResellerNo = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 1 and me.Title <= 1 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed = '0 B'
select @ResellerYes = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 1 and me.Title <= 1 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed <> '0 B'
print 'Total Reseller Computer Backups'
print '-------------------------------'
print 'Total Reseller Computers: ' + CAST(@ResellerTotal as varchar(10))
print 'Backup Resellers: ' + CAST(@ResellerYes as varchar(10))
print 'Not Backup Resellers: ' + CAST(@ResellerNo as varchar(10))
print 'Reseller Backup Rate: ' + CAST(@ResellerYes/CAST(@ResellerTotal AS money) as varchar(10))
print ''

DECLARE @AffiliateTotal int, @AffiliateYes int, @AffiliateNo int 
select @AffiliateTotal = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 1 and me.Title > 1 and ActiveDate >= @FromDate and ActiveDate <= @ToDate
select @AffiliateNo = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 1 and me.Title > 1 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed = '0 B'
select @AffiliateYes = COUNT(*) from Machine as ma join Member as me on ma.MemberID = me.Memberid
where ma.Status = 2 and me.Level = 1 and me.Title > 1 and ActiveDate >= @FromDate and ActiveDate <= @ToDate and BackupUsed <> '0 B'
print 'Total Affiliate Computer Backups'
print '--------------------------------'
print 'Total Affiliate Computers: ' + CAST(@AffiliateTotal as varchar(10))
print 'Backup Affiliates: ' + CAST(@AffiliateYes as varchar(10))
print 'Not Backup Affiliates: ' + CAST(@AffiliateNo as varchar(10))
print 'Affiliate Backup Rate: ' + CAST(@AffiliateYes/CAST(@AffiliateTotal AS money) as varchar(10))

