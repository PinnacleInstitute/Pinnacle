
DECLARE @ID int

--PageSectionID, PageSectionName, FileName, Path, Language, Width, Custom, UserID
EXEC pts_PageSection_Add @ID, 'Home Page',       '0000.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Training',        '0011.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'About Pinnacle',  '0012.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Management Team', '0013.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Contact Us',      '0014.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Sales',           '0020.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Compensation',            '0021.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Affiliate Agreement',     '0022.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Policies and Procedures', '0023.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Formula for Success',     '0024.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Member Home Page',     '0404.htm', '', 'en', 750, 2, 1
EXEC pts_PageSection_Add @ID, 'Trainer Home Page',     '0305.htm', '', 'en', 750, 2, 1

GO
