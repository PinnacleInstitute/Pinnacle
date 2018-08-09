select distinct country from member
select distinct country from billing

update member set country = '224' where country = '' 
update member set country = '37' where country = 'Canada' 
update member set country = '76' where country = 'England' 
update member set country = '110' where country = 'Hong Kong' 
update member set country = '110' where country = 'Hong Kong SAR' 
update member set country = '100' where country = 'Israel' 
update member set country = '161' where country = 'Norway' 
update member set country = '191' where country = 'Singapore' 
update member set country = '76' where country = 'UK' 
update member set country = '224' where country = 'United States' 
update member set country = '224' where country = 'USA' 
update member set country = '224' where isnumeric(country) = 0

update billing set country = '224' where country = '''' 
update billing set country = '37' where country = 'Canada' 
update billing set country = '76' where country = 'England' 
update billing set country = '110' where country = 'Hong Kong' 
update billing set country = '110' where country = 'Hong Kong SAR' 
update billing set country = '100' where country = 'Israel' 
update billing set country = '161' where country = 'Norway' 
update billing set country = '191' where country = 'Singapore' 
update billing set country = '76' where country = 'UK' 
update billing set country = '224' where country = 'United States' 
update billing set country = '224' where country = 'USA' 
update billing set country = '172' where country = 'Pakistan' 
update billing set country = '224' where isnumeric(country) = 0

