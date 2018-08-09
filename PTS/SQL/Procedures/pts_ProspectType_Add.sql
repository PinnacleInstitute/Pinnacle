EXEC [dbo].pts_CheckProc 'pts_ProspectType_Add'
 GO

CREATE PROCEDURE [dbo].pts_ProspectType_Add ( 
   @ProspectTypeID int OUTPUT,
   @CompanyID int,
   @ProspectTypeName nvarchar (40),
   @Seq int,
   @InputOptions nvarchar (1000),
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
   FROM ProspectType (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO ProspectType (
            CompanyID , 
            ProspectTypeName , 
            Seq , 
            InputOptions
            )
VALUES (
            @CompanyID ,
            @ProspectTypeName ,
            @Seq ,
            @InputOptions            )

SET @mNewID = @@IDENTITY

SET @ProspectTypeID = @mNewID

GO