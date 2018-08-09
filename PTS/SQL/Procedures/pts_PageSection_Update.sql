EXEC [dbo].pts_CheckProc 'pts_PageSection_Update'
 GO

CREATE PROCEDURE [dbo].pts_PageSection_Update ( 
   @PageSectionID int,
   @CompanyID int,
   @PageSectionName nvarchar (40),
   @FileName nvarchar (30),
   @Path nvarchar (128),
   @Language nvarchar (6),
   @Width int,
   @Custom int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ps
SET ps.CompanyID = @CompanyID ,
   ps.PageSectionName = @PageSectionName ,
   ps.FileName = @FileName ,
   ps.Path = @Path ,
   ps.Language = @Language ,
   ps.Width = @Width ,
   ps.Custom = @Custom
FROM PageSection AS ps
WHERE ps.PageSectionID = @PageSectionID

GO