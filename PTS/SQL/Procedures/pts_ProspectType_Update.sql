EXEC [dbo].pts_CheckProc 'pts_ProspectType_Update'
 GO

CREATE PROCEDURE [dbo].pts_ProspectType_Update ( 
   @ProspectTypeID int,
   @CompanyID int,
   @ProspectTypeName nvarchar (40),
   @Seq int,
   @InputOptions nvarchar (1000),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pt
SET pt.CompanyID = @CompanyID ,
   pt.ProspectTypeName = @ProspectTypeName ,
   pt.Seq = @Seq ,
   pt.InputOptions = @InputOptions
FROM ProspectType AS pt
WHERE pt.ProspectTypeID = @ProspectTypeID

GO