EXEC [dbo].pts_CheckProc 'pts_Govid_Add'
 GO

CREATE PROCEDURE [dbo].pts_Govid_Add ( 
   @GovidID int OUTPUT,
   @MemberID int,
   @CountryID int,
   @GType int,
   @GNumber nvarchar (50),
   @Issuer varchar (2),
   @IssueDate datetime,
   @ExpDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Govid (
            MemberID , 
            CountryID , 
            GType , 
            GNumber , 
            Issuer , 
            IssueDate , 
            ExpDate
            )
VALUES (
            @MemberID ,
            @CountryID ,
            @GType ,
            @GNumber ,
            @Issuer ,
            @IssueDate ,
            @ExpDate            )

SET @mNewID = @@IDENTITY

SET @GovidID = @mNewID

GO