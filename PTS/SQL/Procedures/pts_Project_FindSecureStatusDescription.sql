EXEC [dbo].pts_CheckProc 'pts_Project_FindSecureStatusDescription'
 GO

CREATE PROCEDURE [dbo].pts_Project_FindSecureStatusDescription ( 
   @SearchText nvarchar (1000),
   @Bookmark nvarchar (1010),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @MemberID int,
   @Secure int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pj.Description, '') + dbo.wtfn_FormatNumber(pj.ProjectID, 10) 'BookMark' ,
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
WHERE ISNULL(pj.Description, '') LIKE '%' + @SearchText + '%'
AND ISNULL(pj.Description, '') + dbo.wtfn_FormatNumber(pj.ProjectID, 10) >= @BookMark
AND         (pj.CompanyID = @CompanyID)
AND         (pj.Status = @Status)
AND         (pj.ParentID = 0)
AND         ((pj.Secure <= @Secure)
OR         (pj.MemberID = @MemberID))
ORDER BY 'Bookmark'

GO