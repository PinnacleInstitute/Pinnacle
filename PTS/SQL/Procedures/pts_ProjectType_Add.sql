EXEC [dbo].pts_CheckProc 'pts_ProjectType_Add'
 GO

CREATE PROCEDURE [dbo].pts_ProjectType_Add ( 
   @ProjectTypeID int OUTPUT,
   @CompanyID int,
   @ProjectTypeName nvarchar (40),
   @Seq int,
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
   FROM ProjectType (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO ProjectType (
            CompanyID , 
            ProjectTypeName , 
            Seq
            )
VALUES (
            @CompanyID ,
            @ProjectTypeName ,
            @Seq            )

SET @mNewID = @@IDENTITY

SET @ProjectTypeID = @mNewID

GO