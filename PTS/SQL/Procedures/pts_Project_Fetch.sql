EXEC [dbo].pts_CheckProc 'pts_Project_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Project_Fetch ( 
   @ProjectID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @ParentID int OUTPUT,
   @ForumID int OUTPUT,
   @ProjectTypeID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @ProjectTypeName nvarchar (40) OUTPUT,
   @ProjectName nvarchar (60) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Status int OUTPUT,
   @Seq int OUTPUT,
   @IsChat bit OUTPUT,
   @IsForum bit OUTPUT,
   @Secure int OUTPUT,
   @EstStartDate datetime OUTPUT,
   @ActStartDate datetime OUTPUT,
   @VarStartDate int OUTPUT,
   @EstEndDate datetime OUTPUT,
   @ActEndDate datetime OUTPUT,
   @VarEndDate int OUTPUT,
   @EstCost money OUTPUT,
   @TotCost money OUTPUT,
   @VarCost money OUTPUT,
   @Cost money OUTPUT,
   @Hrs money OUTPUT,
   @TotHrs money OUTPUT,
   @Hierarchy varchar (30) OUTPUT,
   @ChangeDate datetime OUTPUT,
   @RefType int OUTPUT,
   @RefID int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pj.CompanyID ,
   @MemberID = pj.MemberID ,
   @ParentID = pj.ParentID ,
   @ForumID = pj.ForumID ,
   @ProjectTypeID = pj.ProjectTypeID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @ProjectTypeName = pjt.ProjectTypeName ,
   @ProjectName = pj.ProjectName ,
   @Description = pj.Description ,
   @Status = pj.Status ,
   @Seq = pj.Seq ,
   @IsChat = pj.IsChat ,
   @IsForum = pj.IsForum ,
   @Secure = pj.Secure ,
   @EstStartDate = pj.EstStartDate ,
   @ActStartDate = pj.ActStartDate ,
   @VarStartDate = pj.VarStartDate ,
   @EstEndDate = pj.EstEndDate ,
   @ActEndDate = pj.ActEndDate ,
   @VarEndDate = pj.VarEndDate ,
   @EstCost = pj.EstCost ,
   @TotCost = pj.TotCost ,
   @VarCost = pj.VarCost ,
   @Cost = pj.Cost ,
   @Hrs = pj.Hrs ,
   @TotHrs = pj.TotHrs ,
   @Hierarchy = pj.Hierarchy ,
   @ChangeDate = pj.ChangeDate ,
   @RefType = pj.RefType ,
   @RefID = pj.RefID
FROM Project AS pj (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pj.MemberID = me.MemberID)
LEFT OUTER JOIN ProjectType AS pjt (NOLOCK) ON (pj.ProjectTypeID = pjt.ProjectTypeID)
WHERE pj.ProjectID = @ProjectID

GO