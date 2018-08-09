EXEC [dbo].pts_CheckProc 'pts_Task_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Task_Fetch ( 
   @TaskID int,
   @MemberID int OUTPUT,
   @ParentID int OUTPUT,
   @ProjectID int OUTPUT,
   @DependentID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @ProjectName nvarchar (40) OUTPUT,
   @TaskName nvarchar (60) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Status int OUTPUT,
   @Seq int OUTPUT,
   @IsMilestone bit OUTPUT,
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
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ta.MemberID ,
   @ParentID = ta.ParentID ,
   @ProjectID = ta.ProjectID ,
   @DependentID = ta.DependentID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @ProjectName = pj.ProjectName ,
   @TaskName = ta.TaskName ,
   @Description = ta.Description ,
   @Status = ta.Status ,
   @Seq = ta.Seq ,
   @IsMilestone = ta.IsMilestone ,
   @EstStartDate = ta.EstStartDate ,
   @ActStartDate = ta.ActStartDate ,
   @VarStartDate = ta.VarStartDate ,
   @EstEndDate = ta.EstEndDate ,
   @ActEndDate = ta.ActEndDate ,
   @VarEndDate = ta.VarEndDate ,
   @EstCost = ta.EstCost ,
   @TotCost = ta.TotCost ,
   @VarCost = ta.VarCost ,
   @Cost = ta.Cost ,
   @Hrs = ta.Hrs ,
   @TotHrs = ta.TotHrs
FROM Task AS ta (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (ta.MemberID = me.MemberID)
LEFT OUTER JOIN Project AS pj (NOLOCK) ON (ta.ProjectID = pj.ProjectID)
WHERE ta.TaskID = @TaskID

GO