EXEC [dbo].pts_CheckProc 'pts_Task_Update'
 GO

CREATE PROCEDURE [dbo].pts_Task_Update ( 
   @TaskID int,
   @MemberID int,
   @ParentID int,
   @ProjectID int,
   @DependentID int,
   @TaskName nvarchar (60),
   @Description nvarchar (1000),
   @Status int,
   @Seq int,
   @IsMilestone bit,
   @EstStartDate datetime,
   @ActStartDate datetime,
   @VarStartDate int,
   @EstEndDate datetime,
   @ActEndDate datetime,
   @VarEndDate int,
   @EstCost money,
   @TotCost money,
   @VarCost money,
   @Cost money,
   @Hrs money,
   @TotHrs money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ta
SET ta.MemberID = @MemberID ,
   ta.ParentID = @ParentID ,
   ta.ProjectID = @ProjectID ,
   ta.DependentID = @DependentID ,
   ta.TaskName = @TaskName ,
   ta.Description = @Description ,
   ta.Status = @Status ,
   ta.Seq = @Seq ,
   ta.IsMilestone = @IsMilestone ,
   ta.EstStartDate = @EstStartDate ,
   ta.ActStartDate = @ActStartDate ,
   ta.VarStartDate = @VarStartDate ,
   ta.EstEndDate = @EstEndDate ,
   ta.ActEndDate = @ActEndDate ,
   ta.VarEndDate = @VarEndDate ,
   ta.EstCost = @EstCost ,
   ta.TotCost = @TotCost ,
   ta.VarCost = @VarCost ,
   ta.Cost = @Cost ,
   ta.Hrs = @Hrs ,
   ta.TotHrs = @TotHrs
FROM Task AS ta
WHERE ta.TaskID = @TaskID

GO