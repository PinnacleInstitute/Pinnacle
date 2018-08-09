EXEC [dbo].pts_CheckProc 'pts_ProspectType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ProspectType_Fetch ( 
   @ProspectTypeID int,
   @CompanyID int OUTPUT,
   @ProspectTypeName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @InputOptions nvarchar (1000) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pt.CompanyID ,
   @ProspectTypeName = pt.ProspectTypeName ,
   @Seq = pt.Seq ,
   @InputOptions = pt.InputOptions
FROM ProspectType AS pt (NOLOCK)
WHERE pt.ProspectTypeID = @ProspectTypeID

GO