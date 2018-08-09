EXEC [dbo].pts_CheckProc 'pts_Message_Update'
GO

CREATE PROCEDURE [dbo].pts_Message_Update
   @MessageID int,
   @ForumID int,
   @ParentID int,
   @ThreadID int,
   @BoardUserID int,
   @ModifyID int,
   @MessageTitle nvarchar (60),
   @Status int,
   @IsSticky bit,
   @Body nvarchar (2000),
   @CreateDate datetime,
   @ChangeDate datetime,
   @ThreadOrder int,
   @Replies int,
   @UserID int
AS

SET         NOCOUNT ON

SET         @ChangeDate = CURRENT_TIMESTAMP
UPDATE   mbm
SET            mbm.ForumID = @ForumID ,
            mbm.ParentID = @ParentID ,
            mbm.ThreadID = @ThreadID ,
            mbm.BoardUserID = @BoardUserID ,
            mbm.ModifyID = @ModifyID ,
            mbm.MessageTitle = @MessageTitle ,
            mbm.Status = @Status ,
            mbm.IsSticky = @IsSticky ,
            mbm.Body = @Body ,
            mbm.CreateDate = @CreateDate ,
            mbm.ChangeDate = @ChangeDate ,
            mbm.ThreadOrder = @ThreadOrder ,
            mbm.Replies = @Replies
FROM      Message AS mbm
WHERE      (mbm.MessageID = @MessageID)


EXEC      pts_Message_UpdateThread
         @ThreadID ,
         @ModifyID ,
         @UserID

GO