select so.OrderDate, so.SalesOrderid, si.Quantity, pr.ProductName, me.MemberID, me.NameFirst, me.NameLast, me.Email, me.options2 from SalesItem as si
join SalesOrder as so on si.SalesOrderID = so.SalesOrderID 
join Product as pr on si.ProductID = pr.ProductID
join Member as me on so.memberid = me.MemberID
where me.CompanyID = 9 and so.Status = 3
AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 52 AND OwnerID = so.SalesOrderID AND Status = 3 ) > 0
order by so.OrderDate, so.SalesOrderID



