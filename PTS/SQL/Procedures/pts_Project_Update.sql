EXEC [dbo].pts_CheckProc 'pts_Project_Update'
 GO

CREATE PROCEDURE [dbo].pts_Project_Update ( 
   @ProjectID int,
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
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pj
SET pj.CompanyID = @CompanyID ,
   pj.MemberID = @MemberID ,
   pj.ParentID = @ParentID ,
   pj.ForumID = @ForumID ,
   pj.ProjectTypeID = @ProjectTypeID ,
   pj.ProjectName = @ProjectName ,
   pj.Description = @Description ,
   pj.Status = @Status ,
   pj.Seq = @Seq ,
   pj.IsChat = @IsChat ,
   pj.IsForum = @IsForum ,
   pj.Secure = @Secure ,
   pj.EstStartDate = @EstStartDate ,
   pj.ActStartDate = @ActStartDate ,
   pj.VarStartDate = @VarStartDate ,
   pj.EstEndDate = @EstEndDate ,
   pj.ActEndDate = @ActEndDate ,
   pj.VarEndDate = @VarEndDate ,
   pj.EstCost = @EstCost ,
   pj.TotCost = @TotCost ,
   pj.VarCost = @VarCost ,
   pj.Cost = @Cost ,
   pj.Hrs = @Hrs ,
   pj.TotHrs = @TotHrs ,
   pj.Hierarchy = @Hierarchy ,
   pj.ChangeDate = @ChangeDate ,
   pj.RefType = @RefType ,
   pj.RefID = @RefID
FROM Project AS pj
WHERE pj.ProjectID = @ProjectID

GO