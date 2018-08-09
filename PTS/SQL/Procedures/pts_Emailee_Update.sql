EXEC [dbo].pts_CheckProc 'pts_Emailee_Update'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_Update ( 
   @EmaileeID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE eme
SET eme.CompanyID = @CompanyID ,
   eme.EmailListID = @EmailListID ,
   eme.Email = @Email ,
   eme.FirstName = @FirstName ,
   eme.LastName = @LastName ,
   eme.Data1 = @Data1 ,
   eme.Data2 = @Data2 ,
   eme.Data3 = @Data3 ,
   eme.Data4 = @Data4 ,
   eme.Data5 = @Data5 ,
   eme.Status = @Status
FROM Emailee AS eme
WHERE eme.EmaileeID = @EmaileeID

GO