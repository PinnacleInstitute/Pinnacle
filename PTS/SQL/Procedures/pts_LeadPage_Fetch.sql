EXEC [dbo].pts_CheckProc 'pts_LeadPage_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_LeadPage_Fetch ( 
   @LeadPageID int,
   @LeadCampaignID int OUTPUT,
   @LeadPageName nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @Seq int OUTPUT,
   @IsInput bit OUTPUT,
   @IsCapture bit OUTPUT,
   @IsProspect bit OUTPUT,
   @IsNext bit OUTPUT,
   @NextCaption nvarchar (40) OUTPUT,
   @Inputs nvarchar (1000) OUTPUT,
   @Language varchar (6) OUTPUT,
   @IsLeadURL bit OUTPUT,
   @IsRedirectURL bit OUTPUT,
   @LeadURL varchar (200) OUTPUT,
   @RedirectURL varchar (200) OUTPUT,
   @TopCode varchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @LeadCampaignID = lp.LeadCampaignID ,
   @LeadPageName = lp.LeadPageName ,
   @Status = lp.Status ,
   @Seq = lp.Seq ,
   @IsInput = lp.IsInput ,
   @IsCapture = lp.IsCapture ,
   @IsProspect = lp.IsProspect ,
   @IsNext = lp.IsNext ,
   @NextCaption = lp.NextCaption ,
   @Inputs = lp.Inputs ,
   @Language = lp.Language ,
   @IsLeadURL = lp.IsLeadURL ,
   @IsRedirectURL = lp.IsRedirectURL ,
   @LeadURL = lp.LeadURL ,
   @RedirectURL = lp.RedirectURL ,
   @TopCode = lp.TopCode
FROM LeadPage AS lp (NOLOCK)
WHERE lp.LeadPageID = @LeadPageID

GO