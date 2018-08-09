EXEC [dbo].pts_CheckProc 'pts_Company_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Company_Fetch ( 
   @CompanyID int,
   @MemberID int OUTPUT,
   @BillingID int OUTPUT,
   @CompanyName nvarchar (60) OUTPUT,
   @CompanyType int OUTPUT,
   @Status int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @ContactName nvarchar (62) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Email2 nvarchar (80) OUTPUT,
   @Email3 nvarchar (80) OUTPUT,
   @Phone1 nvarchar (30) OUTPUT,
   @Phone2 nvarchar (30) OUTPUT,
   @Fax nvarchar (30) OUTPUT,
   @EnrollDate datetime OUTPUT,
   @Subnet nvarchar (20) OUTPUT,
   @LostBonusDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = com.MemberID ,
   @BillingID = com.BillingID ,
   @CompanyName = com.CompanyName ,
   @CompanyType = com.CompanyType ,
   @Status = com.Status ,
   @NameLast = com.NameLast ,
   @NameFirst = com.NameFirst ,
   @ContactName = LTRIM(RTRIM(com.NameLast)) +  ', '  + LTRIM(RTRIM(com.NameFirst)) ,
   @Street = com.Street ,
   @Unit = com.Unit ,
   @City = com.City ,
   @State = com.State ,
   @Zip = com.Zip ,
   @Country = com.Country ,
   @Email = com.Email ,
   @Email2 = com.Email2 ,
   @Email3 = com.Email3 ,
   @Phone1 = com.Phone1 ,
   @Phone2 = com.Phone2 ,
   @Fax = com.Fax ,
   @EnrollDate = com.EnrollDate ,
   @Subnet = com.Subnet ,
   @LostBonusDate = com.LostBonusDate
FROM Company AS com (NOLOCK)
WHERE com.CompanyID = @CompanyID

GO