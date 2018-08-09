EXEC [dbo].pts_CheckProc 'pts_PageSection_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_PageSection_Fetch ( 
   @PageSectionID int,
   @CompanyID int OUTPUT,
   @PageSectionName nvarchar (40) OUTPUT,
   @FileName nvarchar (30) OUTPUT,
   @Path nvarchar (128) OUTPUT,
   @Language nvarchar (6) OUTPUT,
   @Width int OUTPUT,
   @Custom int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = ps.CompanyID ,
   @PageSectionName = ps.PageSectionName ,
   @FileName = ps.FileName ,
   @Path = ps.Path ,
   @Language = ps.Language ,
   @Width = ps.Width ,
   @Custom = ps.Custom
FROM PageSection AS ps (NOLOCK)
WHERE ps.PageSectionID = @PageSectionID

GO