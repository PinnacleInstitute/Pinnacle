EXEC [dbo].pts_CheckProc 'pts_Message_Add'
GO

CREATE PROCEDURE [dbo].pts_Message_Add
   @MessageID int OUTPUT ,
   @ForumID int ,
   @ParentID int ,
   @ThreadID int ,
   @BoardUserID int ,
   @ModifyID int ,
   @MessageTitle nvarchar (60) ,
   @Status int ,
   @IsSticky bit ,
   @Body nvarchar (2000) ,
   @CreateDate datetime ,
   @ChangeDate datetime ,
   @ThreadOrder int ,
   @Replies int ,
   @UserID int 
   
AS

DECLARE   @mNow datetime, 
         @mThreadOrder int, 
         @mNewID int

SET         NOCOUNT ON

SET         @mNow = CURRENT_TIMESTAMP
IF ((@ThreadID > 0))
   BEGIN
   EXEC      pts_Message_GetThreadPages
            @ThreadID ,
            @UserID ,
            @mThreadOrder OUTPUT

   SET         @ThreadOrder = @mThreadOrder
   END

INSERT INTO   Message (
            ForumID , 
            ParentID , 
            ThreadID , 
            BoardUserID , 
            ModifyID , 
            MessageTitle , 
            Status , 
            IsSticky , 
            Body , 
            CreateDate , 
            ChangeDate , 
            ThreadOrder , 
            Replies 

            )
VALUES      (
            @ForumID ,
            @ParentID ,
            @ThreadID ,
            @BoardUserID ,
            @ModifyID ,
            @MessageTitle ,
            @Status ,
            @IsSticky ,
            @Body ,
            @mNow ,  
            @mNow ,
            @ThreadOrder ,
            @Replies 
            
            )

SET         @mNewID = @@IDENTITY
IF ((@ParentID > 0))
   BEGIN
   EXEC      pts_Message_UpdateThread
            @ThreadID ,
            @BoardUserID ,
            @UserID

   END

IF ((@ParentID = 0))
   BEGIN
   EXEC      pts_Message_Update
            @mNewID ,
            @ForumID ,
            0 ,
            @mNewID ,
            @BoardUserID ,
            @ModifyID ,
            @MessageTitle ,
            @Status ,
            @IsSticky ,
            @Body ,
            @mNow ,
            @mNow ,
            0 ,
            0 ,
            @UserID

   END

SET         @MessageID = ISNULL(@mNewID, 0)
GO