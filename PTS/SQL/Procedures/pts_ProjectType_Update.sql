EXEC [dbo].pts_CheckProc 'pts_ProjectType_Update'
 GO

CREATE PROCEDURE [dbo].pts_ProjectType_Update ( 
   @ProjectTypeID int,
   @CompanyID int,
   @ProjectTypeName nvarchar (40),
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pjt
SET pjt.CompanyID = @CompanyID ,
   pjt.ProjectTypeName = @ProjectTypeName ,
   pjt.Seq = @Seq
FROM ProjectType AS pjt
WHERE pjt.ProjectTypeID = @ProjectTypeID

GO