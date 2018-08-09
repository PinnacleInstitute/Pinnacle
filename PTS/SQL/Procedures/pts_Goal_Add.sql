EXEC [dbo].pts_CheckProc 'pts_Goal_Add'
 GO

CREATE PROCEDURE [dbo].pts_Goal_Add ( 
   @GoalID int OUTPUT,
   @MemberID int,
   @ParentID int,
   @AssignID int,
   @CompanyID int,
   @ProspectID int,
   @GoalName nvarchar (60),
   @Description nvarchar (2000),
   @GoalType int,
   @Priority int,
   @Status int,
   @CreateDate datetime,
   @CommitDate datetime,
   @CompleteDate datetime,
   @Variance int,
   @RemindDate datetime,
   @Template int,
   @Children int,
   @Qty int,
   @ActQty int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Goal (
            MemberID , 
            ParentID , 
            AssignID , 
            CompanyID , 
            ProspectID , 
            GoalName , 
            Description , 
            GoalType , 
            Priority , 
            Status , 
            CreateDate , 
            CommitDate , 
            CompleteDate , 
            Variance , 
            RemindDate , 
            Template , 
            Children , 
            Qty , 
            ActQty
            )
VALUES (
            @MemberID ,
            @ParentID ,
            @AssignID ,
            @CompanyID ,
            @ProspectID ,
            @GoalName ,
            @Description ,
            @GoalType ,
            @Priority ,
            @Status ,
            @CreateDate ,
            @CommitDate ,
            @CompleteDate ,
            @Variance ,
            @RemindDate ,
            @Template ,
            @Children ,
            @Qty ,
            @ActQty            )

SET @mNewID = @@IDENTITY

SET @GoalID = @mNewID

GO