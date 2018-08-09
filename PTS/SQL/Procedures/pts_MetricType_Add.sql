EXEC [dbo].pts_CheckProc 'pts_MetricType_Add'
 GO

CREATE PROCEDURE [dbo].pts_MetricType_Add ( 
   @MetricTypeID int OUTPUT,
   @CompanyID int,
   @GroupID int,
   @MetricTypeName nvarchar (40),
   @Seq int,
   @Pts int,
   @IsActive bit,
   @IsResult bit,
   @IsLeader bit,
   @IsQty bit,
   @Description nvarchar (200),
   @Required nvarchar (200),
   @InputOptions nvarchar (1000),
   @AutoEvent int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM MetricType (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO MetricType (
            CompanyID , 
            GroupID , 
            MetricTypeName , 
            Seq , 
            Pts , 
            IsActive , 
            IsResult , 
            IsLeader , 
            IsQty , 
            Description , 
            Required , 
            InputOptions , 
            AutoEvent
            )
VALUES (
            @CompanyID ,
            @GroupID ,
            @MetricTypeName ,
            @Seq ,
            @Pts ,
            @IsActive ,
            @IsResult ,
            @IsLeader ,
            @IsQty ,
            @Description ,
            @Required ,
            @InputOptions ,
            @AutoEvent            )

SET @mNewID = @@IDENTITY

SET @MetricTypeID = @mNewID

GO