EXEC [dbo].pts_CheckProc 'pts_Emailee_Add'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_Add ( 
   @EmaileeID int OUTPUT,
   @CompanyID int,
   @EmailListID int,
   @Email nvarchar (80),
   @FirstName nvarchar (30),
   @LastName nvarchar (30),
   @Data1 nvarchar (80),
   @Data2 nvarchar (80),
   @Data3 nvarchar (80),
   @Data4 nvarchar (80),
   @Data5 nvarchar (80),
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Emailee (
            CompanyID , 
            EmailListID , 
            Email , 
            FirstName , 
            LastName , 
            Data1 , 
            Data2 , 
            Data3 , 
            Data4 , 
            Data5 , 
            Status
            )
VALUES (
            @CompanyID ,
            @EmailListID ,
            @Email ,
            @FirstName ,
            @LastName ,
            @Data1 ,
            @Data2 ,
            @Data3 ,
            @Data4 ,
            @Data5 ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @EmaileeID = @mNewID

GO