EXEC [dbo].pts_CheckProc 'pts_LeadAd_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_Fetch ( 
   @LeadAdID int,
   @CompanyID int OUTPUT,
   @GroupID int OUTPUT,
   @LeadAdName nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @Target nvarchar (30) OUTPUT,
   @Link nvarchar (500) OUTPUT,
   @Seq int OUTPUT,
   @Image nvarchar (25) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = la.CompanyID ,
   @GroupID = la.GroupID ,
   @LeadAdName = la.LeadAdName ,
   @Status = la.Status ,
   @Target = la.Target ,
   @Link = la.Link ,
   @Seq = la.Seq ,
   @Image = la.Image
FROM LeadAd AS la (NOLOCK)
WHERE la.LeadAdID = @LeadAdID

GO