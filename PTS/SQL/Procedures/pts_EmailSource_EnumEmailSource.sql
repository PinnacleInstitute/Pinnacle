EXEC [dbo].pts_CheckProc 'pts_EmailSource_EnumEmailSource'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_EnumEmailSource ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECTFROM EmailSource AS ems (NOLOCK)

GO