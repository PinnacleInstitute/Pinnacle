EXEC [dbo].pts_CheckProc 'pts_LeadAd_Update'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_Update ( 
   @LeadAdID int,
   @CompanyID int,
   @GroupID int,
   @LeadAdName nvarchar (60),
   @Status int,
   @Target nvarchar (30),
   @Link nvarchar (500),
   @Seq int,
   @Image nvarchar (25),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE la
SET la.CompanyID = @CompanyID ,
   la.GroupID = @GroupID ,
   la.LeadAdName = @LeadAdName ,
   la.Status = @Status ,
   la.Target = @Target ,
   la.Link = @Link ,
   la.Seq = @Seq ,
   la.Image = @Image
FROM LeadAd AS la
WHERE la.LeadAdID = @LeadAdID

GO