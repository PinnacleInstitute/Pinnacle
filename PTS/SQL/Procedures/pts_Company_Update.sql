EXEC [dbo].pts_CheckProc 'pts_Company_Update'
 GO

CREATE PROCEDURE [dbo].pts_Company_Update ( 
   @CompanyID int,
   @MemberID int,
   @BillingID int,
   @CompanyName nvarchar (60),
   @CompanyType int,
   @Status int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Email nvarchar (80),
   @Email2 nvarchar (80),
   @Email3 nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Fax nvarchar (30),
   @EnrollDate datetime,
   @Subnet nvarchar (20),
   @LostBonusDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE com
SET com.MemberID = @MemberID ,
   com.BillingID = @BillingID ,
   com.CompanyName = @CompanyName ,
   com.CompanyType = @CompanyType ,
   com.Status = @Status ,
   com.NameLast = @NameLast ,
   com.NameFirst = @NameFirst ,
   com.Street = @Street ,
   com.Unit = @Unit ,
   com.City = @City ,
   com.State = @State ,
   com.Zip = @Zip ,
   com.Country = @Country ,
   com.Email = @Email ,
   com.Email2 = @Email2 ,
   com.Email3 = @Email3 ,
   com.Phone1 = @Phone1 ,
   com.Phone2 = @Phone2 ,
   com.Fax = @Fax ,
   com.EnrollDate = @EnrollDate ,
   com.Subnet = @Subnet ,
   com.LostBonusDate = @LostBonusDate
FROM Company AS com
WHERE com.CompanyID = @CompanyID

GO