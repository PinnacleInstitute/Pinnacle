EXEC [dbo].pts_CheckProc 'pts_Issue_Add'
 GO

CREATE PROCEDURE [dbo].pts_Issue_Add ( 
   @IssueID int OUTPUT,
   @CompanyID int,
   @IssueCategoryID int,
   @SubmitID int,
   @IssueDate datetime,
   @IssueName nvarchar (60),
   @SubmittedBy nvarchar (40),
   @SubmitType int,
   @Priority int,
   @Description nvarchar (1000),
   @AssignedTo nvarchar (15),
   @Status int,
   @Notes nvarchar (2000),
   @ChangeDate datetime,
   @DueDate datetime,
   @DoneDate datetime,
   @Variance int,
   @InputValues nvarchar (500),
   @Rating int,
   @Outsource nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Issue (
            CompanyID , 
            IssueCategoryID , 
            SubmitID , 
            IssueDate , 
            IssueName , 
            SubmittedBy , 
            SubmitType , 
            Priority , 
            Description , 
            AssignedTo , 
            Status , 
            Notes , 
            ChangeDate , 
            DueDate , 
            DoneDate , 
            Variance , 
            InputValues , 
            Rating , 
            Outsource
            )
VALUES (
            @CompanyID ,
            @IssueCategoryID ,
            @SubmitID ,
            @IssueDate ,
            @IssueName ,
            @SubmittedBy ,
            @SubmitType ,
            @Priority ,
            @Description ,
            @AssignedTo ,
            @Status ,
            @Notes ,
            @ChangeDate ,
            @DueDate ,
            @DoneDate ,
            @Variance ,
            @InputValues ,
            @Rating ,
            @Outsource            )

SET @mNewID = @@IDENTITY

SET @IssueID = @mNewID

GO