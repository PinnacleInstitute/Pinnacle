EXEC [dbo].pts_CheckProc 'pts_EmailList_Add'
 GO

CREATE PROCEDURE [dbo].pts_EmailList_Add ( 
   @EmailListID int OUTPUT,
   @CompanyID int,
   @EmailSourceID int,
   @EmailListName nvarchar (60),
   @SourceType int,
   @CustomID int,
   @Param1 nvarchar (30),
   @Param2 nvarchar (30),
   @Param3 nvarchar (30),
   @Param4 nvarchar (30),
   @Param5 nvarchar (30),
   @Unsubscribe bit,
   @Query varchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO EmailList (
            CompanyID , 
            EmailSourceID , 
            EmailListName , 
            SourceType , 
            CustomID , 
            Param1 , 
            Param2 , 
            Param3 , 
            Param4 , 
            Param5 , 
            Unsubscribe , 
            Query
            )
VALUES (
            @CompanyID ,
            @EmailSourceID ,
            @EmailListName ,
            @SourceType ,
            @CustomID ,
            @Param1 ,
            @Param2 ,
            @Param3 ,
            @Param4 ,
            @Param5 ,
            @Unsubscribe ,
            @Query            )

SET @mNewID = @@IDENTITY

SET @EmailListID = @mNewID

GO