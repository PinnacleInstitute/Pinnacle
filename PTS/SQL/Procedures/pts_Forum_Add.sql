EXEC [dbo].pts_CheckProc 'pts_Forum_Add'
GO

CREATE PROCEDURE [dbo].pts_Forum_Add
   @ForumID int OUTPUT,
   @ParentID int,
   @ForumName nvarchar (60),
   @Seq int,
   @Description nvarchar (500),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO Forum (
            ParentID , 
            ForumName , 
            Seq , 
            Description

            )
VALUES (
            @ParentID ,
            @ForumName ,
            @Seq ,
            @Description
            )

SET @mNewID = @@IDENTITY
SET @ForumID = @mNewID
GO