
UPDATE Org Set Level = 0, Hierarchy = ''
EXEC pts_Org_BuildHierarchy 0, 0, ''
SELECT orgid, orgname, companyid, parentid, hierarchy, [Level] FROM Org

