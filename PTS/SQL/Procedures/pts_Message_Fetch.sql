EXEC [dbo].pts_CheckProc 'pts_Message_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Message_Fetch ( 
   @MessageID int,
   @ForumID int OUTPUT,
   @ParentID int OUTPUT,
   @ThreadID int OUTPUT,
   @BoardUserID int OUTPUT,
   @ModifyID int OUTPUT,
   @ForumName nvarchar (60) OUTPUT,
   @BoardUserName nvarchar (32) OUTPUT,
   @Signature nvarchar (500) OUTPUT,
   @ModifyName nvarchar (32) OUTPUT,
   @MessageTitle nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @IsSticky bit OUTPUT,
   @Body nvarchar (2000) OUTPUT,
   @CreateDate datetime OUTPUT,
   @ChangeDate datetime OUTPUT,
   @ThreadOrder int OUTPUT,
   @Replies int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ForumID = mbm.ForumID ,
   @ParentID = mbm.ParentID ,
   @ThreadID = mbm.ThreadID ,
   @BoardUserID = mbm.BoardUserID ,
   @ModifyID = mbm.ModifyID ,
   @ForumName = mbf.ForumName ,
   @BoardUserName = mbu.BoardUserName ,
   @Signature = mbu.Signature ,
   @ModifyName = mod.BoardUserName ,
   @MessageTitle = mbm.MessageTitle ,
   @Status = mbm.Status ,
   @IsSticky = mbm.IsSticky ,
   @Body = mbm.Body ,
   @CreateDate = mbm.CreateDate ,
   @ChangeDate = mbm.ChangeDate ,
   @ThreadOrder = mbm.ThreadOrder ,
   @Replies = mbm.Replies
FROM Message AS mbm (NOLOCK)
LEFT OUTER JOIN Forum AS mbf (NOLOCK) ON (mbm.ForumID = mbf.ForumID)
LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbm.BoardUserID = mbu.BoardUserID)
LEFT OUTER JOIN BoardUser AS mod (NOLOCK) ON (mbm.ModifyID = mod.BoardUserID)
WHERE mbm.MessageID = @MessageID

GO