EXEC [dbo].pts_CheckProc 'pts_Emailee_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_Fetch ( 
   @EmaileeID int,
   @CompanyID int OUTPUT,
   @EmailListID int OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @FirstName nvarchar (30) OUTPUT,
   @LastName nvarchar (30) OUTPUT,
   @EmaileeName nvarchar (62) OUTPUT,
   @Data1 nvarchar (80) OUTPUT,
   @Data2 nvarchar (80) OUTPUT,
   @Data3 nvarchar (80) OUTPUT,
   @Data4 nvarchar (80) OUTPUT,
   @Data5 nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = eme.CompanyID ,
   @EmailListID = eme.EmailListID ,
   @Email = eme.Email ,
   @FirstName = eme.FirstName ,
   @LastName = eme.LastName ,
   @EmaileeName = LTRIM(RTRIM(eme.LastName)) +  ', '  + LTRIM(RTRIM(eme.FirstName)) ,
   @Data1 = eme.Data1 ,
   @Data2 = eme.Data2 ,
   @Data3 = eme.Data3 ,
   @Data4 = eme.Data4 ,
   @Data5 = eme.Data5 ,
   @Status = eme.Status
FROM Emailee AS eme (NOLOCK)
WHERE eme.EmaileeID = @EmaileeID

GO