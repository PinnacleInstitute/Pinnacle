EXEC [dbo].pts_CheckProc 'pts_Folder_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Folder_Fetch ( 
   @FolderID int,
   @ParentID int OUTPUT,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @DripCampaignID int OUTPUT,
   @FolderName nvarchar (60) OUTPUT,
   @Entity int OUTPUT,
   @Seq int OUTPUT,
   @IsShare bit OUTPUT,
   @Virtual int OUTPUT,
   @Data nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ParentID = fo.ParentID ,
   @CompanyID = fo.CompanyID ,
   @MemberID = fo.MemberID ,
   @DripCampaignID = fo.DripCampaignID ,
   @FolderName = fo.FolderName ,
   @Entity = fo.Entity ,
   @Seq = fo.Seq ,
   @IsShare = fo.IsShare ,
   @Virtual = fo.Virtual ,
   @Data = fo.Data
FROM Folder AS fo (NOLOCK)
WHERE fo.FolderID = @FolderID

GO