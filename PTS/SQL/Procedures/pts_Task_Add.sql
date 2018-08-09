EXEC [dbo].pts_CheckProc 'pts_Task_Add'
 GO

CREATE PROCEDURE [dbo].pts_Task_Add ( 
   @TaskID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Task (
            MemberID , 
            ParentID , 
            ProjectID , 
            DependentID , 
            TaskName , 
            Description , 
            Status , 
            Seq , 
            IsMilestone , 
            EstStartDate , 
            ActStartDate , 
            VarStartDate , 
            EstEndDate , 
            ActEndDate , 
            VarEndDate , 
            EstCost , 
            TotCost , 
            VarCost , 
            Cost , 
            Hrs , 
            TotHrs
            )
VALUES (
            @MemberID ,
            @ParentID ,
            @ProjectID ,
            @DependentID ,
            @TaskName ,
            @Description ,
            @Status ,
            @Seq ,
            @IsMilestone ,
            @EstStartDate ,
            @ActStartDate ,
            @VarStartDate ,
            @EstEndDate ,
            @ActEndDate ,
            @VarEndDate ,
            @EstCost ,
            @TotCost ,
            @VarCost ,
            @Cost ,
            @Hrs ,
            @TotHrs            )

SET @mNewID = @@IDENTITY

SET @TaskID = @mNewID

GO