EXEC [dbo].pts_CheckProc 'pts_ProjectType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ProjectType_Fetch ( 
   @ProjectTypeID int,
   @CompanyID int OUTPUT,
   @ProjectTypeName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pjt.CompanyID ,
   @ProjectTypeName = pjt.ProjectTypeName ,
   @Seq = pjt.Seq
FROM ProjectType AS pjt (NOLOCK)
WHERE pjt.ProjectTypeID = @ProjectTypeID

GO