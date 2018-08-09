EXEC [dbo].pts_CheckProc 'pts_PageSection_Add'
 GO

CREATE PROCEDURE [dbo].pts_PageSection_Add ( 
   @PageSectionID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO PageSection (
            CompanyID , 
            PageSectionName , 
            FileName , 
            Path , 
            Language , 
            Width , 
            Custom
            )
VALUES (
            @CompanyID ,
            @PageSectionName ,
            @FileName ,
            @Path ,
            @Language ,
            @Width ,
            @Custom            )

SET @mNewID = @@IDENTITY

SET @PageSectionID = @mNewID

GO