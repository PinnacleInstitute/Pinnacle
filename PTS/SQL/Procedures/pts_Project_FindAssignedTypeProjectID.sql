EXEC [dbo].pts_CheckProc 'pts_Project_FindAssignedTypeProjectID'
 GO

CREATE PROCEDURE [dbo].pts_Project_FindAssignedTypeProjectID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @ProjectTypeID int,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), pj.ProjectID), '') + dbo.wtfn_FormatNumber(pj.ProjectID, 10) 'BookMark' ,
            pj.ProjectID 'ProjectID' ,
            pj.CompanyID 'CompanyID' ,
            pj.MemberID 'MemberID' ,
            pj.ParentID 'ParentID' ,
            pj.ForumID 'ForumID' ,
            pj.ProjectTypeID 'ProjectTypeID' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) 'MemberName' ,
            pjt.ProjectTypeName 'ProjectTypeName' ,
            pj.ProjectName 'ProjectName' ,
            pj.Description 'Description' ,
            pj.Status 'Status' ,
            pj.Seq 'Seq' ,
            pj.IsChat 'IsChat' ,
            pj.IsForum 'IsForum' ,
            pj.Secure 'Secure' ,
            pj.EstStartDate 'EstStartDate' ,
            pj.ActStartDate 'ActStartDate' ,
            pj.VarStartDate 'VarStartDate' ,
            pj.EstEndDate 'EstEndDate' ,
            pj.ActEndDate 'ActEndDate' ,
            pj.VarEndDate 'VarEndDate' ,
            pj.EstCost 'EstCost' ,
            pj.TotCost 'TotCost' ,
            pj.VarCost 'VarCost' ,
            pj.Cost 'Cost' ,
            pj.Hrs 'Hrs' ,
            pj.TotHrs 'TotHrs' ,
            pj.Hierarchy 'Hierarchy' ,
            pj.ChangeDate 'ChangeDate' ,
            pj.RefType 'RefType' ,
            pj.RefID 'RefID'
FROM Project AS pj (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pj.MemberID = me.MemberID)
LEFT OUTER JOIN ProjectType AS pjt (NOLOCK) ON (pj.ProjectTypeID = pjt.ProjectTypeID)
LEFT OUTER JOIN ProjectMember AS pjm (NOLOCK) ON (pj.ProjectID = pjm.ProjectID and @MemberID = pjm.MemberID)
WHERE ISNULL(CONVERT(nvarchar(10), pj.ProjectID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pj.ProjectID), '') + dbo.wtfn_FormatNumber(pj.ProjectID, 10) >= @BookMark
AND         (pj.ProjectTypeID = @ProjectTypeID)
AND         (pj.ParentID = 0)
AND         ((pj.MemberID = @MemberID)
OR         (pjm.MemberID = @MemberID))
ORDER BY 'Bookmark'

GO