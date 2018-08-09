select MiningDate, HASH, AVG(coins) from mining where miningdate >= '6/1/15' and miningdate <= '6/30/15'
group by Miningdate, HASH
order by HASH, miningdate


select Memberid, HASH, count(*)'Days' from mining where miningdate >= '6/1/15' and miningdate <= '6/30/15' group by Memberid, HASH order by memberid, HASH
select Memberid, HASH, count(*)'Days', COUNT(*) * 16 'Adjustment' from mining where miningdate >= '6/1/15' and miningdate <= '6/30/15' and HASH = 450 group by Memberid, HASH order by memberid, HASH
select Memberid, HASH, count(*)'Days', COUNT(*) * 36 'Adjustment' from mining where miningdate >= '6/1/15' and miningdate <= '6/30/15' and HASH = 1024 group by Memberid, HASH order by memberid, HASH
select Memberid, HASH, count(*)'Days', COUNT(*) * 127 'Adjustment' from mining where miningdate >= '6/1/15' and miningdate <= '6/30/15' and HASH = 3584 group by Memberid, HASH order by memberid, HASH
select Memberid, HASH, count(*)'Days', COUNT(*) * 436 'Adjustment' from mining where miningdate >= '6/1/15' and miningdate <= '6/30/15' and HASH = 12288 group by Memberid, HASH order by memberid, HASH


