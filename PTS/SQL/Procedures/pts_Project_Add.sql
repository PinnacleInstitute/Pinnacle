EXEC [dbo].pts_CheckProc 'pts_Project_Add'
GO

CREATE PROCEDURE [dbo].pts_Project_Add
   @ProjectID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @ParentID int,
   @ForumID int,
   @ProjectTypeID int,
   @ProjectName nvarchar (60),
   @Description nvarchar (1000),
   @Status int,
   @Seq int,
   @IsChat bit,
   @IsForum bit,
   @Secure int,
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
   @Hierarchy varchar (30),
   @ChangeDate datetime,
   @RefType int,
   @RefID int,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int, 
         @mForumID int, 
         @mBoardUserID int, 
         @mForumModeratorID int

SET NOCOUNT ON

SET @mNow = GETDATE()
SET @mForumID = 0
EXEC pts_Forum_Add
   @mForumID OUTPUT ,
   0 ,
   @ProjectName ,
   0 ,
   '' ,
   @UserID

SET @ForumID = ISNULL(@mForumID, 0)
INSERT INTO Project (
            CompanyID , 
            MemberID , 
            ParentID , 
            ForumID , 
            ProjectTypeID , 
            ProjectName , 
            Description , 
            Status , 
            Seq , 
            IsChat , 
            IsForum , 
            Secure , 
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
            TotHrs , 
            Hierarchy , 
            ChangeDate , 
            RefType , 
            RefID

            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @ParentID ,
            @ForumID ,
            @ProjectTypeID ,
            @ProjectName ,
            @Description ,
            @Status ,
            @Seq ,
            @IsChat ,
            @IsForum ,
            @Secure ,
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
            @TotHrs ,
            @Hierarchy ,
            @ChangeDate ,
            @RefType ,
            @RefID
            )

SET @mNewID = @@IDENTITY
SET @ProjectID = @mNewID
SET @ForumID = @mForumID
GO